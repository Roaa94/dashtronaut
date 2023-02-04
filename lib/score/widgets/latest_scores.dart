import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/score/providers/scores_provider.dart';
import 'package:dashtronaut/score/widgets/latest_score_item.dart';
import 'package:dashtronaut/core/layout/spacing.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LatestScores extends ConsumerWidget {
  const LatestScores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scores = ref.watch(scoresProvider);

    return Container(
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
                  color: Colors.white.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
            ),
            child: Text(
              // Todo: remove string constants when localization is set up
              Constants.scoresTitle,
              style: AppTextStyles.bodySm.copyWith(fontWeight: FontWeight.w700),
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
              child: const Text(Constants.emptyScoresMessage),
            ),
          ...List.generate(scores.length, (i) => LatestScoreItem(scores[i])),
        ],
      ),
    );
  }
}
