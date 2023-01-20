import 'package:dashtronaut/core/models/location.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Location targetLocation = const Location(x: 2, y: 2);

  group('Location model', () {
    test('Supports value comparison', () {
      expect(const Location(x: 2, y: 2), equals(targetLocation));
      expect(const Location(x: 3, y: 2), isNot(targetLocation));
    });

    test('Check if a location is located left of target location', () {
      expect(targetLocation.isLeftOf(const Location(x: 3, y: 2)), true);
      expect(targetLocation.isLeftOf(const Location(x: 3, y: 3)), false);
    });

    test('Check if a location is located right of target location', () {
      expect(targetLocation.isRightOf(const Location(x: 1, y: 2)), true);
      expect(targetLocation.isRightOf(const Location(x: 3, y: 3)), false);
    });

    test('Check if a location is located top of target location', () {
      expect(targetLocation.isTopOf(const Location(x: 2, y: 3)), true);
      expect(targetLocation.isTopOf(const Location(x: 3, y: 3)), false);
    });

    test('Check if a location is located bottom of target location', () {
      expect(targetLocation.isBottomOf(const Location(x: 2, y: 1)), true);
      expect(targetLocation.isTopOf(const Location(x: 1, y: 3)), false);
    });

    test('Check if a location is located around target location', () {
      expect(targetLocation.isLocatedAround(const Location(x: 1, y: 2)), true);
      expect(targetLocation.isLocatedAround(const Location(x: 2, y: 2)), false);
    });

    test('Compare locations - Check if a location before or after another', () {
      expect(targetLocation.compareTo(const Location(x: 3, y: 3)), -1);
      expect(targetLocation.compareTo(const Location(x: 1, y: 1)), 1);
      expect(targetLocation.compareTo(const Location(x: 2, y: 2)), 0);
    });

    test('Returns correct model from json map', () {
      Map<String, dynamic> locationJson = {'x': 0, 'y': 0};
      Location expectedLocation = const Location(x: 0, y: 0);

      expect(Location.fromJson(locationJson), expectedLocation);
    });

    test('Returns json map from model', () {
      Location location = const Location(x: 0, y: 1);
      Map<String, dynamic> expectedLocationJson = {'x': 0, 'y': 1};

      expect(location.toJson(), expectedLocationJson);
    });

    test('toString prints correctly', () {
      Location location = const Location(x: 2, y: 1);

      expect(location.toString(), '(1, 2)');
    });
  });
}
