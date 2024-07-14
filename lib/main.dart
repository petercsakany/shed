import 'package:flutter/material.dart';

import 'screens/card_game_screen.dart';
import 'widgets/card_widget.dart';
import 'widgets/control_button.dart';
import 'widgets/pile_widget.dart';

void main() {
  runApp(const CardGameApp());
}

class CardGameApp extends StatelessWidget {
  const CardGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CardGameScreen(),
    );
  }
}

class AiFaceUpContainer extends StatelessWidget {
  const AiFaceUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) => const CardWidget()),
      ),
    );
  }
}

class PilesContainer extends StatelessWidget {
  const PilesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PileWidget(),
        SizedBox(width: 20),
        PileWidget(),
      ],
    );
  }
}

class FaceUpContainer extends StatelessWidget {
  const FaceUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(4, (index) => const CardWidget()),
        ),
      ),
    );
  }
}

class InHandContainer extends StatelessWidget {
  const InHandContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(4, (index) => const CardWidget()),
        ),
      ),
    );
  }
}

class ControlContainer extends StatelessWidget {
  const ControlContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ControlButton(text: 'Start Game'),
          ControlButton(text: 'Discard'),
          Text('Turn Text', style: TextStyle(fontSize: 16)),
          ControlButton(text: 'Reset Game'),
        ],
      ),
    );
  }
}
