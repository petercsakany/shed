import 'package:flutter/material.dart';

class PileWidget extends StatelessWidget {
  const PileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 60,
      color: Colors.transparent,
      child: Image.asset('assets/images/2B.png'),
    );
  }
}
