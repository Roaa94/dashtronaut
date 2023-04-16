import 'package:dashtronaut/puzzle/providers/correct_tiles_count_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:dashtronaut/puzzle/widgets/tile/puzzle_tile.dart';
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

  int hapticCount = 0;

  setUp(() {
    SystemChannels.platform.setMockMethodCallHandler(
      (MethodCall methodCall) {
        if (methodCall.method.contains('HapticFeedback')) hapticCount++;
        return null;
      },
    );

    mockPuzzleRepository = MockPuzzleStorageRepository();
    mockStopWatchRepository = MockStopWatchStorageRepository();
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
}
