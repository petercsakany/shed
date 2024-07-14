import 'package:flutter/material.dart';
import 'package:shed/widgets/control_button.dart';

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
