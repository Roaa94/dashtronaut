import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';

// 1  2
// 3
const puzzle2x2TilesCorrect = [
  Tile(
    value: 1,
    currentLocation: Location(x: 1, y: 1),
    correctLocation: Location(x: 1, y: 1),
  ),
  Tile(
    value: 2,
    currentLocation: Location(x: 2, y: 1),
    correctLocation: Location(x: 2, y: 1),
  ),
  Tile(
    value: 3,
    currentLocation: Location(x: 1, y: 2),
    correctLocation: Location(x: 1, y: 2),
  ),
  Tile(
    value: 4,
    tileIsWhiteSpace: true,
    currentLocation: Location(x: 2, y: 2),
    correctLocation: Location(x: 2, y: 2),
  ),
];

// 1  2
//    3
const puzzle2x2Tiles = [
  Tile(
    value: 1,
    currentLocation: Location(x: 1, y: 1),
    correctLocation: Location(x: 1, y: 1),
  ),
  Tile(
    value: 2,
    currentLocation: Location(x: 2, y: 1),
    correctLocation: Location(x: 2, y: 1),
  ),
  Tile(
    value: 3,
    currentLocation: Location(x: 2, y: 2),
    correctLocation: Location(x: 1, y: 2),
  ),
  Tile(
    value: 4,
    tileIsWhiteSpace: true,
    currentLocation: Location(x: 1, y: 2),
    correctLocation: Location(x: 2, y: 2),
  ),
];

// 1   2
// 3
const puzzle2x2 = Puzzle(n: 2, tiles: puzzle2x2TilesCorrect);
