import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int x;
  final int y;

  const Location({
    required this.x,
    required this.y,
  });

  static void printLocations(List<Location> locations) {
    Map<int, String> locationsMap = {};
    for (int i = 0; i <= locations.length - 1; i++) {
      locationsMap[i] = '(${locations[i].x}, ${locations[i].y})';
    }
    print(locationsMap);
  }

  bool isLocatedAround(Location _location) {
    return _location.x == x && (_location.y == y - 1 || _location.y == y + 1) || _location.y == y && (_location.x == x - 1 || _location.x == x + 1);
  }

  String get asString => '($x, $y)';

  @override
  List<Object> get props => [x, y];
}
