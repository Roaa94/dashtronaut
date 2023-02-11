import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/fade_in_transition.dart';
import 'package:dashtronaut/core/widgets/app_alert_dialog.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/tiles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPuzzleButton extends ConsumerWidget {
  const ResetPuzzleButton({super.key});

  void _showDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AppAlertDialog(
          title: 'Are you sure you want to reset your puzzle?',
          onConfirm: () {
            ref.read(tilesProvider.notifier).reset();
            ref.read(puzzleMovesCountProvider.notifier).update(0);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleIsSolved = ref.watch(puzzleIsSolvedProvider);
    final movesCount = ref.watch(puzzleMovesCountProvider);

    return FadeInTransition(
      delay: AnimationsManager.bgLayerAnimationDuration,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () {
            if (movesCount == 0 || puzzleIsSolved) {
              ref.read(tilesProvider.notifier).reset();
            } else {
              _showDialog(context, ref);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.refresh),
              SizedBox(width: 7),
              Text('Reset', style: AppTextStyles.button),
            ],
          ),
        ),
      ),
    );
  }
}
