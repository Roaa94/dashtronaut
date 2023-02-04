import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';

// 1  2
// 3
const puzzle2x2TilesSolved = [
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
const puzzle2x2Solved = Puzzle(n: 2, tiles: puzzle2x2TilesSolved);

// 1  2
//    3
const puzzle2x2 = Puzzle(n: 2, tiles: puzzle2x2Tiles);

// 3
// 2  1
const solvable2x2PuzzleWithSeed2 = [
  Tile(
    value: 1,
    correctLocation: Location(y: 1, x: 1),
    currentLocation: Location(y: 2, x: 2),
  ),
  Tile(
    value: 2,
    correctLocation: Location(y: 1, x: 2),
    currentLocation: Location(y: 2, x: 1),
  ),
  Tile(
    value: 3,
    correctLocation: Location(y: 2, x: 1),
    currentLocation: Location(y: 1, x: 1),
  ),
  Tile(
    value: 4,
    correctLocation: Location(y: 2, x: 2),
    currentLocation: Location(y: 1, x: 2),
    tileIsWhiteSpace: true,
  )
];

// 3
// 2  1
const puzzle2x2Solvable = Puzzle(n: 2, tiles: solvable2x2PuzzleWithSeed2);

const solvable2x2PuzzleWithSeed2Reset = [
  Tile(
    value: 1,
    correctLocation: Location(y: 1, x: 1),
    currentLocation: Location(y: 2, x: 1),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 2,
    correctLocation: Location(y: 1, x: 2),
    currentLocation: Location(y: 1, x: 1),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 3,
    correctLocation: Location(y: 2, x: 1),
    currentLocation: Location(y: 1, x: 2),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 4,
    correctLocation: Location(y: 2, x: 2),
    currentLocation: Location(y: 2, x: 2),
    tileIsWhiteSpace: true,
  ),
];

const solvable3x3PuzzleWithSeed2 = [
  Tile(
    value: 1,
    correctLocation: Location(y: 1, x: 1),
    currentLocation: Location(y: 3, x: 1),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 2,
    correctLocation: Location(y: 1, x: 2),
    currentLocation: Location(y: 1, x: 1),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 3,
    correctLocation: Location(y: 1, x: 3),
    currentLocation: Location(y: 3, x: 2),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 4,
    correctLocation: Location(y: 2, x: 1),
    currentLocation: Location(y: 1, x: 2),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 5,
    correctLocation: Location(y: 2, x: 2),
    currentLocation: Location(y: 2, x: 3),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 6,
    correctLocation: Location(y: 2, x: 3),
    currentLocation: Location(y: 2, x: 1),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 7,
    correctLocation: Location(y: 3, x: 1),
    currentLocation: Location(y: 3, x: 3),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 8,
    correctLocation: Location(y: 3, x: 2),
    currentLocation: Location(y: 2, x: 2),
    tileIsWhiteSpace: false,
  ),
  Tile(
    value: 9,
    correctLocation: Location(y: 3, x: 3),
    currentLocation: Location(y: 1, x: 3),
    tileIsWhiteSpace: true,
  ),
];

const puzzle3x3 = Puzzle(n: 3, tiles: solvable3x3PuzzleWithSeed2);
