import 'package:flutter/material.dart';

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
