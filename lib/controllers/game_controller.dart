// ignore_for_file: avoid_print

import 'dart:math';
import 'package:get/get.dart';
import 'package:shed/models/card_item.dart';

enum Turn { player, ai }

class GameController extends GetxController {
  var deck = <CardItem>[].obs;
  var discarded = <CardItem>[].obs;
  var playerHand = <CardItem>[].obs;
  var playerFaceUp = <CardItem>[].obs;
  var playerFaceDown = <CardItem>[].obs;
  var aiHand = <CardItem>[].obs;
  var aiFaceUp = <CardItem>[].obs;
  var aiFaceDown = <CardItem>[].obs;
  var firstTurn = true.obs;
  var gameStarted = false.obs;
  var selectedCards = <CardItem>[].obs;
  var currentTurn = Turn.player.obs;
  var discardButton = false.obs;
  var discardPileImage = 'assets/images/1B.png'.obs;
  List<String> suits = ["C", "D", "H", "S"];
  List<String> ranks = [
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "T",
    "J",
    "Q",
    "K",
    "A"
  ];

  void initializeDeck() {
    deck.clear();
    for (var suit in suits) {
      for (var rank in ranks) {
        deck.add(CardItem(rank: rank, suit: suit));
      }
    }
    deck.shuffle();
  }

  void initialDeal() {
    for (var i = 0; i < 24; i++) {
      CardItem card = getRandomCard();
      if (i < 4) {
        playerFaceDown.add(card);
      } else if (i < 12) {
        playerHand.add(card); // Deal 8 cards to the player's hand
      } else if (i < 16) {
        aiFaceDown.add(card); // Deal 4 cards face-down to AI
      } else {
        aiHand.add(card); // Deal 8 cards to AI's hand
      }
    }

    // Sort AI's face-up cards to pick the 4 highest ranked ones
    aiHand.sort((a, b) => ranks.indexOf(b.rank) - ranks.indexOf(a.rank));
    aiFaceUp.assignAll(aiHand.take(4));
    aiFaceUp.refresh();
    aiHand.removeRange(0, 4);

    sortPlayerHand();
  }

  void resetGame() {
    deck.clear();
    discarded.clear();
    selectedCards.clear();
    playerHand.clear();
    playerFaceUp.clear();
    playerFaceDown.clear();
    aiHand.clear();
    aiFaceUp.clear();
    aiFaceDown.clear();

    gameStarted.value = false;
    firstTurn.value = true;
    currentTurn.value = Turn.player;
  }

  void nextTurn() {
    if (currentTurn.value == Turn.ai) {
      aiTurn().then((_) {
        nextTurn();
      });
    }
  }

  Future<void> aiTurn() async {
    await Future.delayed(const Duration(seconds: 2));
    if (currentTurn.value == Turn.ai) {
      Get.snackbar('Turn', 'Ai is taking its turn.',
          duration: const Duration(seconds: 2));
      final validMoves = aiHand.where((card) => isValidMove(card)).toList();
      print('hand: ${aiHand.toJson()}');
      print('vmoves: $validMoves');
      print('discarded: ${discarded.toJson()}');
      if (validMoves.isEmpty) {
        Get.snackbar("AI Turn", "AI has to take the discard pile.");
        for (CardItem card in discarded) {
          aiHand.add(card);
        }
        discarded.clear();
        discardPileImage.value = 'assets/images/1B.png';
        return;
      }

      if (discarded.isEmpty) {
        validMoves
            .sort((a, b) => ranks.indexOf(a.rank) - ranks.indexOf(b.rank));
      } else {
        final lastDiscardedCard = discarded.last;
        validMoves.sort((a, b) {
          return (ranks.indexOf(a.rank) -
                  ranks.indexOf(lastDiscardedCard.rank)) -
              (ranks.indexOf(b.rank) - ranks.indexOf(lastDiscardedCard.rank));
        });
      }

      final selectedCard = validMoves.first;
      aiHand.remove(selectedCard);
      discarded.add(selectedCard);

      discardPileImage.value = discarded.last.imagePath;

      if (selectedCard.rank == 'T') {
        discarded.clear();
        discardPileImage.value = 'assets/images/1B.png';
      }

      while (aiHand.length < 4) {
        aiHand.add(getRandomCard());
      }
    }
  }

  void selectCard(CardItem card) {
    if (selectedCards.isNotEmpty) discardButton.value = true;
    if (selectedCards.length > 4) {
      Get.snackbar('', 'You cannot select more than 4 cards.');
      return;
    }
    card.isSelected = !card.isSelected;
    if (selectedCards.contains(card)) {
      selectedCards.remove(card);
    } else {
      selectedCards.add(card);
    }
    playerHand.refresh();
  }

  void discardSelectedCards() {
    if (currentTurn.value == Turn.ai) return;
    if (selectedCards.isNotEmpty) {
      var rank = selectedCards.first.rank;
      var allSameRank = selectedCards.every((card) => card.rank == rank);
      if (playerFaceUp.length < 4) {
        for (var card in selectedCards) {
          playerFaceUp.add(card);
          playerHand.remove(card);
        }
        playerFaceUp.refresh();
      } else if (allSameRank) {
        for (var card in selectedCards) {
          discarded.add(card);
          playerHand.remove(card);
        }
        while (playerHand.length < 4) {
          CardItem card = getRandomCard();
          playerHand.add(card);
        }
        discardPileImage.value = discarded.last.imagePath;
        sortPlayerHand();
      }
      playerHand.refresh();
      selectedCards.clear();
    } else {
      Get.snackbar(
        '',
        'Choose one or more cards!',
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool isValidMove(CardItem card) {
    if (discarded.isEmpty) return true;
    if (card.rank == '2' || card.rank == 'T') return true;
    CardItem lastDiscardedCard = discarded.last;
    bool isValid =
        ranks.indexOf(card.rank) >= ranks.indexOf(lastDiscardedCard.rank);
    if (lastDiscardedCard.rank == '5') {
      isValid =
          ranks.indexOf(card.rank) <= ranks.indexOf(lastDiscardedCard.rank);
    }
    return isValid;
  }

  String? findLowestValidStartingCard(RxList<CardItem> hand) {
    List<String> validRanks =
        ranks.where((rank) => !['2', '5', '10'].contains(rank)).toList();

    for (String rank in validRanks) {
      if (hand.any((card) => card.rank == rank)) {
        return rank;
      }
    }
    return null;
  }

  Turn determineStartingPlayer() {
    bool playerHasThree = playerHand.any((card) => card.rank == '3');
    bool aiHasThree = aiHand.any((card) => card.rank == '3');

    if (playerHasThree && !aiHasThree) {
      return Turn.player;
    } else if (!playerHasThree && aiHasThree) {
      return Turn.ai;
    }

    String? playerLowestCard = findLowestValidStartingCard(playerHand);
    String? aiLowestCard = findLowestValidStartingCard(aiHand);

    if (playerLowestCard != null && aiLowestCard != null) {
      int playerLowestCardIndex = ranks.indexOf(playerLowestCard);
      int aiLowestCardIndex = ranks.indexOf(aiLowestCard);

      if (playerLowestCardIndex < aiLowestCardIndex) {
        return Turn.player;
      } else if (playerLowestCardIndex > aiLowestCardIndex) {
        return Turn.ai;
      }
    }

    return Turn.player;
  }

  CardItem getRandomCard() {
    final random = Random();
    final randomIndex = random.nextInt(deck.length);
    return deck.removeAt(randomIndex);
  }

  void sortPlayerHand() {
    playerHand.sort((a, b) => ranks.indexOf(a.rank) - ranks.indexOf(b.rank));
  }
}
