import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/stars_layer.dart';
import 'package:flutter_puzzle_hack/presentation/background/utils/stars_painter.dart';

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
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.repeat(reverse: true);

    _opacity = Tween<double>(
      begin: 0.7,
      end: 0.1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
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
      painter: StarsPainter(
        xOffsets: _starsLayer.randomStarXOffsets,
        yOffsets: _starsLayer.randomStarYOffsets,
        sizes: _starsLayer.randomStarSizes,
        fadeOutStarIndices: _starsLayer.fadeOutStarIndices,
        fadeInStarIndices: _starsLayer.fadeInStarIndices,
        opacityAnimation: _opacity,
      ),
    );
  }
}
