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
    final fadeInDuration = AnimationsManager.fadeIn.duration;

    _animationController = AnimationController(
      vsync: this,
      duration: fadeInDuration + (widget.delay ?? Duration.zero),
    );

    // Todo: test this logic
    var intervalStart = 0.0;
    if (widget.delay != null &&
        widget.delay!.inSeconds < fadeInDuration.inSeconds) {
      intervalStart = widget.delay!.inSeconds /
          (fadeInDuration.inSeconds + widget.delay!.inSeconds);
    }

    _opacity = AnimationsManager.fadeIn.tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          intervalStart,
          1,
          curve: AnimationsManager.fadeIn.curve,
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
    return FadeTransition(
      opacity: _opacity,
      child: widget.child,
    );
  }
}
