import 'package:dashtronaut/core/services/share-score/share_score_service.dart';
import 'package:dashtronaut/dash/phrases.dart';
import 'package:dashtronaut/dash/providers/phrases_provider.dart';
import 'package:dashtronaut/puzzle/providers/correct_tiles_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:dashtronaut/puzzle/widgets/tile/puzzle_tile.dart';
import 'package:dashtronaut/stop-watch/providers/stop_watch_provider.dart';
import 'package:dashtronaut/stop-watch/repositories/stop_watch_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;
  late StopWatchStorageRepository mockStopWatchRepository;
  late ShareScoreService mockShareScoreService;

  int hapticCount = 0;

  setUpAll(() {
    registerFallbackValue(MockRoute());
  });

  setUp(() {
    SystemChannels.platform.setMockMethodCallHandler(
      (MethodCall methodCall) {
        if (methodCall.method.contains('HapticFeedback')) hapticCount++;
        return null;
      },
    );

    mockPuzzleRepository = MockPuzzleStorageRepository();
    mockStopWatchRepository = MockStopWatchStorageRepository();
    mockShareScoreService = MockShareScoreService();
  });

  tearDown(() {
    SystemChannels.platform.setMockMethodCallHandler(null);
  });

  testWidgets(
    'HapticFeedback is fired when correct tile count increases',
    (WidgetTester tester) async {
      // 3  1
      //    2
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2Solvable2);
      when(() => mockStopWatchRepository.get()).thenReturn(0);
      hapticCount = 0;
      late WidgetRef ref;
      await tester.pumpProviderApp(
        Consumer(builder: (context, r, _) {
          ref = r;
          return const PuzzleBoard();
        }),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      // Using the puzzle `puzzle2x2Solvable2`
      // 3  1
      //    2
      // We can tap to move tile of value 3 to increment correct tiles count
      final tileFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is PuzzleTile &&
            (widget.child as PuzzleTile).tile.value == 3,
      );
      await tester.tap(tileFinder);
      expect(ref.read(correctTilesCountProvider), 1);
      expect(hapticCount, 1);
    },
  );

  testWidgets(
    'Solving puzzle triggers haptic feedback',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);
      when(() => mockStopWatchRepository.get()).thenReturn(0);

      hapticCount = 0;
      await tester.pumpProviderApp(
        const PuzzleBoard(),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      await tester.pump();

      // Using the puzzle `puzzle2x2`
      // 1  2
      //    3
      // We can tap to move tile of value 3 to solve the puzzle
      final tileFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is PuzzleTile &&
            (widget.child as PuzzleTile).tile.value == 3,
      );
      await tester.tap(tileFinder);
      await tester.pump();
      expect(hapticCount, 1);
    },
  );

  testWidgets(
    'Solving puzzle pauses the stop watch',
    (WidgetTester tester) async {
      const secondsElapsedWhenSolved = 10;
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);
      when(() => mockStopWatchRepository.get())
          .thenReturn(secondsElapsedWhenSolved);

      late WidgetRef ref;
      await tester.pumpProviderApp(
        Consumer(
          builder: (context, r, _) {
            ref = r;
            return const PuzzleBoard();
          },
        ),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      await tester.pump();

      // Using the puzzle `puzzle2x2`
      // 1  2
      //    3
      // We can tap to move tile of value 3 to solve the puzzle
      final tileFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is PuzzleTile &&
            (widget.child as PuzzleTile).tile.value == 3,
      );
      await tester.tap(tileFinder);
      await tester.pump();
      expect(
        ref.read(stopWatchProvider),
        secondsElapsedWhenSolved,
      );
    },
  );

  testWidgets(
    'Solving puzzle updates PhraseStatus to ${PhraseStatus.puzzleSolved}',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);
      when(() => mockStopWatchRepository.get()).thenReturn(0);

      late WidgetRef ref;
      await tester.pumpProviderApp(
        Consumer(
          builder: (context, r, _) {
            ref = r;
            return const PuzzleBoard();
          },
        ),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      await tester.pump();

      // Using the puzzle `puzzle2x2`
      // 1  2
      //    3
      // We can tap to move tile of value 3 to solve the puzzle
      final tileFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is PuzzleTile &&
            (widget.child as PuzzleTile).tile.value == 3,
      );
      await tester.tap(tileFinder);
      await tester.pump();
      expect(
        ref.read(phraseStatusProvider),
        PhraseStatus.puzzleSolved,
      );
    },
  );

  testWidgets(
    'Solving puzzle adds new score to scoresProvider',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);
      when(() => mockStopWatchRepository.get()).thenReturn(0);

      late WidgetRef ref;
      await tester.pumpProviderApp(
        Consumer(
          builder: (context, r, _) {
            ref = r;
            return const PuzzleBoard();
          },
        ),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      await tester.pump();

      // Using the puzzle `puzzle2x2`
      // 1  2
      //    3
      // We can tap to move tile of value 3 to solve the puzzle
      final tileFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is PuzzleTile &&
            (widget.child as PuzzleTile).tile.value == 3,
      );
      await tester.tap(tileFinder);
      await tester.pump();
      expect(
        ref.read(phraseStatusProvider),
        PhraseStatus.puzzleSolved,
      );
    },
  );

  testWidgets(
    'Tapping Restart in solved puzzle dialog resets puzzle',
    (WidgetTester tester) async {
      const initialMovesCount = 20;
      when(() => mockPuzzleRepository.get()).thenReturn(
        puzzle2x2.copyWith(movesCount: initialMovesCount),
      );
      when(() => mockStopWatchRepository.get()).thenReturn(0);

      late WidgetRef ref;
      await tester.pumpProviderApp(
        Consumer(
          builder: (context, r, _) {
            ref = r;
            return const PuzzleBoard();
          },
        ),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      await tester.pump();

      // Using the puzzle `puzzle2x2`
      // 1  2
      //    3
      // We can tap to move tile of value 3 to solve the puzzle
      final tileFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is PuzzleTile &&
            (widget.child as PuzzleTile).tile.value == 3,
      );
      await tester.tap(tileFinder);
      await tester.pump();

      await tester.tap(find.text('Restart'));
      await tester.pump();

      expect(ref.read(puzzleMovesCountProvider), 0);
    },
  );

  testWidgets(
    'Dialog pops when Restart button is clicked',
    (WidgetTester tester) async {
      final mockNavigatorObserver = MockNavigatorObserver();
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);
      when(() => mockStopWatchRepository.get()).thenReturn(0);

      await tester.pumpProviderApp(
        const PuzzleBoard(),
        navigatorObserver: mockNavigatorObserver,
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      await tester.pump();

      // Using the puzzle `puzzle2x2`
      // 1  2
      //    3
      // We can tap to move tile of value 3 to solve the puzzle
      final tileFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is PuzzleTile &&
            (widget.child as PuzzleTile).tile.value == 3,
      );
      await tester.tap(tileFinder);
      await tester.pump();

      await tester.tap(find.text('Restart'));
      await tester.pump();

      verify(() => mockNavigatorObserver.didPop(any(), any()));
    },
  );

  testWidgets(
    'Calls share from share score service when Share button is clicked'
    'in puzzle solved dialog',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);
      when(() => mockShareScoreService.share()).thenAnswer((_) async {});

      await tester.pumpProviderApp(
        const PuzzleBoard(),
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          shareScoreServiceProvider.overrideWithValue(mockShareScoreService),
        ],
      );
      await tester.pump();

      // Using the puzzle `puzzle2x2`
      // 1  2
      //    3
      // We can tap to move tile of value 3 to solve the puzzle
      final tileFinder = find.byWidgetPredicate(
            (widget) =>
        widget is GestureDetector &&
            widget.child is PuzzleTile &&
            (widget.child as PuzzleTile).tile.value == 3,
      );
      await tester.tap(tileFinder);
      await tester.pump();

      await tester.tap(find.text('Share'));
      await tester.pump();

      verify(() => mockShareScoreService.share()).called(1);
    },
  );
}
