import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/stars_layer.dart';

class StarsPainter extends CustomPainter {
  final List<int> xOffsets;
  final List<int> yOffsets;
  final List<double> sizes;
  final Color? color;

  StarsPainter({
    required this.xOffsets,
    required this.yOffsets,
    required this.sizes,
    this.color,
  });

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = color ?? Colors.white.withOpacity(0.5);
    for (int i = 0; i <= StarsLayer.totalStarsCount; i++) {
      canvas.drawCircle(
        Offset(xOffsets[i].toDouble(), yOffsets[i].toDouble()),
        sizes[i],
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
