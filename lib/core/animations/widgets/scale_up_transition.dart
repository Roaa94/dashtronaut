import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:flutter/material.dart';

class ScaleUpTransition extends StatefulWidget {
  final Widget child;
  final Duration? delay;

  const ScaleUpTransition({
    Key? key,
    required this.child,
    this.delay,
  }) : super(key: key);

  @override
  _ScaleUpTransitionState createState() => _ScaleUpTransitionState();
}

class _ScaleUpTransitionState extends State<ScaleUpTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.scaleUp.duration,
    );

    _scale = AnimationsManager.scaleUp.tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AnimationsManager.scaleUp.curve,
      ),
    );

    if (widget.delay == null) {
      _animationController.forward();
    } else {
      Future.delayed(widget.delay!, () {
        _animationController.forward();
      });
    }
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
