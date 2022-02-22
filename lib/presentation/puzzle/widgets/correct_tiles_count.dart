import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class CorrectTilesCount extends StatelessWidget {
  const CorrectTilesCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PuzzleProvider>(
      builder: (c, puzzleProvider, _) => RichText(
        text: TextSpan(
          text: 'Correct Tiles: ',
          style: AppTextStyles.body.copyWith(color: Colors.white),
          children: <TextSpan>[
            TextSpan(
              text: '${puzzleProvider.correctTilesCount}/${puzzleProvider.puzzle.tiles.length}',
              style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
