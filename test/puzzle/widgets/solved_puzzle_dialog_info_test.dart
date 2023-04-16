import 'package:dashtronaut/core/helpers/duration_helper.dart';
import 'package:dashtronaut/core/services/share-score/share_score_service.dart';
import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';

void main() {
  const solvingDuration = Duration(milliseconds: 2000);

  testWidgets(
    'Renders correct solved puzzle score info',
    (WidgetTester tester) async {
      const movesCount = 20;

      await tester.pumpProviderApp(
        const SolvedPuzzleDialogInfo(
          solvingDuration: solvingDuration,
          movesCount: movesCount,
          isWeb: false,
        ),
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

  group('Share icon tests', () {
    testWidgets(
      'Renders Twitter icon when platform is web',
      (WidgetTester tester) async {
        await tester.pumpProviderApp(
          const SolvedPuzzleDialogInfo(
            solvingDuration: solvingDuration,
            movesCount: 20,
            isWeb: true,
          ),
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
        await tester.pumpProviderApp(
          const SolvedPuzzleDialogInfo(
            solvingDuration: solvingDuration,
            movesCount: 20,
            isWeb: false,
          ),
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
