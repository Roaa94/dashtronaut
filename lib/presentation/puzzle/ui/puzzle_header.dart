import 'package:flutter/material.dart';
import 'package:Dashtronaut/presentation/common/animations/utils/animations_manager.dart';
import 'package:Dashtronaut/presentation/common/animations/widgets/fade_in_transition.dart';
import 'package:Dashtronaut/presentation/layout/puzzle_layout.dart';
import 'package:Dashtronaut/presentation/puzzle/ui/correct_tiles_count.dart';
import 'package:Dashtronaut/presentation/puzzle/ui/moves_count.dart';
import 'package:Dashtronaut/presentation/puzzle/ui/puzzle_stop_watch.dart';
import 'package:Dashtronaut/presentation/styles/app_text_styles.dart';
import 'package:Dashtronaut/presentation/layout/spacing.dart';

class PuzzleHeader extends StatelessWidget {
  const PuzzleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  constraints: BoxConstraints(minWidth: (PuzzleLayout.containerWidth(context) / 3) - Spacing.md),
                  child: const PuzzleStopWatch(),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: (PuzzleLayout.containerWidth(context) / 3) - Spacing.md),
                  child: const MovesCount(),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: (PuzzleLayout.containerWidth(context) / 3) - Spacing.md),
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
