import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/fade_in_transition.dart';
import 'package:dashtronaut/presentation/layout/puzzle_layout.dart';
import 'package:dashtronaut/presentation/layout/spacing.dart';
import 'package:dashtronaut/puzzle/widgets/correct_tiles_count.dart';
import 'package:dashtronaut/puzzle/widgets/moves_count.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_stop_watch.dart';
import 'package:flutter/material.dart';

class PuzzleHeader extends StatelessWidget {
  const PuzzleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PuzzleLayout puzzleLayout = PuzzleLayout(context);

    return FadeInTransition(
      delay: AnimationsManager.bgLayerAnimationDuration,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Dashtronaut', style: AppTextStyles.title),
            const SizedBox(height: 5),
            const Text(
              'Solve This Slide Puzzle..',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: 5,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: (puzzleLayout.containerWidth / 3) - Spacing.md),
                  child: const PuzzleStopWatch(),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: (puzzleLayout.containerWidth / 3) - Spacing.md),
                  child: const MovesCount(),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: (puzzleLayout.containerWidth / 3) - Spacing.md),
                  child: const CorrectTilesCount(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
