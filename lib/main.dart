import 'package:flutter/material.dart';

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

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 60,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.white,
      child: const Center(child: Text('Card')),
    );
  }
}

class PileWidget extends StatelessWidget {
  const PileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 60,
      color: Colors.white,
      child: const Center(child: Text('Pile')),
    );
  }
}

class ControlButton extends StatelessWidget {
  final String text;

  const ControlButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text),
    );
  }
}
