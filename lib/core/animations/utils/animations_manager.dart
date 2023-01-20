import 'package:dashtronaut/core/models/position.dart';
import 'package:dashtronaut/core/animations/utils/position_tween.dart';
import 'package:dashtronaut/layout/background_layer_layout.dart';
import 'package:flutter/material.dart';

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

  static AnimatedElement<Position> bgLayer(BackgroundLayerLayout layer) {
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

  static const Duration phraseBubbleAnimationDuration =
      Duration(milliseconds: 500);

  static const Duration puzzleSolvedDialogDelay = Duration(milliseconds: 500);

  static Duration phraseBubbleTotalAnimationDuration =
      phraseBubbleHoldAnimationDuration + phraseBubbleAnimationDuration * 2;

  static const Duration phraseBubbleHoldAnimationDuration =
      Duration(milliseconds: 1000);

  static final AnimatedElement<double> phraseBubble = AnimatedElement<double>(
    duration: phraseBubbleAnimationDuration,
    tween: Tween<double>(begin: 0, end: 1),
    curve: Curves.easeOutBack,
  );
}
