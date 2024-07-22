import 'package:flutter/material.dart';
import 'package:shed/models/settings.dart';

class CardWidget extends StatefulWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onSelect;
  final Settings settings;
  const CardWidget({
    super.key,
    required this.imagePath,
    required this.isSelected,
    required this.onSelect,
    required this.settings,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onSelect,
        child: FadeTransition(
          opacity: _animation,
          child: Transform.translate(
            offset: widget.isSelected ? const Offset(0, -10) : Offset.zero,
            child: Container(
              height: widget.settings.cardHeight,
              width: widget.settings.cardWidth,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(1.0),
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.fill,
                  )),
            ),
          ),
        ));
  }
}
