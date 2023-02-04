import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/tiles_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_data.dart';

void main() {
  test('isSolved is true when tiles are in a solved arrangement', () {
    // 1   2
    // 3
    final tilesState = TilesState(tiles: puzzle2x2Solved.tiles);

    expect(tilesState.isSolved, isTrue);
  });

  test('isSolved is false when tiles are not in a solved arrangement', () {
    // 1  2
    //    3
    final tilesState = TilesState(tiles: puzzle2x2.tiles);

    expect(tilesState.isSolved, isFalse);
  });

  test('Can get whitespace tile', () {
    const whiteSpaceTileOf2x2CorrectPuzzle = Tile(
      value: 4,
      tileIsWhiteSpace: true,
      currentLocation: Location(x: 2, y: 2),
      correctLocation: Location(x: 2, y: 2),
    );

    final tilesState = TilesState(tiles: puzzle2x2Solved.tiles);

    expect(
      tilesState.whiteSpaceTile,
      whiteSpaceTileOf2x2CorrectPuzzle,
    );
  });

  test('Tile is movable when located around the whitespace tile', () {
    // 1  2
    //    3
    final tilesState = TilesState(tiles: puzzle2x2.tiles);

    const movableTile = Tile(
      value: 1,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 1, y: 1),
    );

    expect(
      tilesState.tileIsMovable(movableTile),
      isTrue,
    );
  });

  test('Tile is not movable when not located around the whitespace tile', () {
    // 1  2
    //    3
    final tilesState = TilesState(tiles: puzzle2x2.tiles);

    const nonMovableTile = Tile(
      value: 2,
      currentLocation: Location(x: 2, y: 1),
      correctLocation: Location(x: 2, y: 1),
    );

    expect(
      tilesState.tileIsMovable(nonMovableTile),
      isFalse,
    );
  });

  test('Finds tile on top of whitespace tile', () {
    // 1  2
    //    3
    final tilesState = TilesState(tiles: puzzle2x2.tiles);

    const topOfWhitespaceTile = Tile(
      value: 1,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 1, y: 1),
    );

    expect(
      tilesState.tileTopOfWhitespace,
      equals(topOfWhitespaceTile),
    );
  });

  test('Finds tile on right of whitespace tile', () {
    // 1  2
    //    3
    final tilesState = TilesState(tiles: puzzle2x2.tiles);

    const rightOfWhitespaceTile = Tile(
      value: 3,
      currentLocation: Location(x: 2, y: 2),
      correctLocation: Location(x: 1, y: 2),
    );

    expect(
      tilesState.tileRightOfWhitespace,
      equals(rightOfWhitespaceTile),
    );
  });

  test('Finds tile on the left of whitespace tile', () {
    // 3
    // 2  1
    final tilesState = TilesState(tiles: puzzle2x2Solvable.tiles);

    const leftOfWhitespaceTile = Tile(
      value: 3,
      correctLocation: Location(y: 2, x: 1),
      currentLocation: Location(y: 1, x: 1),
    );

    expect(
      tilesState.tileLeftOfWhitespace,
      equals(leftOfWhitespaceTile),
    );
  });

  test('Finds tile bottom of whitespace tile', () {
    // 3
    // 2  1
    final tilesState = TilesState(tiles: puzzle2x2Solvable.tiles);

    const bottomOfWhitespaceTile = Tile(
      value: 1,
      correctLocation: Location(y: 1, x: 1),
      currentLocation: Location(y: 2, x: 2),
    );

    expect(
      tilesState.tileBottomOfWhitespace,
      equals(bottomOfWhitespaceTile),
    );
  });
}
