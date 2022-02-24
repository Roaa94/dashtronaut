import 'package:equatable/equatable.dart';

class Location extends Equatable implements Comparable<Location> {
  final int x;
  final int y;

  const Location({
    required this.x,
    required this.y,
  });

  bool isLocatedAround(Location _location) {
    return isLeftOf(_location) || isRightOf(_location) || isBottomOf(_location) || isTopOf(_location);
  }

  bool isLeftOf(Location _location) {
    return _location.y == y && _location.x == x + 1;
  }

  bool isRightOf(Location _location) {
    return _location.y == y && _location.x == x - 1;
  }

  bool isTopOf(Location _location) {
    return _location.x == x && _location.y == y + 1;
  }

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
