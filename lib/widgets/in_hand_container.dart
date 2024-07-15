import 'package:flutter/material.dart';

class InHandContainer extends StatelessWidget {
  const InHandContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [],
        ),
      ),
    );
  }
}
