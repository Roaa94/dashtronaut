import 'package:flutter/material.dart';

class TilePulseTransition extends StatefulWidget {
  final Widget tileContent;
  final bool tileIsMovable;

  const TilePulseTransition({
    Key? key,
    required this.tileContent,
    required this.tileIsMovable,
  }) : super(key: key);

  @override
  _TilePulseTransitionState createState() => _TilePulseTransitionState();
}

class _TilePulseTransitionState extends State<TilePulseTransition> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  void _pulseTiles() {
    if (widget.tileIsMovable) {
      _animationController.repeat(reverse: true);
    } else {
      if (_animationController.isAnimating) {
        _animationController.stop();
      }
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scale = Tween<double>(begin: 1, end: 0.97).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _pulseTiles();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TilePulseTransition oldWidget) {
    _pulseTiles();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: widget.tileContent,
    );
  }
}
