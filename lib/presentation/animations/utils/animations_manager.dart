import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/background_layer.dart';
import 'package:flutter_puzzle_hack/data/models/position.dart';
import 'package:flutter_puzzle_hack/presentation/animations/utils/position_tween.dart';

enum AnimatedElementType {
  puzzleBoard,
  stars,
}

class AnimatedElement<T> {
  final Tween<T> tween;
  final Duration duration;
  final Curve curve;

  AnimatedElement({
    required this.tween,
    required this.duration,
    required this.curve,
  });
}

class AnimationsManager {
  static final AnimatedElement<double> scaleUp = AnimatedElement<double>(
    duration: const Duration(milliseconds: 700),
    tween: Tween<double>(begin: 0, end: 1),
    curve: Curves.easeOutBack,
  );

  static final AnimatedElement<double> stars = AnimatedElement<double>(
    duration: const Duration(milliseconds: 1000),
    tween: Tween<double>(begin: 0.8, end: 0.1),
    curve: Curves.easeInOut,
  );

  static final AnimatedElement<double> fadeIn = AnimatedElement<double>(
    duration: const Duration(milliseconds: 800),
    tween: Tween<double>(begin: 0, end: 1),
    curve: Curves.easeInOut,
  );

  static const Duration bgLayerAnimationDuration = Duration(milliseconds: 600);

  static AnimatedElement<Position> bgLayer(BackgroundLayer layer) {
    return AnimatedElement<Position>(
      duration: bgLayerAnimationDuration,
      tween: PositionTween(
        begin: layer.outOfViewPosition,
        end: layer.position,
      ),
      curve: Curves.easeOutBack,
    );
  }

  static final AnimatedElement<double> tileHover = AnimatedElement<double>(
    duration: const Duration(milliseconds: 200),
    tween: Tween<double>(begin: 1, end: 0.94),
    curve: Curves.easeInOut,
  );

  static final AnimatedElement<double> pulse = AnimatedElement<double>(
    duration: const Duration(milliseconds: 800),
    tween: Tween<double>(begin: 1, end: 0.96),
    curve: Curves.easeInOut,
  );

  static const Duration phraseBubbleTotalAnimationDuration = Duration(milliseconds: 1000);

  static final AnimatedElement<double> phraseBubble = AnimatedElement<double>(
    duration: const Duration(milliseconds: 500),
    tween: Tween<double>(begin: 0, end: 1),
    curve: Curves.easeOutBack,
  );
}
