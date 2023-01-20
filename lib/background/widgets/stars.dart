import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/layout/stars_layout.dart';
import 'package:flutter/material.dart';

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
    StarsLayout starsLayout = StarsLayout(context);

    return CustomPaint(
      painter: starsLayout.getPainter(
        opacity: _opacity,
      ),
    );
  }
}
