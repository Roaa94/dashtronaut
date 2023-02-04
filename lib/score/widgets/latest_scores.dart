import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/widgets/latest_score_item.dart';
import 'package:dashtronaut/core/layout/spacing.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/old_puzzle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestScores extends StatelessWidget {
  const LatestScores({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<OldPuzzleProvider, List<Score>>(
      selector: (c, puzzleProvider) => puzzleProvider.scores.reversed.toList(),
      builder: (c, List<Score> scores, child) => Container(
        padding: const EdgeInsets.symmetric(vertical: Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).padding.left == 0
                    ? Spacing.md
                    : MediaQuery.of(context).padding.left,
                right: Spacing.screenHPadding,
                bottom: Spacing.xs,
              ),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.white.withOpacity(0.5), width: 0.5)),
              ),
              child: Text(
                'Latest Scores',
                style:
                    AppTextStyles.bodySm.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            if (scores.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).padding.left == 0
                      ? Spacing.md
                      : MediaQuery.of(context).padding.left,
                  right: Spacing.screenHPadding,
                  top: Spacing.xs,
                  bottom: Spacing.xs,
                ),
                child: const Text(
                    'Solve the puzzle to see your scores here! You can do it!'),
              ),
            ...List.generate(scores.length, (i) => LatestScoreItem(scores[i])),
          ],
        ),
      ),
    );
  }
}
