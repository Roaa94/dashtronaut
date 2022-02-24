import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/background/utils/stars_painter.dart';
import 'package:flutter_puzzle_hack/presentation/layout/screen_type_helper.dart';

class StarsLayer {
  final BuildContext context;

  StarsLayer(this.context);

  int get totalStarsCount {
    ScreenType screenType = ScreenTypeHelper(context).type;
    switch (screenType) {
      case ScreenType.xSmall:
        return 300;
      case ScreenType.small:
        return 500;
      case ScreenType.medium:
        return 700;
      case ScreenType.large:
        return 1000;
    }
  }

  final Random random = Random();

  double get starsMaxXOffset => MediaQuery.of(context).size.width;

  double get starsMaxYOffset => MediaQuery.of(context).size.height;

  List<int> get randomStarXOffsets => _getRandomStarsOffsetsList(starsMaxXOffset.ceil() <= 0 ? 1 : starsMaxXOffset.ceil());

  List<int> get randomStarYOffsets => _getRandomStarsOffsetsList(starsMaxYOffset.ceil() <= 0 ? 1 : starsMaxYOffset.ceil());

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

  List<int> get fadeOutStarIndices {
    List<int> _indices = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      if (i % 5 == 0) {
        _indices.add(i);
      }
    }
    return _indices;
  }

  List<int> get fadeInStarIndices {
    List<int> _indices = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      if (i % 3 == 0) {
        _indices.add(i);
      }
    }
    return _indices;
  }

  CustomPainter getPainter({required Animation<double> opacity}) {
    return StarsPainter(
      xOffsets: randomStarXOffsets,
      yOffsets: randomStarYOffsets,
      sizes: randomStarSizes,
      fadeOutStarIndices: fadeOutStarIndices,
      fadeInStarIndices: fadeInStarIndices,
      totalStarsCount: totalStarsCount,
      opacityAnimation: opacity,
    );
  }
}
