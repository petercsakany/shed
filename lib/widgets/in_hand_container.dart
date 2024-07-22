import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shed/controllers/game_controller.dart';
import 'package:shed/models/card_item.dart';
import 'package:shed/models/settings.dart';
import 'package:shed/widgets/card_widget.dart';

class InHandContainer extends StatelessWidget {
  InHandContainer({super.key});
  final GameController gameController = Get.find();

  @override
  Widget build(BuildContext context) {
    final settings = Settings.getSettings(context);
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() {
          final cardCount = gameController.playerHand.length;
          return SizedBox(
            width: (cardCount - 1) * 30.0 + settings.cardWidth,
            child: Stack(
              children: gameController.playerHand.asMap().entries.map((entry) {
                int index = entry.key;
                CardItem cardItem = entry.value;

                return Positioned(
                  left: index * 30.0,
                  bottom: 10,
                  child: CardWidget(
                    imagePath: cardItem.imagePath,
                    isSelected: cardItem.isSelected,
                    onSelect: () => gameController.selectCard(cardItem),
                    settings: settings,
                  ),
                );
              }).toList(),
            ),
          );
        }),
      ),
    );
  }
}
