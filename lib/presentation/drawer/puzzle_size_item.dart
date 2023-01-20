import 'package:dashtronaut/presentation/layout/phrase_bubble_layout.dart';
import 'package:dashtronaut/core/styles/app_colors.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/phrases/providers/phrases_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:dashtronaut/puzzle/providers/stop_watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzleSizeItem extends StatelessWidget {
  final int size;

  const PuzzleSizeItem({required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StopWatchProvider stopWatchProvider =
        Provider.of<StopWatchProvider>(context, listen: false);
    PhrasesProvider phrasesProvider =
        Provider.of<PhrasesProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<PuzzleProvider>(
          builder: (c, puzzleProvider, _) {
            bool isSelected = puzzleProvider.n == size;
            return ElevatedButton(
              onPressed: () {
                if (!isSelected) {
                  puzzleProvider.resetPuzzleSize(size);
                  stopWatchProvider.stop();
                  if (size > 4) {
                    phrasesProvider
                        .setPhraseState(PhraseState.hardPuzzleSelected);
                  }
                  if (Scaffold.of(context).hasDrawer &&
                      Scaffold.of(context).isDrawerOpen) {
                    Navigator.of(context).pop();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(width: 1, color: Colors.white),
                ),
                minimumSize: const Size.fromHeight(50),
                backgroundColor: isSelected ? Colors.white : null,
              ),
              child: Text(
                '$size x $size',
                style: AppTextStyles.buttonSm.copyWith(
                    color: isSelected ? AppColors.primary : Colors.white),
              ),
            );
          },
        ),
        const SizedBox(height: 5),
        Text('${(size * size) - 1} Tiles', style: AppTextStyles.bodyXxs),
      ],
    );
  }
}
