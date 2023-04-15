import 'package:dashtronaut/core/services/game-logic/slide_puzzle_logic.dart';
import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tile inversions', () {
    final slidePuzzleLogic = SlidePuzzleLogic(2);
    test('isInversion returns false for equal tiles', () {
      const tile1 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      expect(slidePuzzleLogic.isInversion(tile1, tile2), isFalse);
    });

    test('isInversion returns false when second tile is a whitespace', () {
      const tile1 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 7,
        correctLocation: Location(y: 3, x: 1),
        currentLocation: Location(y: 1, x: 1),
        tileIsWhiteSpace: true,
      );

      expect(slidePuzzleLogic.isInversion(tile1, tile2), isFalse);
    });

    test('isInversion returns true when tiles are not inverted', () {
      const tile1 = Tile(
        value: 7,
        correctLocation: Location(y: 3, x: 1),
        currentLocation: Location(y: 1, x: 1),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      expect(slidePuzzleLogic.isInversion(tile1, tile2), isFalse);
    });

    test(
        'isInversion returns true when tiles are inverted, '
        'and tile2 value is more than tile1 value', () {
      const tile1 = Tile(
        value: 7,
        correctLocation: Location(y: 3, x: 1),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 1, x: 1),
        tileIsWhiteSpace: false,
      );

      expect(tile2.value < tile1.value, isFalse);
      expect(slidePuzzleLogic.isInversion(tile1, tile2), isTrue);
    });

    test(
        'isInversion returns true when tiles are inverted, '
        'and tile2 value is less than tile1 value', () {
      const tile1 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 1, x: 1),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 7,
        correctLocation: Location(y: 3, x: 1),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      expect(tile2.value < tile1.value, isTrue);
      expect(slidePuzzleLogic.isInversion(tile1, tile2), isTrue);
    });
  });
}
