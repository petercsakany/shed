import 'package:flutter/material.dart';

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
