import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/animations/utils/animations_manager.dart';

class ScaleUpTransition extends StatefulWidget {
  final Widget child;

  const ScaleUpTransition({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _ScaleUpTransitionState createState() => _ScaleUpTransitionState();
}

class _ScaleUpTransitionState extends State<ScaleUpTransition> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.scaleUp.duration,
    )..forward();

    _scale = AnimationsManager.scaleUp.tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AnimationsManager.scaleUp.curve,
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
