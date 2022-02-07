import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

class Tile {
  int value;
  double width;
  bool tileIsWhiteSpace;
  Location correctLocation;
  Location currentLocation;

  Tile({
    required this.value,
    required this.width,
    required this.correctLocation,
    required this.currentLocation,
    this.tileIsWhiteSpace = false,
  });

  /// Top & Left positions values based on current location
  Position get position {
    return Position(top: (currentLocation.y - 1) * width, left: (currentLocation.x - 1) * width);
  }

  bool passedMidPoint(Position _newPosition) {
    assert(_newPosition.left != null && _newPosition.top != null);
    assert(position.left != null && _newPosition.top != null);
    double midPoint = width / 5;
    return (_newPosition.left! - position.left!).abs() >= midPoint || (_newPosition.top! - position.top!).abs() >= midPoint;
  }

  Tile copyWith({
    value,
    width,
    correctLocation,
    currentLocation,
    tileIsWhiteSpace,
  }) {
    return Tile(
      value: value ?? this.value,
      width: width ?? this.width,
      correctLocation: correctLocation ?? this.correctLocation,
      currentLocation: currentLocation ?? this.currentLocation,
      tileIsWhiteSpace: tileIsWhiteSpace ?? this.tileIsWhiteSpace,
    );
  }
}
