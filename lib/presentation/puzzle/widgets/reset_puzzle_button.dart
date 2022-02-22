import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/animations/widgets/fade_in_transition.dart';
import 'package:flutter_puzzle_hack/presentation/dialogs/widgets/app_alert_dialog.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class ResetPuzzleButton extends StatelessWidget {
  const ResetPuzzleButton({Key? key}) : super(key: key);

  void initResetPuzzle(BuildContext context, PuzzleProvider puzzleProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AppAlertDialog(
          title: 'Are you sure you want to reset your puzzle?',
          onConfirm: () => puzzleProvider.generate(forceRefresh: true),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    PuzzleProvider puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);

    return FadeInTransition(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () => initResetPuzzle(context, puzzleProvider),
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
