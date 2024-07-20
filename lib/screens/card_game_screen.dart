import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shed/controllers/game_controller.dart';
import 'package:shed/widgets/in_hand_container.dart';

import '../widgets/ai_face_up_container.dart';
import '../widgets/face_up_container.dart';
import '../widgets/piles_container.dart';

class CardGameScreen extends StatelessWidget {
  CardGameScreen({super.key});
  final GameController gameController = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFFD7CDCD),
              child: Center(
                child: Column(
                  children: [
                    AiFaceUpContainer(),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: PilesContainer(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: const Color(0xFFD7CDCD),
              child: Center(
                child: Column(
                  children: [
                    FaceUpContainer(),
                    InHandContainer(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                gameController.initializeDeck();
                gameController.initialDeal();
              },
              child: const Text('button')),
          Obx(() => ElevatedButton(
                onPressed: gameController.discardButton.value
                    ? gameController.discardSelectedCards
                    : null,
                child: const Text('Discard'),
              ))
        ],
      ),
    );
  }
}
