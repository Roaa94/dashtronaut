import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/presentation/dialogs/widgets/app_alert_dialog.dart';
import 'package:flutter_puzzle_hack/presentation/layout/screen_type_helper.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle-solved-dialog/widgets/puzzle_score.dart';

class PuzzleSolvedDialog extends StatelessWidget {
  final int puzzleSize;
  final Duration solvingDuration;
  final int movesCount;

  const PuzzleSolvedDialog({
    Key? key,
    required this.puzzleSize,
    required this.solvingDuration,
    required this.movesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenTypeHelper _screenTypeHelper = ScreenTypeHelper(context);

    return AppAlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: UI.screenHPadding, vertical: UI.space),
      content: _screenTypeHelper.landscapeMode ? _landscapeContent : _portraitContent,
    );
  }

  Widget get _puzzleSolvedImage => ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'assets/images/puzzle-solved/solved-${puzzleSize}x$puzzleSize.png',
        ),
      );

  Widget get _portraitContent => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _puzzleSolvedImage,
          const SizedBox(height: UI.spaceSm),
          PuzzleScore(
            duration: solvingDuration,
            movesCount: movesCount,
          ),
        ],
      );

  Widget get _landscapeContent => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _puzzleSolvedImage),
          const SizedBox(width: UI.space),
          Expanded(
            flex: 4,
            child: PuzzleScore(
              duration: solvingDuration,
              movesCount: movesCount,
            ),
          ),
        ],
      );
}
