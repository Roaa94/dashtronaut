import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

class Tile {
  int value;
  double width;
  bool isWhiteSpaceTile;
  Location correctLocation;
  Location currentLocation;

  Tile({
    required this.value,
    required this.width,
    required this.correctLocation,
    required this.currentLocation,
    this.isWhiteSpaceTile = false,
  });

  /// Top & Left positions values based on current location
  Position get position {
    return Position(top: (currentLocation.y - 1) * width, left: (currentLocation.x - 1) * width);
  }

  Tile copyWith({
    value,
    width,
    correctLocation,
    currentLocation,
    isWhiteSpaceTile,
  }) {
    return Tile(
      value: value ?? this.value,
      width: width ?? this.width,
      correctLocation: correctLocation ?? this.correctLocation,
      currentLocation: currentLocation ?? this.currentLocation,
      isWhiteSpaceTile: isWhiteSpaceTile ?? this.isWhiteSpaceTile,
    );
  }
}
