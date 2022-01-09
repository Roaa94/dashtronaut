import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

class TilesData {
  List<Position> positions;
  List<Location> locations;

  TilesData({
    required this.positions,
    required this.locations,
  });
}
