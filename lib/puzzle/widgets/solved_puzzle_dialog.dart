import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/core/widget_keys.dart';
import 'package:dashtronaut/core/widgets/app_alert_dialog.dart';
import 'package:dashtronaut/core/layout/screen_type_helper.dart';
import 'package:dashtronaut/core/layout/spacing.dart';
import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog_info.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:flutter/material.dart';

class SolvedPuzzleDialog extends StatelessWidget {
  const SolvedPuzzleDialog({
    super.key,
    required this.score,
    this.isWeb = false,
    this.onSharePressed,
    this.onRestartPressed,
  });

  final Score score;
  final bool isWeb;
  final VoidCallback? onSharePressed;
  final VoidCallback? onRestartPressed;

  String? get imageName {
    if (Constants.supportedPuzzleSizes.contains(score.puzzleSize)) {
      return 'solved-${score.puzzleSize}x${score.puzzleSize}.png';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ScreenTypeHelper screenTypeHelper = ScreenTypeHelper(context);

    Widget solvedPuzzleImage = ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: imageName == null
          ? Container()
          : Image.asset('assets/images/puzzle-solved/$imageName'),
    );

    Widget solvedPuzzleInfo = SolvedPuzzleDialogInfo(
      solvingDuration: score.winDuration,
      movesCount: score.winMovesCount,
      isWeb: isWeb,
      onSharePressed: onSharePressed,
      onRestartPressed: onRestartPressed,
    );

    Widget portraitContent = ConstrainedBox(
      key: WidgetKeys.solvedPuzzleDialogPortraitContent,
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          solvedPuzzleImage,
          const SizedBox(height: Spacing.sm),
          solvedPuzzleInfo,
        ],
      ),
    );

    Widget landscapeContent = Row(
      key: WidgetKeys.solvedPuzzleDialogLandscapeContent,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: solvedPuzzleImage),
        const SizedBox(width: Spacing.md),
        Expanded(flex: 4, child: solvedPuzzleInfo),
      ],
    );

    return AppAlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHPadding,
        vertical: Spacing.md,
      ),
      content:
          screenTypeHelper.landscapeMode ? landscapeContent : portraitContent,
    );
  }
}
