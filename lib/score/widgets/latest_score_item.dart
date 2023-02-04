import 'package:dashtronaut/core/helpers/duration_helper.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/core/layout/spacing.dart';
import 'package:flutter/material.dart';

class LatestScoreItem extends StatelessWidget {
  final Score score;

  const LatestScoreItem(this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).padding.left == 0
            ? Spacing.md
            : MediaQuery.of(context).padding.left,
        right: Spacing.screenHPadding,
        top: Spacing.sm,
        bottom: Spacing.sm,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text('${score.puzzleSize}x${score.puzzleSize}'),
          ),
          Expanded(
            child: Text(
              DurationHelper.toFormattedTime(
                Duration(seconds: score.secondsElapsed),
              ),
            ),
          ),
          Expanded(
            child: Text('${score.winMovesCount} Moves'),
          ),
        ],
      ),
    );
  }
}
