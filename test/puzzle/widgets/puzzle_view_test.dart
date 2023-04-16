import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_view.dart';
import 'package:dashtronaut/stop-watch/repositories/stop_watch_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;
  late StopWatchStorageRepository mockStopWatchRepository;

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
    mockStopWatchRepository = MockStopWatchStorageRepository();
  });

  testWidgets(
    '',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2Solved);
      when(() => mockStopWatchRepository.get()).thenReturn(0);

      await tester.pumpProviderApp(
        const PuzzleView(),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
    },
  );
}
