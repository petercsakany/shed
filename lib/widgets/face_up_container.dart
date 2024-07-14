import 'package:flutter/material.dart';
import 'package:shed/widgets/card_widget.dart';

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
