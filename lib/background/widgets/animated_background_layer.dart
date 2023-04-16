import 'package:dashtronaut/puzzle/models/position.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/layout/background_layer_layout.dart';
import 'package:flutter/material.dart';

class AnimatedBackgroundLayer extends StatefulWidget {
  final BackgroundLayerLayout layer;

  const AnimatedBackgroundLayer({
    super.key,
    required this.layer,
  });

  @override
  _AnimatedBackgroundLayerState createState() =>
      _AnimatedBackgroundLayerState();
}

class _AnimatedBackgroundLayerState extends State<AnimatedBackgroundLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Position> _position;

  @override
  void initState() {
    final duration = AnimationsManager.bgLayer(widget.layer).duration;
    _animationController = AnimationController(
      duration: duration,
      vsync: this,
    );

    const delay = Duration(milliseconds: 400);

    final intervalStart =
        delay.inSeconds / (duration.inSeconds + delay.inSeconds);

    _position = AnimationsManager.bgLayer(widget.layer).tween.animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              intervalStart,
              1,
              curve: AnimationsManager.bgLayer(widget.layer).curve,
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
    return AnimatedBuilder(
      animation: _position,
      child: Image.asset(
        widget.layer.assetUrl,
        width: widget.layer.size.width,
      ),
      builder: (c, image) => Positioned(
        left: _position.isCompleted
            ? widget.layer.position.left
            : _position.value.left,
        top: _position.isCompleted
            ? widget.layer.position.top
            : _position.value.top,
        right: _position.isCompleted
            ? widget.layer.position.right
            : _position.value.right,
        bottom: _position.isCompleted
            ? widget.layer.position.bottom
            : _position.value.bottom,
        child: image!,
      ),
    );
  }
}
