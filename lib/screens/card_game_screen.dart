import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shed/controllers/game_controller.dart';
import 'package:shed/widgets/gradient_button.dart';
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
      backgroundColor: const Color(0xFF222831),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF393E46),
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
            flex: 3,
            child: Container(
              color: const Color(0xFF393E46),
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
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => GradientButton(
                            text: 'Deal cards',
                            colors: gameController.gameButton.value
                                ? const [Colors.blue, Colors.cyan]
                                : [Colors.grey, Colors.grey],
                            icon: Icons.back_hand_outlined,
                            onPressed: gameController.gameButton.value
                                ? () {
                                    gameController.initializeDeck();
                                    gameController.initialDeal();
                                  }
                                : null,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(() => GradientButton(
                            text: 'Discard',
                            colors: gameController.discardButton.value
                                ? const [Colors.redAccent, Colors.orangeAccent]
                                : [Colors.grey, Colors.grey],
                            icon: Icons.remove_circle_outline,
                            onPressed: gameController.discardButton.value
                                ? gameController.discardSelectedCards
                                : null,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
