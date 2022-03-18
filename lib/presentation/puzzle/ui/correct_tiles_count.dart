import 'package:flutter/material.dart';
import 'package:Dashtronaut/providers/puzzle_provider.dart';
import 'package:Dashtronaut/presentation/styles/app_text_styles.dart';
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
              text: '${puzzleProvider.correctTilesCount}/${puzzleProvider.puzzle.tiles.length - 1}',
              style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
