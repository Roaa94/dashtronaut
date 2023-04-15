import 'dart:math';

import 'package:dashtronaut/core/widgets/app_alert_dialog.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/reset_puzzle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;
  const seed = 2;

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
  });

  testWidgets(
    'Resets puzzle directly when movesCount is 0',
    (WidgetTester tester) async {
      final random = Random(seed);
      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: 2,
          movesCount: 0,
          tiles: [],
        ),
      );

      await tester.pumpProviderApp(
        const ResetPuzzleButton(),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          puzzleProvider.overrideWith(() => PuzzleNotifier(random: random)),
        ],
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(
        () => mockPuzzleRepository.updatePuzzle(
          tiles: solvable2x2PuzzleWithSeed2Reset,
          movesCount: 0,
        ),
      ).called(1);
    },
  );

  testWidgets(
    'Resets puzzle directly when puzzle is already solved',
    (WidgetTester tester) async {
      final random = Random(seed);
      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: 2,
          movesCount: 0,
          tiles: puzzle2x2TilesSolved,
        ),
      );

      await tester.pumpProviderApp(
        const ResetPuzzleButton(),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          puzzleProvider.overrideWith(() => PuzzleNotifier(random: random)),
        ],
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(
        () => mockPuzzleRepository.updatePuzzle(
          tiles: solvable2x2PuzzleWithSeed2,
          movesCount: 0,
        ),
      ).called(1);
    },
  );

  testWidgets(
    'Shows confirmation dialog when resetting puzzle and movesCount is more than 0',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: 2,
          movesCount: 20,
          tiles: [],
        ),
      );

      await tester.pumpProviderApp(
        const ResetPuzzleButton(),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(AppAlertDialog), findsOneWidget);
    },
  );

  testWidgets(
    'Resets puzzle & moves count upon confirming dialog',
    (WidgetTester tester) async {
      final random = Random(seed);
      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: 2,
          movesCount: 20,
          tiles: [],
        ),
      );

      await tester.pumpProviderApp(
        const ResetPuzzleButton(),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          puzzleProvider.overrideWith(() => PuzzleNotifier(random: random)),
        ],
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('Yes'));
      await tester.pumpAndSettle();

      verify(
        () => mockPuzzleRepository.updatePuzzle(
          tiles: solvable2x2PuzzleWithSeed2Reset,
          movesCount: 0,
        ),
      ).called(1);
    },
  );
}
