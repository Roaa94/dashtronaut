import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_data.dart';

void main() {
  test('isSolved is true when tiles are in a solved arrangement', () {
    // 1   2
    // 3
    final puzzleState = PuzzleState(tiles: puzzle2x2Solved.tiles);

    expect(puzzleState.isSolved, isTrue);
  });

  test('can copy', () {
    final puzzleState = PuzzleState(tiles: puzzle2x2Solved.tiles);

    final newPuzzleState = puzzleState.copyWith();

    expect(newPuzzleState, puzzleState);
  });

  test('gets tiles list without whitespace tile', () {
    // 1   2
    // 3
    final puzzleState = PuzzleState(tiles: puzzle2x2Solved.tiles);

    const expectedTilesWithoutWhitespaceTile = [
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
    ];

    expect(
      puzzleState.withoutWhitespace,
      equals(expectedTilesWithoutWhitespaceTile),
    );
  });

  test('isSolved is false when tiles are not in a solved arrangement', () {
    // 1  2
    //    3
    final puzzleState = PuzzleState(tiles: puzzle2x2.tiles);

    expect(puzzleState.isSolved, isFalse);
  });

  test('Can get whitespace tile', () {
    const whiteSpaceTileOf2x2CorrectPuzzle = Tile(
      value: 4,
      tileIsWhiteSpace: true,
      currentLocation: Location(x: 2, y: 2),
      correctLocation: Location(x: 2, y: 2),
    );

    final puzzleState = PuzzleState(tiles: puzzle2x2Solved.tiles);

    expect(
      puzzleState.whiteSpaceTile,
      whiteSpaceTileOf2x2CorrectPuzzle,
    );
  });

  test('Tile is movable when located around the whitespace tile', () {
    // 1  2
    //    3
    final puzzleState = PuzzleState(tiles: puzzle2x2.tiles);

    const movableTile = Tile(
      value: 1,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 1, y: 1),
    );

    expect(
      puzzleState.tileIsMovable(movableTile),
      isTrue,
    );
  });

  test('Tile is not movable when not located around the whitespace tile', () {
    // 1  2
    //    3
    final puzzleState = PuzzleState(tiles: puzzle2x2.tiles);

    const nonMovableTile = Tile(
      value: 2,
      currentLocation: Location(x: 2, y: 1),
      correctLocation: Location(x: 2, y: 1),
    );

    expect(
      puzzleState.tileIsMovable(nonMovableTile),
      isFalse,
    );
  });

  test('Finds tile on top of whitespace tile', () {
    // 1  2
    //    3
    final puzzleState = PuzzleState(tiles: puzzle2x2.tiles);

    const topOfWhitespaceTile = Tile(
      value: 1,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 1, y: 1),
    );

    expect(
      puzzleState.tileTopOfWhitespace,
      equals(topOfWhitespaceTile),
    );
  });

  test('Finds tile on right of whitespace tile', () {
    // 1  2
    //    3
    final puzzleState = PuzzleState(tiles: puzzle2x2.tiles);

    const rightOfWhitespaceTile = Tile(
      value: 3,
      currentLocation: Location(x: 2, y: 2),
      correctLocation: Location(x: 1, y: 2),
    );

    expect(
      puzzleState.tileRightOfWhitespace,
      equals(rightOfWhitespaceTile),
    );
  });

  test('Finds tile on the left of whitespace tile', () {
    // 3
    // 2  1
    final puzzleState = PuzzleState(tiles: puzzle2x2Solvable.tiles);

    const leftOfWhitespaceTile = Tile(
      value: 3,
      correctLocation: Location(y: 2, x: 1),
      currentLocation: Location(y: 1, x: 1),
    );

    expect(
      puzzleState.tileLeftOfWhitespace,
      equals(leftOfWhitespaceTile),
    );
  });

  test('Finds tile bottom of whitespace tile', () {
    // 3
    // 2  1
    final puzzleState = PuzzleState(tiles: puzzle2x2Solvable.tiles);

    const bottomOfWhitespaceTile = Tile(
      value: 1,
      correctLocation: Location(y: 1, x: 1),
      currentLocation: Location(y: 2, x: 2),
    );

    expect(
      puzzleState.tileBottomOfWhitespace,
      equals(bottomOfWhitespaceTile),
    );
  });
}
