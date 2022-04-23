import 'dart:ui';

import 'package:dashtronaut/presentation/common/animations/utils/position_tween.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Model that sets values for left, top, right, and bottom
/// of a widget to position it at most times in a [Stack] widget
class Position extends Equatable {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  const Position({
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  const Position.zero()
      : left = 0,
        top = 0,
        bottom = 0,
        right = 0;

  @override
  String toString() =>
      '${top?.toStringAsFixed(2)}, ${right?.toStringAsFixed(2)}, ${bottom?.toStringAsFixed(2)}, ${left?.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [left, top];

  Position copyWith(
      {double? left, double? top, double? right, double? bottom}) {
    return Position(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }

  /// Lerp implementation for providing the ability to create a [Tween] of type [Position]
  ///
  /// See [PositionTween]
  static Position lerp(Position? a, Position? b, double t) {
    if (a == null || b == null) {
      return const Position.zero();
    } else {
      return Position(
        left: a.left == null && b.left == null
            ? null
            : lerpDouble((a.left ?? 0), (b.left ?? 0), t),
        right: a.right == null && b.right == null
            ? null
            : lerpDouble((a.right ?? 0), (b.right ?? 0), t),
        top: a.top == null && b.top == null
            ? null
            : lerpDouble((a.top ?? 0), (b.top ?? 0), t),
        bottom: a.bottom == null && b.bottom == null
            ? null
            : lerpDouble((a.bottom ?? 0), (b.bottom ?? 0), t),
      );
    }
  }
}
