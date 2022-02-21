import 'dart:math';

import 'package:flutter/material.dart';

class StarsLayer {
  final BuildContext context;

  StarsLayer(this.context);

  static const int totalStarsCount = 500;

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
}
