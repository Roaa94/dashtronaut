import 'package:Dashtronaut/models/location.dart';
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
  });
}
