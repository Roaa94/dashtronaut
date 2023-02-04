import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:flutter/material.dart';

class FadeInTransition extends StatefulWidget {
  final Widget child;
  final Duration? delay;

  const FadeInTransition({
    super.key,
    required this.child,
    this.delay,
  });

  @override
  _FadeInTransitionState createState() => _FadeInTransitionState();
}

class _FadeInTransitionState extends State<FadeInTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacity;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.fadeIn.duration,
    );

    _opacity = AnimationsManager.fadeIn.tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AnimationsManager.fadeIn.curve,
      ),
    );
    if (widget.delay == null) {
      _animationController.forward();
    } else {
      Future.delayed(widget.delay!, () {
        if (mounted) {
          _animationController.forward();
        }
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
    return FadeTransition(
      opacity: _opacity,
      child: widget.child,
    );
  }
}
