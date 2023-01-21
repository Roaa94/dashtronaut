import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/old_puzzle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovesCount extends StatelessWidget {
  const MovesCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<OldPuzzleProvider, int>(
      selector: (c, puzzleProvider) => puzzleProvider.movesCount,
      builder: (c, int movesCount, _) => RichText(
        text: TextSpan(
          text: 'Moves: ',
          style: AppTextStyles.body.copyWith(color: Colors.white),
          children: <TextSpan>[
            TextSpan(
              text: '$movesCount',
              style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
