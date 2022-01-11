class Position {
  double left;
  double top;

  Position({
    required this.left,
    required this.top,
  });

  String get asString => 'Left: ${left.toStringAsFixed(2)} | Top: ${top.toStringAsFixed(2)}';
}
