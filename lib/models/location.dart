import 'package:dashtronaut/models/tile.dart';
import 'package:equatable/equatable.dart';

/// 2-dimensional Location model
///
/// Used to determine [Tile] location in the puzzle board
/// For example, (1, 1) is at the top left
/// and if the puzzle size is 4x4 then (4, 4) is at the bottom right
class Location extends Equatable implements Comparable<Location> {
  final int x;
  final int y;

  const Location({
    required this.x,
    required this.y,
  });

  /// Check if a location is located around another
  ///
  /// For example, for a 3x3 puzzle:
  /// | 1,1 | 2,1 | 3, 1 |
  /// | 1,2 | 2,2 | 3, 2 |
  /// | 1,3 | 2,3 | 3, 3 |
  /// The tile (2, 2) has tiles:
  /// (1, 2), (2, 1), (3, 2), (2, 3) Located around it
  bool isLocatedAround(Location _location) {
    return isLeftOf(_location) ||
        isRightOf(_location) ||
        isBottomOf(_location) ||
        isTopOf(_location);
  }

  /// Check is a location is left of another
  bool isLeftOf(Location _location) {
    return _location.y == y && _location.x == x + 1;
  }

  /// Check is a location is right of another
  bool isRightOf(Location _location) {
    return _location.y == y && _location.x == x - 1;
  }

  /// Check is a location is top of another
  bool isTopOf(Location _location) {
    return _location.x == x && _location.y == y + 1;
  }

  /// Check is a location is bottom of another
  bool isBottomOf(Location _location) {
    return _location.x == x && _location.y == y - 1;
  }

  @override
  String toString() => '($y, $x)';

  @override
  int compareTo(Location other) {
    if (y < other.y) {
      return -1;
    } else if (y > other.y) {
      return 1;
    } else {
      if (x < other.x) {
        return -1;
      } else if (x > other.x) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  @override
  List<Object> get props => [x, y];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
