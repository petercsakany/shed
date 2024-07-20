import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shed/controllers/game_controller.dart';

class DiscardPile extends StatelessWidget {
  DiscardPile({super.key});
  final GameController gameController = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 60,
      color: Colors.transparent,
      child: Obx(() {
        return Image.asset(gameController.discardPileImage.value);
      }),
    );
  }
}
