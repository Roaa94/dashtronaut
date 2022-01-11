import 'package:flutter_puzzle_hack/enums/destination.dart';

class Direction {
  Destination destination;

  Direction(this.destination);

  bool get isHorizontal => destination == Destination.left || destination == Destination.right;

  bool get isVertical => destination == Destination.top || destination == Destination.bottom;
}