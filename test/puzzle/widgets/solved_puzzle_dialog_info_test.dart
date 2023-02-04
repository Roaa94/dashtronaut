import 'package:dashtronaut/core/helpers/duration_helper.dart';
import 'package:dashtronaut/core/providers/is_web_provider.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';
import '../../utils/test_data.dart';

void main() {
  const solvingDuration = Duration(milliseconds: 2000);
  late PuzzleStorageRepository mockPuzzleRepository;

  setUp(() {
    registerFallbackValue(MockRoute());
    mockPuzzleRepository = MockPuzzleStorageRepository();
  });

  testWidgets(
    'Renders correct solved puzzle score info',
    (WidgetTester tester) async {
      const puzzleSize = 3;
      const movesCount = 20;

      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: puzzleSize,
          tiles: solvable3x3PuzzleWithSeed2,
          movesCount: movesCount,
        ),
      );

      await tester.pumpProviderApp(
        const SolvedPuzzleDialogInfo(
          // Todo: get from Riverpod provider and test
          solvingDuration: solvingDuration,
        ),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      await tester.pumpAndSettle();

      expect(
        find.textContaining('$movesCount'),
        findsOneWidget,
      );

      expect(
        find.textContaining(DurationHelper.toFormattedTime(solvingDuration)),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Can pop when Restart button is clicked',
    (WidgetTester tester) async {
      final mockNavigatorObserver = MockNavigatorObserver();
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle3x3);

      await tester.pumpProviderApp(
        const SolvedPuzzleDialogInfo(
          // Todo: get from Riverpod provider and test
          solvingDuration: solvingDuration,
        ),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          isWebProvider.overrideWithValue(true),
        ],
        navigatorObserver: mockNavigatorObserver,
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.byWidgetPredicate(
            (widget) => widget is Icon && widget.icon == Icons.refresh),
      );

      verify(() => mockNavigatorObserver.didPop(any(), any()));
    },
  );

  group('Share icon tests', () {
    testWidgets(
      'Renders Twitter icon when platform is web',
      (WidgetTester tester) async {
        when(() => mockPuzzleRepository.get()).thenReturn(puzzle3x3);

        await tester.pumpProviderApp(
          const SolvedPuzzleDialogInfo(
            // Todo: get from Riverpod provider and test
            solvingDuration: solvingDuration,
          ),
          overrides: [
            // Todo: find a way to override NotifierProvider's instead
            puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
            isWebProvider.overrideWithValue(true),
          ],
        );

        await tester.pumpAndSettle();

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Icon && widget.icon == FontAwesomeIcons.twitter,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Renders share icon when platform is not web',
      (WidgetTester tester) async {
        when(() => mockPuzzleRepository.get()).thenReturn(puzzle3x3);

        await tester.pumpProviderApp(
          const SolvedPuzzleDialogInfo(
            // Todo: get from Riverpod provider and test
            solvingDuration: solvingDuration,
          ),
          overrides: [
            // Todo: find a way to override NotifierProvider's instead
            puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
            isWebProvider.overrideWithValue(false),
          ],
        );

        await tester.pumpAndSettle();

        expect(
          find.byWidgetPredicate(
            (widget) => widget is Icon && widget.icon == Icons.share,
          ),
          findsOneWidget,
        );
      },
    );
  });
}
