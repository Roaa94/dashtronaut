import 'package:dashtronaut/core/helpers/duration_helper.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_header.dart';
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
    'Displays the correct information',
    (WidgetTester tester) async {
      const elapsed = 20;
      const movesCount = 30;
      final correctTilesCount = puzzle2x2TilesSolved.length - 1;

      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: 2,
          movesCount: movesCount,
          tiles: puzzle2x2TilesSolved,
        ),
      );

      when(() => mockStopWatchRepository.get()).thenReturn(elapsed);

      await tester.pumpProviderApp(
        const PuzzleHeader(),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
        ],
      );

      expect(
        find.textContaining('Moves: $movesCount', findRichText: true),
        findsOneWidget,
      );
      expect(
        find.textContaining(
          'Correct Tiles: $correctTilesCount',
          findRichText: true,
        ),
        findsOneWidget,
      );
      expect(
        find.textContaining(
          DurationHelper.toFormattedTime(const Duration(seconds: elapsed)),
        ),
        findsOneWidget,
      );
    },
  );
}
