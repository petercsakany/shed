import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/card_game_screen.dart';

void main() {
  runApp(const CardGameApp());
}

class CardGameApp extends StatelessWidget {
  const CardGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: CardGameScreen(),
    );
  }
}
