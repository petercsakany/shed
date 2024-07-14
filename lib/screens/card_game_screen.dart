import 'package:flutter/material.dart';
import 'package:shed/main.dart';

class CardGameScreen extends StatelessWidget {
  const CardGameScreen({super.key});

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
              child: const Center(
                child: AiFaceUpContainer(),
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
              child: const Column(
                children: [
                  FaceUpContainer(),
                  InHandContainer(),
                ],
              ),
            ),
          ),
          const ControlContainer(),
        ],
      ),
    );
  }
}
