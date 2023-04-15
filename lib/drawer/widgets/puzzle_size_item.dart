import 'package:dashtronaut/core/styles/app_colors.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleSizeItem extends ConsumerWidget {
  final int size;

  const PuzzleSizeItem({required this.size, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleSize = ref.watch(puzzleSizeProvider);
    bool isSelected = puzzleSize == size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            if (!isSelected) {
              ref.read(puzzleSizeProvider.notifier).update(size);
              ref.read(puzzleProvider.notifier).reset();
              // Todo: stop the stop watch (test if this is already achieved by
              // the listener in PuzzleStopWatch widget
              // stopWatchProvider.stop();
              if (size > 4) {
                // Todo: trigger phrase
                //   phrasesProvider.setPhraseState(PhraseState.hardPuzzleSelected);
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
              color: isSelected ? AppColors.primary : Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text('${(size * size) - 1} Tiles', style: AppTextStyles.bodyXxs),
      ],
    );
  }
}
