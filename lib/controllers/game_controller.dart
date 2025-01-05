// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shed/models/card_item.dart';

enum Turn { initial, player, ai }

class GameController extends GetxController {
  var deck = <CardItem>[].obs;
  var discarded = <CardItem>[].obs;
  var playerHand = <CardItem>[].obs;
  var playerFaceUp = <CardItem>[].obs;
  var playerFaceDown = <CardItem>[].obs;
  var aiHand = <CardItem>[].obs;
  var aiFaceUp = <CardItem>[].obs;
  var aiFaceDown = <CardItem>[].obs;
  var gameStarted = false.obs;
  var selectedCards = <CardItem>[].obs;
  var currentTurn = Turn.initial.obs;
  var gameButton = true.obs;
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
    gameButton.value = false;
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
    currentTurn.value = Turn.initial;
  }

  void nextTurn() {
    print(currentTurn.value.toString());
    if (currentTurn.value == Turn.ai) {
      aiTurn().then((_) {
        nextTurn();
      });
    }
    if (currentTurn.value == Turn.player) {
      playerTurn();
    }
  }

  void playerTurn() {
    if (playerHand.isEmpty && deck.isEmpty) {
      for (CardItem card in playerFaceUp) {
        playerHand.add(card);
        playerFaceUp.remove(card);
      }
    }
    final validMoves = playerHand.where((card) => isValidMove(card)).toList();
    if (validMoves.isEmpty) {
      noValidMoves(playerHand, Turn.ai);
      nextTurn();
    }
  }

  Future<void> aiTurn() async {
    if (currentTurn.value == Turn.ai) {
      Get.snackbar(
        '',
        '',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.grey,
        colorText: Colors.yellow,
        messageText: const Text(
          'Ai is taking its turn.',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.yellowAccent),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      final validMoves = aiHand.where((card) => isValidMove(card)).toList();

      if (validMoves.isEmpty) {
        noValidMoves(aiHand, Turn.player);
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
      print('AI hand: ${aiHand.toJson().toString()}');
      print('AI vmoves: $validMoves');
      final selectedCard = validMoves.first;
      print('Ai selected: $selectedCard');
      aiHand.remove(selectedCard);
      discarded.add(selectedCard);
      print('Discarded pile: ${discarded.toJson().toString()}');

      discardPileImage.value = discarded.last.imagePath;

      while (aiHand.length < 4 && deck.isNotEmpty) {
        aiHand.add(getRandomCard());
      }
      if (selectedCard.rank == 'T') {
        discarded.clear();
        discardPileImage.value = 'assets/images/1B.png';
        currentTurn.value = Turn.ai;
        return;
      }
      if (deck.isEmpty && aiHand.isEmpty) {
        if (aiFaceUp.isNotEmpty) {
          aiHand.addAll(aiFaceUp);
          aiFaceUp.clear();
        } else {
          aiHand.add(aiFaceDown.removeLast());
        }
      }
      currentTurn.value = Turn.player;
    }
  }

  void selectCard(CardItem card) {
    if (selectedCards.length >= 4 && !card.isSelected) {
      Get.snackbar('', 'You cannot select more than 4 cards.');
      return;
    }
    if (!isValidMove(card)) return;
    card.isSelected = !card.isSelected;
    if (selectedCards.contains(card)) {
      selectedCards.remove(card);
    } else {
      selectedCards.add(card);
    }
    playerHand.refresh();
    print(selectedCards.toJson().toString());
    selectedCards.isNotEmpty
        ? discardButton.value = true
        : discardButton.value = false;
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
      } else {
        if (allSameRank) {
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
        } else {
          Get.snackbar('', 'You can only discard cards of the same value.');
        }
      }
      playerHand.refresh();
      selectedCards.clear();
      discardButton.value = false;
      if (currentTurn.value != Turn.initial) {
        currentTurn.value = Turn.ai;
      }
      if (playerFaceUp.length == 4 && currentTurn.value == Turn.initial) {
        currentTurn.value = determineStartingPlayer();
        gameStarted.value = true;
      }
      nextTurn();
    } else {
      Get.snackbar(
        '',
        'Choose one or more cards!',
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool isValidMove(CardItem card) {
    if (currentTurn.value == Turn.initial) return true;
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

  void noValidMoves(RxList<CardItem> hand, Turn turn) {
    hand.addAll(discarded);
    discarded.clear();
    discardPileImage.value = 'assets/images/1B.png';
    currentTurn.value = turn;
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
    return deck.removeAt(Random().nextInt(deck.length));
  }

  void sortPlayerHand() {
    playerHand.sort((a, b) => ranks.indexOf(a.rank) - ranks.indexOf(b.rank));
  }
}
