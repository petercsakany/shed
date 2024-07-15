import 'package:flutter/material.dart';
import 'package:shed/widgets/card_widget.dart';

class AiFaceUpContainer extends StatelessWidget {
  const AiFaceUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => CardWidget(
            imagePath: 'assets/images/7D.png',
            isSelected: false,
            onSelect: () {},
          ),
        ),
      ),
    );
  }
}
