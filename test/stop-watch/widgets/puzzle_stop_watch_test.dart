import 'package:dashtronaut/core/helpers/duration_helper.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/stop-watch/repositories/stop_watch_repository.dart';
import 'package:dashtronaut/stop-watch/widgets/puzzle_stop_watch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';

void main() {
  late StopWatchStorageRepository mockStopWatchRepository;

  setUp(() {
    mockStopWatchRepository = MockStopWatchStorageRepository();
  });

  testWidgets(
    'Displays the correct formatted stop watch time',
    (WidgetTester tester) async {
      const elapsed = 20;
      when(() => mockStopWatchRepository.get()).thenReturn(elapsed);

      await tester.pumpProviderApp(
        const PuzzleStopWatch(),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
        ],
      );

      await tester.pumpAndSettle();
      final finder = find.text(
        DurationHelper.toFormattedTime(const Duration(seconds: elapsed)),
      );
      expect(finder, findsOneWidget);
    },
  );
}
