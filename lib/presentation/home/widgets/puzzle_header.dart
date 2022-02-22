import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack/presentation/animations/widgets/fade_in_transition.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/puzzle_stop_watch.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

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
              spacing: 20,
              children: [
                const PuzzleStopWatch(),
                Selector<PuzzleProvider, int>(
                  selector: (c, puzzleProvider) => puzzleProvider.movesCount,
                  builder: (c, int movesCount, _) => Text('Moves: $movesCount', style: AppTextStyles.body),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
