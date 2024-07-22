import 'package:flutter/material.dart';

class Settings {
  final double cardHeight;
  final double cardWidth;

  Settings({required this.cardHeight, required this.cardWidth});

  static Settings mobile() {
    return Settings(cardHeight: 120, cardWidth: 86); // Example sizes
  }

  static Settings desktop() {
    return Settings(cardHeight: 80, cardWidth: 60); // Example sizes
  }

  static Settings getSettings(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide < 560 ? Settings.mobile() : Settings.desktop();
  }
}
