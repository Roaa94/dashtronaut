import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/stars_layer.dart';
import 'package:flutter_puzzle_hack/presentation/animation-utils/animations_manager.dart';

class Stars extends StatefulWidget {
  const Stars({Key? key}) : super(key: key);

  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State<Stars> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacity;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.stars.duration,
    );
    _animationController.repeat(reverse: true);

    _opacity = AnimationsManager.stars.tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AnimationsManager.stars.curve,
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
    StarsLayer _starsLayer = StarsLayer(context);

    return CustomPaint(
      painter: _starsLayer.getPainter(
        opacity: _opacity,
      ),
    );
  }
}
