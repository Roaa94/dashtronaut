import 'package:dashtronaut/presentation/common/animations/utils/animations_manager.dart';
import 'package:dashtronaut/presentation/common/animations/widgets/fade_in_transition.dart';
import 'package:dashtronaut/presentation/common/dialogs/app_alert_dialog.dart';
import 'package:dashtronaut/presentation/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:dashtronaut/puzzle/providers/stop_watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPuzzleButton extends StatelessWidget {
  const ResetPuzzleButton({Key? key}) : super(key: key);

  void initResetPuzzle(
    BuildContext context,
    PuzzleProvider puzzleProvider,
    StopWatchProvider stopWatchProvider,
  ) {
    if (puzzleProvider.hasStarted && !puzzleProvider.puzzle.isSolved) {
      showDialog(
        context: context,
        builder: (context) {
          return AppAlertDialog(
            title: 'Are you sure you want to reset your puzzle?',
            onConfirm: () {
              stopWatchProvider.stop();
              puzzleProvider.generate(forceRefresh: true);
            },
          );
        },
      );
    } else {
      stopWatchProvider.stop();
      puzzleProvider.generate(forceRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    StopWatchProvider stopWatchProvider =
        Provider.of<StopWatchProvider>(context, listen: false);

    return FadeInTransition(
      delay: AnimationsManager.bgLayerAnimationDuration,
      child: Consumer<PuzzleProvider>(
        builder: (c, puzzleProvider, _) => Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () =>
                initResetPuzzle(context, puzzleProvider, stopWatchProvider),
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
      ),
    );
  }
}
