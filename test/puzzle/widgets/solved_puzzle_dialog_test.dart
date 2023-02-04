import 'package:dashtronaut/core/layout/screen_type_helper.dart';
import 'package:dashtronaut/core/widget_keys.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
  });

  testWidgets(
    'Renders solved puzzle dialog with correct image from puzzle size',
    (WidgetTester tester) async {
      const puzzleSize = 3;
      const movesCount = 20;
      const solvingDuration = Duration(milliseconds: 2000);

      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: puzzleSize,
          tiles: solvable3x3PuzzleWithSeed2,
          movesCount: movesCount,
        ),
      );

      await tester.pumpProviderApp(
        const SolvedPuzzleDialog(
          // Todo: get from Riverpod provider and test
          solvingDuration: solvingDuration,
        ),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      await tester.pumpAndSettle();

      final imageWidgetFinder = find.byType(Image);
      final imageWidget = tester.widget(imageWidgetFinder) as Image;

      expect(
        (imageWidget.image as AssetImage).assetName,
        'assets/images/puzzle-solved/solved-${puzzleSize}x$puzzleSize.png',
      );
    },
  );

  testWidgets(
    'Renders portrait content widget in portrait mode',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle3x3);

      await tester.pumpProviderApp(
        const SolvedPuzzleDialog(solvingDuration: Duration.zero),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      expect(
        find.byKey(WidgetKeys.solvedPuzzleDialogPortraitContent),
        findsOneWidget,
      );
      expect(
        find.byKey(WidgetKeys.solvedPuzzleDialogLandscapeContent),
        findsNothing,
      );
    },
  );

  testWidgets(
    'Renders landscape content widget in landscape mode',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle3x3);

      await tester.pumpProviderApp(
        MediaQuery(
          data: MediaQueryData(
            size: Size(
              // Todo: improve this test when layout logic is improved
              ScreenTypeHelper.breakpoints[ScreenType.small]! + 100,
              ScreenTypeHelper.breakpoints[ScreenType.small]! - 100,
            ),
          ),
          child: const SolvedPuzzleDialog(solvingDuration: Duration.zero),
        ),
        overrides: [
          // Todo: find a way to override NotifierProvider's instead
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      expect(
        find.byKey(WidgetKeys.solvedPuzzleDialogLandscapeContent),
        findsOneWidget,
      );
      expect(
        find.byKey(WidgetKeys.solvedPuzzleDialogPortraitContent),
        findsNothing,
      );
    },
  );
}
