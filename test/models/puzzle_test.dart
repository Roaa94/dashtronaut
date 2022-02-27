import 'package:Dashtronaut/models/location.dart';
import 'package:Dashtronaut/models/puzzle.dart';
import 'package:Dashtronaut/models/tile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  int n = 2;

  List<Location> correctLocations = const [
    Location(x: 1, y: 1),
    Location(x: 2, y: 1),
    Location(x: 1, y: 2),
    Location(x: 2, y: 2),
  ];

  List<Tile> puzzle2x2Tiles = [
    const Tile(
      value: 1,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 1, y: 1),
    ),
    const Tile(
      value: 2,
      currentLocation: Location(x: 2, y: 1),
      correctLocation: Location(x: 2, y: 1),
    ),
    const Tile(
      value: 3,
      currentLocation: Location(x: 1, y: 2),
      correctLocation: Location(x: 1, y: 2),
    ),
    const Tile(
      value: 4,
      tileIsWhiteSpace: true,
      currentLocation: Location(x: 2, y: 2),
      correctLocation: Location(x: 2, y: 2),
    ),
  ];

  Puzzle puzzle2x2 = Puzzle(n: n, tiles: puzzle2x2Tiles);

  List<Tile> puzzle2x2TilesUnsolved = [
    const Tile(
      value: 1,
      currentLocation: Location(x: 2, y: 1),
      correctLocation: Location(x: 1, y: 1),
    ),
    const Tile(
      value: 2,
      currentLocation: Location(x: 2, y: 2),
      correctLocation: Location(x: 2, y: 1),
    ),
    const Tile(
      value: 3,
      currentLocation: Location(x: 1, y: 2),
      correctLocation: Location(x: 1, y: 2),
    ),
    const Tile(
      value: 4,
      tileIsWhiteSpace: true,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 2, y: 2),
    ),
  ];

  // 1    3
  // 2
  List<Tile> puzzle2x2TilesUnsolvable = [
    const Tile(
      value: 1,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 1, y: 1),
    ),
    const Tile(
      value: 2,
      currentLocation: Location(x: 1, y: 2),
      correctLocation: Location(x: 2, y: 1),
    ),
    const Tile(
      value: 3,
      currentLocation: Location(x: 2, y: 1),
      correctLocation: Location(x: 1, y: 2),
    ),
    const Tile(
      value: 4,
      tileIsWhiteSpace: true,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 2, y: 2),
    ),
  ];

  Puzzle puzzle2x2unsolved = Puzzle(n: n, tiles: puzzle2x2TilesUnsolved);
  Puzzle puzzle2x2unsolvable = Puzzle(n: n, tiles: puzzle2x2TilesUnsolvable);

  group('Puzzle Model', () {
    test('Find tile of value 4 as whitespace tile', () {
      expect(puzzle2x2.whiteSpaceTile.value, 4);
    });

    test('Only tiles 2 and 3 are movable', () {
      expect(puzzle2x2.tileIsMovable(puzzle2x2Tiles[0]), false);
      expect(puzzle2x2.tileIsMovable(puzzle2x2Tiles[1]), true);
      expect(puzzle2x2.tileIsMovable(puzzle2x2Tiles[2]), true);
      expect(puzzle2x2.tileIsMovable(puzzle2x2Tiles[3]), false);
    });

    test('A tile is around of whitespace tile', () {
      expect(puzzle2x2.tileIsLeftOfWhiteSpace(puzzle2x2Tiles[2]), true);
      expect(puzzle2x2.tileIsRightOfWhiteSpace(puzzle2x2Tiles[2]), false);
      expect(puzzle2x2.tileIsTopOfWhiteSpace(puzzle2x2Tiles[1]), true);
      expect(puzzle2x2.tileIsBottomOfWhiteSpace(puzzle2x2Tiles[1]), false);
    });

    test('Get tile around whitespace tile', () {
      expect(puzzle2x2.tileTopOfWhitespace, puzzle2x2Tiles[1]);
      expect(puzzle2x2.tileBottomOfWhitespace, null);
      expect(puzzle2x2.tileRightOfWhitespace, null);
      expect(puzzle2x2.tileLeftOfWhitespace, puzzle2x2Tiles[2]);
    });

    test('Generates a list of correct locations from puzzle size', () {
      expect(Puzzle.generateTileCorrectLocations(n), correctLocations);
    });

    test('Generates tiles from locations', () {
      expect(
        Puzzle.getTilesFromLocations(
          correctLocations: correctLocations,
          currentLocations: correctLocations,
        ),
        puzzle2x2Tiles,
      );
    });

    test('Zero inversions in a solved puzzle', () {
      expect(puzzle2x2.countInversions(), 0);
    });

    test('1 inversion in unsolved 2x2 puzzle', () {
      /// An inversion is when a tile of a lower value is in a greater position than
      /// a tile of a higher value.
      /// In this puzzle, tile 2 is after tile 3
      expect(puzzle2x2unsolved.countInversions(), 1);
    });

    test('Checks if puzzle is solvable', () {
      expect(puzzle2x2unsolved.isSolvable(), true);
    });
  });
}
