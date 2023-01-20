import 'dart:math';

import 'package:dashtronaut/background/utils/stars_painter.dart';
import 'package:dashtronaut/layout/layout_delegate.dart';
import 'package:dashtronaut/layout/screen_type_helper.dart';
import 'package:flutter/material.dart';

class StarsLayout implements LayoutDelegate {
  @override
  final BuildContext context;

  StarsLayout(this.context);

  @override
  ScreenTypeHelper get screenTypeHelper => ScreenTypeHelper(context);

  int get totalStarsCount {
    switch (screenTypeHelper.type) {
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

  List<int> get randomStarXOffsets => _getRandomStarsOffsetsList(
      starsMaxXOffset.ceil() <= 0 ? 1 : starsMaxXOffset.ceil());

  List<int> get randomStarYOffsets => _getRandomStarsOffsetsList(
      starsMaxYOffset.ceil() <= 0 ? 1 : starsMaxYOffset.ceil());

  List<int> _getRandomStarsOffsetsList(int max) {
    List<int> offsets = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      offsets.add(random.nextInt(max));
    }
    return offsets;
  }

  List<double> get randomStarSizes {
    List<double> sizes = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      sizes.add(random.nextDouble() + 0.7);
    }
    return sizes;
  }

  List<int> get fadeOutStarIndices {
    List<int> indices = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      if (i % 5 == 0) {
        indices.add(i);
      }
    }
    return indices;
  }

  List<int> get fadeInStarIndices {
    List<int> indices = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      if (i % 3 == 0) {
        indices.add(i);
      }
    }
    return indices;
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
