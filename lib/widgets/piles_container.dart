import 'package:flutter/material.dart';
import 'package:shed/widgets/pile_widget.dart';

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
