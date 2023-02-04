import 'package:dashtronaut/core/widget_keys.dart';
import 'package:dashtronaut/core/widgets/app_alert_dialog.dart';
import 'package:dashtronaut/core/layout/screen_type_helper.dart';
import 'package:dashtronaut/core/layout/spacing.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SolvedPuzzleDialog extends ConsumerWidget {
  final Duration solvingDuration;

  const SolvedPuzzleDialog({
    super.key,
    required this.solvingDuration,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleSize = ref.watch(puzzleSizeProvider);

    final imageName = 'solved-${puzzleSize}x$puzzleSize.png';
    ScreenTypeHelper screenTypeHelper = ScreenTypeHelper(context);

    Widget solvedPuzzleImage = ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset('assets/images/puzzle-solved/$imageName'),
    );

    Widget solvedPuzzleInfo = SolvedPuzzleDialogInfo(
      solvingDuration: solvingDuration,
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
