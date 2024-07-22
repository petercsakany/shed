import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shed/controllers/game_controller.dart';

class DiscardPile extends StatelessWidget {
  DiscardPile({super.key});
  final GameController gameController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 86,
      color: Colors.transparent,
      child: Obx(() {
        return Image.asset(gameController.discardPileImage.value);
      }),
    );
  }
}
