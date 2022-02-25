import 'package:Dashtronaut/helpers/duration_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DurationHelper', () {
    test('Returns 02 for 2', () {
      int digit = 2;
      String twoDigits = DurationHelper.twoDigits(digit);

      expect(twoDigits, '02');
    });

    test('Returns 02:00 for duration of 2 minutes', () {
      const Duration duration = Duration(minutes: 2);
      String formattedDuration = DurationHelper.toFormattedTime(duration);

      expect(formattedDuration, '02:00');
    });

    test('Returns 01:40 for duration of 100 seconds', () {
      const Duration duration = Duration(seconds: 100);
      String formattedDuration = DurationHelper.toFormattedTime(duration);

      expect(formattedDuration, '01:40');
    });
  });
}
