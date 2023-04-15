import 'package:dashtronaut/core/layout/screen_type_helper.dart';
import 'package:dashtronaut/core/widget_keys.dart';
import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_app.dart';

void main() {
  const movesCount = 20;

  testWidgets(
    'Renders solved puzzle dialog with correct image from puzzle size',
    (WidgetTester tester) async {
      const puzzleSize = 3;
      const solvingDuration = Duration(milliseconds: 2000);

      await tester.pumpProviderApp(
        const SolvedPuzzleDialog(
          solvingDuration: solvingDuration,
          puzzleSize: 3,
          movesCount: movesCount,
        ),
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
      await tester.pumpProviderApp(
        const SolvedPuzzleDialog(
          solvingDuration: Duration.zero,
          puzzleSize: 3,
          movesCount: movesCount,
        ),
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
      await tester.pumpProviderApp(
        MediaQuery(
          data: MediaQueryData(
            size: Size(
              // Todo: improve this test when layout logic is improved
              ScreenTypeHelper.breakpoints[ScreenType.small]! + 100,
              ScreenTypeHelper.breakpoints[ScreenType.small]! - 100,
            ),
          ),
          child: const SolvedPuzzleDialog(
            solvingDuration: Duration.zero,
            puzzleSize: 3,
            movesCount: movesCount,
          ),
        ),
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
