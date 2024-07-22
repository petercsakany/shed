import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shed/controllers/game_controller.dart';
import 'package:shed/models/settings.dart';
import 'package:shed/widgets/card_widget.dart';

class FaceUpContainer extends StatelessWidget {
  FaceUpContainer({super.key});
  final GameController gameController = Get.find();

  @override
  Widget build(BuildContext context) {
    final settings = Settings.getSettings(context);
    return Expanded(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
            children: gameController.playerFaceUp.map((card) {
              return CardWidget(
                  imagePath: card.imagePath,
                  isSelected: false,
                  settings: settings,
                  onSelect: () {});
            }).toList(),
          )),
    ));
  }
}
