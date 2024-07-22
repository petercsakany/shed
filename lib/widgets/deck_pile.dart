import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shed/controllers/game_controller.dart';

class DeckPile extends StatelessWidget {
  const DeckPile({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find();

    return Container(
      height: 120,
      width: 86,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/2B.png'),
          Obx(() {
            return CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: Text(
                gameController.deck.length.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
