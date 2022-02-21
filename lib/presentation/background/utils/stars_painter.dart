import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/stars_layer.dart';

class StarsPainter extends CustomPainter {
  final List<int> xOffsets;
  final List<int> yOffsets;
  final List<int> fadeOutStarIndices;
  final List<int> fadeInStarIndices;
  final List<double> sizes;
  final Animation<double> opacityAnimation;

  StarsPainter({
    required this.xOffsets,
    required this.yOffsets,
    required this.fadeOutStarIndices,
    required this.fadeInStarIndices,
    required this.sizes,
    required this.opacityAnimation,
  }) : super(repaint: opacityAnimation);

  final Paint _paint = Paint();

  double _getStarOpacity(int i) {
    if (fadeOutStarIndices.contains(i)) {
      return opacityAnimation.value;
    } else if (fadeInStarIndices.contains(i)) {
      return 1 - opacityAnimation.value;
    } else {
      return 0.5;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i <= StarsLayer.totalStarsCount; i++) {
      _paint.color = Colors.white.withOpacity(_getStarOpacity(i));
      canvas.drawCircle(
        Offset(xOffsets[i].toDouble(), yOffsets[i].toDouble()),
        sizes[i],
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
