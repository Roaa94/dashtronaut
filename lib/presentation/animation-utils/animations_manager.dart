import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/background_layer.dart';
import 'package:flutter_puzzle_hack/data/models/position.dart';
import 'package:flutter_puzzle_hack/presentation/animation-utils/position_tween.dart';

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
  static final AnimatedElement<double> puzzleBoard = AnimatedElement<double>(
    duration: const Duration(milliseconds: 700),
    tween: Tween<double>(begin: 0, end: 1),
    curve: Curves.easeOutBack,
  );

  static final AnimatedElement<double> stars = AnimatedElement<double>(
    duration: const Duration(milliseconds: 1000),
    tween: Tween<double>(begin: 0.8, end: 0.1),
    curve: Curves.easeInOut,
  );

  static AnimatedElement<Position> bgLayer(BackgroundLayer layer) {
    return AnimatedElement<Position>(
      duration: const Duration(milliseconds: 800),
      tween: PositionTween(
        begin: layer.outOfViewPosition,
        end: layer.position,
      ),
      curve: Curves.easeOutBack,
    );
  }
}
