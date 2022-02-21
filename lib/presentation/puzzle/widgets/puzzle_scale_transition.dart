import 'package:flutter/material.dart';

class PuzzleScaleTransition extends StatefulWidget {
  final Widget child;

  const PuzzleScaleTransition({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _PuzzleScaleTransitionState createState() => _PuzzleScaleTransitionState();
}

class _PuzzleScaleTransitionState extends State<PuzzleScaleTransition> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _scale = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );
    super.initState();
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
      child: widget.child,
    );
  }
}
