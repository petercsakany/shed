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
  var currentTurn = ''.obs;
  var firstTurn = true.obs;
  var gameStarted = false.obs;
  var selectedCards = <CardItem>[].obs;
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
    gameStarted.value = true;
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
  }

  CardItem getRandomCard() {
    final random = Random();
    final randomIndex = random.nextInt(deck.length);
    return deck.removeAt(randomIndex);
  }

  void sortPlayerHand() {
    playerHand.sort((a, b) => ranks.indexOf(a.rank) - ranks.indexOf(b.rank));
  }

  void selectCard(CardItem card) {
    card.isSelected = !card.isSelected;
    if (selectedCards.contains(card)) {
      selectedCards.remove(card);
    } else {
      selectedCards.add(card);
    }
    playerHand.refresh();
  }

  void discardSelectedCards() {
    if (selectedCards.isNotEmpty) {
      var rank = selectedCards[0].rank;
      var allSameRank = selectedCards.every((card) => card.rank == rank);
      if (playerFaceUp.length < 4) {
        for (var card in selectedCards) {
          playerFaceUp.add(card);
          playerHand.remove(card);
        }
        playerFaceUp.refresh();
        playerHand.refresh();
        selectedCards.clear();
      } else if (allSameRank) {
        for (var card in selectedCards) {
          discarded.add(card);
          playerHand.remove(card);
        }
        playerHand.refresh();
        selectedCards.clear();
      }
    } else {
      Get.snackbar(
        '',
        'Choose one or more cards!',
        duration: const Duration(seconds: 2),
      );
    }
  }
}
