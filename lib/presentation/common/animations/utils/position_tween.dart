import 'package:flutter/animation.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

class PositionTween extends Tween<Position> {
  /// Creates a [Size] tween.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as an empty size.
  PositionTween({ Position? begin, Position? end }) : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  Position lerp(double t) => Position.lerp(begin, end, t);
}