import 'package:flutter/material.dart';
import 'package:shed/widgets/deck_pile.dart';
import 'package:shed/widgets/discard_pile.dart';

class PilesContainer extends StatelessWidget {
  const PilesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const DeckPile(),
        const SizedBox(width: 20),
        DiscardPile(),
      ],
    );
  }
}
