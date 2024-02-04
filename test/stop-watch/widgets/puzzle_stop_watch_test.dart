import 'package:dashtronaut/core/helpers/duration_helper.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:dashtronaut/puzzle/widgets/tile/puzzle_tile.dart';
import 'package:dashtronaut/stop-watch/providers/stop_watch_provider.dart';
import 'package:dashtronaut/stop-watch/repositories/stop_watch_repository.dart';
import 'package:dashtronaut/stop-watch/widgets/puzzle_stop_watch.dart';
import 'package:flutter/material.dart' hide Listener;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';
import '../../utils/test_data.dart';

void main() {
  late StopWatchStorageRepository mockStopWatchRepository;
  late PuzzleStorageRepository mockPuzzleRepository;

  setUp(() {
    mockStopWatchRepository = MockStopWatchStorageRepository();
    mockPuzzleRepository = MockPuzzleStorageRepository();
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

  testWidgets(
    'Initially idle at 00:00',
    (WidgetTester tester) async {
      when(() => mockStopWatchRepository.get()).thenReturn(null);

      await tester.pumpProviderApp(
        const PuzzleStopWatch(),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleMovesCountProvider.overrideWithValue(0),
        ],
      );

      await tester.pumpAndSettle();
      final finder = find.text('00:00');
      expect(finder, findsOneWidget);
    },
  );

  testWidgets(
    'Stop watch starts with first puzzle move and displays correct time',
    (WidgetTester tester) async {
      when(() => mockStopWatchRepository.get()).thenReturn(null);
      // 3
      // 2  1
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2Solvable);

      await tester.pumpProviderApp(
        Column(
          children: const [
            PuzzleStopWatch(),
            Expanded(child: PuzzleBoard()),
          ],
        ),
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
        ],
      );

      await tester.pump();

      // Using the puzzle `puzzle2x2Solvable`
      // 3
      // 2  1
      // We can tap to move tile of value 1
      final tileFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is PuzzleTile &&
            (widget.child as PuzzleTile).tile.value == 1,
      );
      await tester.tap(tileFinder);

      await tester.pump();
      // await tester.pump();

      const elapsed = 2;
      await tester.pump(const Duration(seconds: elapsed));

      // Stop watch was started and is now displaying `elapsed` seconds
      final finder = find.text(
        DurationHelper.toFormattedTime(const Duration(seconds: elapsed)),
      );
      expect(finder, findsOneWidget);
    },
  );

  testWidgets(
    'Stop watch starts with first puzzle move',
    (WidgetTester tester) async {
      when(() => mockStopWatchRepository.get()).thenReturn(null);
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2Solvable);

      late WidgetRef ref;
      await tester.pumpProviderApp(
        Consumer(
          builder: (context, r, _) {
            ref = r;
            return const PuzzleStopWatch();
          },
        ),
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
        ],
      );
      await tester.pumpAndSettle();

      ref.read(puzzleProvider.notifier).swapTiles(
            puzzle2x2Solvable.tiles.firstWhere((tile) => tile.value == 1),
          );
      // First move was done, moves count is now 1
      expect(ref.read(puzzleMovesCountProvider), 1);

      const elapsed = 2;
      // Wait `elapsed` time
      await tester.pump(const Duration(seconds: elapsed));
      // Stop watch has elapsed correct time
      expect(ref.read(stopWatchProvider), elapsed);
    },
  );

  testWidgets(
    'Stop watch stops when puzzle is reset (moves become 0)',
    (WidgetTester tester) async {
      when(() => mockStopWatchRepository.get()).thenReturn(null);
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2Solvable);

      late WidgetRef ref;
      await tester.pumpProviderApp(
        Consumer(
          builder: (context, r, _) {
            ref = r;
            return const PuzzleStopWatch();
          },
        ),
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
        ],
      );
      await tester.pumpAndSettle();

      ref.read(puzzleProvider.notifier).swapTiles(
            puzzle2x2Solvable.tiles.firstWhere((tile) => tile.value == 1),
          );
      // First move was done, moves count is now 1
      expect(ref.read(puzzleMovesCountProvider), 1);

      ref.read(puzzleProvider.notifier).reset();

      await tester.pump();

      expect(ref.read(puzzleMovesCountProvider), 0);
      // Stop watch has stopped and reset
      expect(ref.read(stopWatchProvider), 0);
    },
  );
}
