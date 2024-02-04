import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/widgets/latest_score_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_app.dart';

void main() {
  const score = Score(
    secondsElapsed: 20,
    winMovesCount: 10,
    puzzleSize: 3,
  );

  testWidgets(
    '$LatestScoreItem container has padding equal to media query padding',
    (WidgetTester tester) async {
      const leftPadding = 40.0;

      await tester.pumpProviderApp(
        const MediaQuery(
          data: MediaQueryData(
            padding: EdgeInsets.only(left: leftPadding),
          ),
          child: LatestScoreItem(score),
        ),
      );

      final containerFinder = find.byType(Container).first;
      final containerWidget = tester.widget(containerFinder) as Container;

      expect(
        (containerWidget.padding as EdgeInsets).left,
        leftPadding,
      );
    },
  );
}
