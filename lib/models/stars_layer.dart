import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/background/stars_painter.dart';

class StarsLayer {
  final BuildContext context;

  StarsLayer(this.context);

  static const int totalStarsCount = 300;

  final Random random = Random();

  double get starsMaxXOffset => MediaQuery.of(context).size.width;

  double get starsMaxYOffset => MediaQuery.of(context).size.height;

  List<int> get randomStarXOffsets => _getRandomStarsOffsetsList(starsMaxXOffset.floor());

  List<int> get randomStarYOffsets => _getRandomStarsOffsetsList(starsMaxYOffset.floor());

  List<int> _getRandomStarsOffsetsList(int max) {
    List<int> _offsets = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      _offsets.add(random.nextInt(max));
    }
    return _offsets;
  }

  List<double> get randomStarSizes {
    List<double> _sizes = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      _sizes.add(random.nextDouble() + 0.7);
    }
    return _sizes;
  }

  CustomPainter getPainter({Color? color}) {
    return StarsPainter(
      xOffsets: randomStarXOffsets,
      yOffsets: randomStarYOffsets,
      sizes: randomStarSizes,
      color: color,
    );
  }
}
