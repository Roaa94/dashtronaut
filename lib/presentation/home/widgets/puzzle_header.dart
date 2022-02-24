import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/styles/spacing.dart';
import 'package:flutter_puzzle_hack/data/models/puzzle.dart';
import 'package:flutter_puzzle_hack/presentation/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack/presentation/animations/widgets/fade_in_transition.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/correct_tiles_count.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/moves_count.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/puzzle_stop_watch.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';

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
                  constraints: BoxConstraints(minWidth: (Puzzle.containerWidth(context) / 3) - Spacing.md),
                  child: const PuzzleStopWatch(),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: (Puzzle.containerWidth(context) / 3) - Spacing.md),
                  child: const MovesCount(),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: (Puzzle.containerWidth(context) / 3) - Spacing.md),
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
