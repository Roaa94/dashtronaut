class Direction {
  final double? dx;
  final double? dy;

  const Direction({this.dx, this.dy});

  const Direction.horizontal(this.dx) : dy = null;

  const Direction.vertical(this.dy) : dx = null;

  bool get left => dx != null && dx! < 0;

  bool get right => dx != null && dx! > 0;

  bool get top => dy != null && dy! < 0;

  bool get bottom => dy != null && dy! > 0;

  bool get horizontal => left || right;

  bool get vertical => top || bottom;
}
