import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

class Tile {
  int value;
  double width;
  Position position;
  // Location location;

  Tile({
    required this.value,
    required this.width,
    required this.position,
    // required this.location,
  });
}
