import 'package:equatable/equatable.dart';
import 'package:flutter_puzzle_hack/models/location.dart';

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
  String toString() => '${top?.toStringAsFixed(2)}, ${right?.toStringAsFixed(2)}, ${bottom?.toStringAsFixed(2)}, ${left?.toStringAsFixed(2)}';

  bool isBetween(Position a, Position b) {
    assert(left != null && a.left != null && b.left != null);
    assert(top != null && a.top != null && b.top != null);
    return (left! >= a.left! && left! <= b.left! && top! >= a.top! && top! <= b.top!) ||
        (left! >= b.left! && left! <= a.left! && top! >= b.top! && top! <= a.top!);
  }

  @override
  List<Object?> get props => [left, top];

  factory Position.fromLocation(Location location, double tileWidth) =>
      Position(top: (location.y - 1) * tileWidth, left: (location.x - 1) * tileWidth);

  Position copyWith({double? left, double? top}) {
    return Position(
      left: left ?? this.left,
      top: top ?? this.top,
    );
  }
}
