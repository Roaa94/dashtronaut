import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:flutter/material.dart';

class ScaleUpTransition extends StatefulWidget {
  final Widget child;
  final Duration? delay;

  const ScaleUpTransition({
    super.key,
    required this.child,
    this.delay,
  });

  @override
  _ScaleUpTransitionState createState() => _ScaleUpTransitionState();
}

class _ScaleUpTransitionState extends State<ScaleUpTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  @override
  void initState() {
    final scaleUpDuration = AnimationsManager.scaleUp.duration;
    _animationController = AnimationController(
      vsync: this,
      duration: scaleUpDuration + (widget.delay ?? Duration.zero),
    );

    // Todo: test this logic
    var intervalStart = 0.0;
    if (widget.delay != null &&
        widget.delay!.inSeconds < scaleUpDuration.inSeconds) {
      intervalStart = widget.delay!.inSeconds /
          (scaleUpDuration.inSeconds + widget.delay!.inSeconds);
    }

    _scale = AnimationsManager.scaleUp.tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          intervalStart,
          1,
          curve: AnimationsManager.scaleUp.curve,
        ),
      ),
    );
    _animationController.forward();
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
