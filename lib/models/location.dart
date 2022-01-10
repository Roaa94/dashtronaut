import 'package:equatable/equatable.dart';

class Location extends Equatable {
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

  String get asString => '($y, $x)';

  static void printLocations(List<Location> locations) {
    Map<int, String> locationsMap = {};
    for (int i = 0; i <= locations.length - 1; i++) {
      locationsMap[i] = '(${locations[i].y}, ${locations[i].x})';
    }
    print(locationsMap);
  }

  @override
  List<Object> get props => [x, y];
}
