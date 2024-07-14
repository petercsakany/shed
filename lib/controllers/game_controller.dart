import 'dart:math';

import 'package:get/get.dart';
import 'package:shed/models/card.dart';

class GameController extends GetxController {
  var deck = <Card>[].obs;
  var discarded = <Card>[].obs;
  var playerHand = <Card>[].obs;
  var playerFaceUp = <Card>[].obs;
  var playerFaceDown = <Card>[].obs;
  var aiHand = <Card>[].obs;
  var aiFaceUp = <Card>[].obs;
  var aiFaceDown = <Card>[].obs;
  var currentTurn = ''.obs;
  var firstTurn = true.obs;
  var gameStarted = false.obs;
  var selectedCards = <Card>[].obs;
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

  // Initialize the deck and shuffle
  void initializeDeck() {
    // ignore: avoid_print
    print('Initialize deck');
    deck.clear();
    for (var suit in suits) {
      for (var rank in ranks) {
        deck.add(Card(rank: rank, suit: suit));
      }
    }
    deck.shuffle();
  }

  void initialDeal() {
    // ignore: avoid_print
    print('Initial deal');
    for (var i = 0; i < 24; i++) {
      Card card = getRandomCard();
      if (i < 4) {
        playerFaceDown.add(card);
      } else if (i < 12) {
        playerHand.add(card); // Deal 8 cards to the player's hand
        addCardToContainer(card, 'inHandContainer', true);
      } else if (i < 16) {
        aiFaceDown.add(card); // Deal 4 cards face-down to AI
      } else {
        aiHand.add(card); // Deal 8 cards to AI's hand
      }
    }
  }

  Card getRandomCard() {
    final random = Random();
    final randomIndex = random.nextInt(deck.length);
    return deck.removeAt(randomIndex);
  }

  void addCardToContainer(Card card, String container, bool bool) {}

  // Other methods for dealing, discarding, etc.
}
