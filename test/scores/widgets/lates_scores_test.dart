import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/repositories/scores_repository.dart';
import 'package:dashtronaut/score/widgets/latest_score_item.dart';
import 'package:dashtronaut/score/widgets/latest_scores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';

void main() {
  const scores = [
    Score(
      secondsElapsed: 30,
      winMovesCount: 10,
      puzzleSize: 4,
    ),
    Score(
      secondsElapsed: 30,
      winMovesCount: 15,
      puzzleSize: 5,
    ),
  ];

  late ScoresStorageRepository mockScoresRepository;

  setUp(() {
    mockScoresRepository = MockScoresRepository();
  });

  testWidgets(
    'Displays list of 2 $LatestScoreItem for 2 scores',
    (WidgetTester tester) async {
      when(() => mockScoresRepository.get()).thenReturn(scores);

      await tester.pumpProviderApp(
        const LatestScores(),
        overrides: [
          scoresRepositoryProvider.overrideWithValue(mockScoresRepository),
        ],
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(LatestScoreItem),
        findsNWidgets(scores.length),
      );
    },
  );

  testWidgets(
    'No $LatestScoreItem displayed when scores list is empty',
    (WidgetTester tester) async {
      when(() => mockScoresRepository.get()).thenReturn([]);

      await tester.pumpProviderApp(
        const LatestScores(),
        overrides: [
          scoresRepositoryProvider.overrideWithValue(mockScoresRepository),
        ],
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(LatestScoreItem),
        findsNothing,
      );
    },
  );

  testWidgets(
    'Latest Scores title container padding '
    'equals left padding from media query',
    (WidgetTester tester) async {
      when(() => mockScoresRepository.get()).thenReturn([]);

      const leftPadding = 40.0;

      await tester.pumpProviderApp(
        const MediaQuery(
          data: MediaQueryData(
            padding: EdgeInsets.only(left: leftPadding),
          ),
          child: LatestScores(),
        ),
        overrides: [
          scoresRepositoryProvider.overrideWithValue(mockScoresRepository),
        ],
      );

      await tester.pumpAndSettle();

      final scoresTitleContainerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.child is Text &&
            (widget.child as Text).data == Constants.scoresTitle,
      );
      final scoresTitleContainer =
          tester.widget(scoresTitleContainerFinder) as Container;

      expect(
        (scoresTitleContainer.padding as EdgeInsets).left,
        leftPadding,
      );
    },
  );

  testWidgets(
    'Empty scores text container padding '
    'equals left padding from media query',
    (WidgetTester tester) async {
      when(() => mockScoresRepository.get()).thenReturn([]);

      const leftPadding = 40.0;

      await tester.pumpProviderApp(
        const MediaQuery(
          data: MediaQueryData(
            padding: EdgeInsets.only(left: leftPadding),
          ),
          child: LatestScores(),
        ),
        overrides: [
          scoresRepositoryProvider.overrideWithValue(mockScoresRepository),
        ],
      );

      await tester.pumpAndSettle();

      final scoresTitleContainerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.child is Text &&
            (widget.child as Text).data == Constants.emptyScoresMessage,
      );
      final scoresTitleContainer =
          tester.widget(scoresTitleContainerFinder) as Padding;

      expect(
        (scoresTitleContainer.padding as EdgeInsets).left,
        leftPadding,
      );
    },
  );
}
