import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class MovesCount extends StatelessWidget {
  const MovesCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<PuzzleProvider, int>(
      selector: (c, puzzleProvider) => puzzleProvider.movesCount,
      builder: (c, int movesCount, _) => RichText(
        text: TextSpan(
          text: 'Moves: ',
          style: AppTextStyles.body,
          children: <TextSpan>[
            TextSpan(
              text: '$movesCount',
              style: AppTextStyles.bodyBold,
            ),
          ],
        ),
      ),
    );
  }
}
