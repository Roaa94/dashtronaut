import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/old_puzzle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CorrectTilesCount extends StatelessWidget {
  const CorrectTilesCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OldPuzzleProvider>(
      builder: (c, puzzleProvider, _) => RichText(
        text: TextSpan(
          text: 'Correct Tiles: ',
          style: AppTextStyles.body.copyWith(color: Colors.white),
          children: <TextSpan>[
            TextSpan(
              text:
                  '${puzzleProvider.correctTilesCount}/${puzzleProvider.puzzle.tiles.length - 1}',
              style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
