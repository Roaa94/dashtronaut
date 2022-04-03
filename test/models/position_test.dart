import 'dart:ui';

import 'package:Dashtronaut/models/position.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Position model', () {
    Position targetPosition = const Position(left: 10, top: 10);

    test('Supports value comparison', () {
      expect(const Position(left: 10, top: 10), equals(targetPosition));
      expect(const Position(left: 10, top: 10, right: null, bottom: null),
          equals(targetPosition));

      expect(const Position(left: 10, top: 200), isNot(targetPosition));
      expect(const Position(left: 10, top: null), isNot(targetPosition));
    });

    group('Position lerp functionality', () {
      Position startPosition = const Position(left: 10, top: 10);
      Position endPosition = const Position(left: 100, top: 100);

      test('Returns zero position if one is null', () {
        expect(Position.lerp(startPosition, null, 0), const Position.zero());
      });

      test('Returns same start position if lerp double is 0', () {
        expect(Position.lerp(startPosition, endPosition, 0), startPosition);
      });

      test('Returns correct lerpDouble values between two positions', () {
        double t = 0.5;
        double? newLeft =
            lerpDouble(startPosition.left ?? 0, endPosition.left ?? 0, t);
        double? newTop =
            lerpDouble(startPosition.top ?? 0, endPosition.top ?? 0, t);
        expect(
          Position.lerp(startPosition, endPosition, t),
          Position(left: newLeft, top: newTop),
        );
      });

      test('Returns same end position if lerp double is 1', () {
        expect(Position.lerp(startPosition, endPosition, 1), endPosition);
      });

      test(
          'Returns same start position if lerp double is 0 and one position param in null',
          () {
        expect(Position.lerp(startPosition, const Position(left: 10), 0),
            startPosition);
      });

      test('toString prints correctly', () {
        Position position = const Position(left: 10.222, top: 20.666);

        expect(position.toString(), '20.67, null, null, 10.22');
      });

      test('copyWith updates position', () {
        Position position = const Position(left: 10, top: 20);

        expect(position.copyWith().bottom, isNull);
        expect(position.copyWith(bottom: 0).bottom, 0);
      });
    });
  });
}
