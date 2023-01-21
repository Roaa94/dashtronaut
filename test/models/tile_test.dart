import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/position.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Tile tile = const Tile(
    value: 2,
    currentLocation: Location(x: 1, y: 3),
    correctLocation: Location(x: 2, y: 1),
  );

  group('Tile Model', () {
    test('Checks if tile is at correct location', () {
      Tile correctLocationTile = const Tile(
        value: 2,
        correctLocation: Location(x: 2, y: 1),
        currentLocation: Location(x: 2, y: 1),
      );

      Tile incorrectLocationTile = const Tile(
        value: 1,
        correctLocation: Location(x: 1, y: 1),
        currentLocation: Location(x: 2, y: 1),
      );

      expect(correctLocationTile.isAtCorrectLocation, true);
      expect(incorrectLocationTile.isAtCorrectLocation, false);
    });

    testWidgets(
      'Returns current position of tile in a Stack based on its width',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          Builder(builder: (BuildContext context) {
            expect(
              tile.getPosition(context, 100),
              const Position(top: 200, left: 0),
            );
            return const Placeholder();
          }),
        );
      },
    );

    test('Returns correct model from json map', () {
      Map<String, dynamic> tileJson = {
        'value': 1,
        'tileIsWhiteSpace': false,
        'currentLocation': {'x': 1, 'y': 1},
        'correctLocation': {'x': 1, 'y': 1},
      };

      Tile expectedTile = const Tile(
        value: 1,
        currentLocation: Location(x: 1, y: 1),
        correctLocation: Location(x: 1, y: 1),
      );

      expect(Tile.fromJson(tileJson), expectedTile);
    });

    test('Returns json map from model', () {
      Tile tile = const Tile(
        value: 1,
        currentLocation: Location(x: 1, y: 1),
        correctLocation: Location(x: 1, y: 1),
      );

      Map<String, dynamic> expectedTileJson = {
        'value': 1,
        'tileIsWhiteSpace': false,
        'currentLocation': {'x': 1, 'y': 1},
        'correctLocation': {'x': 1, 'y': 1},
      };

      expect(tile.toJson(), expectedTileJson);
    });

    test('toString prints correctly', () {
      expect(
          tile.toString(),
          equals(
              'Tile(value: 2, correctLocation: (1, 2), currentLocation: (3, 1))'));
    });

    test('copyWith updates tile', () {
      expect(
          tile.copyWith().currentLocation, equals(const Location(x: 1, y: 3)));
      expect(
        tile
            .copyWith(currentLocation: const Location(x: 2, y: 1))
            .currentLocation,
        equals(const Location(x: 2, y: 1)),
      );
    });
  });
}
