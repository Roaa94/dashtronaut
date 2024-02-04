import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/correct_tiles_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorrectTilesCount extends ConsumerWidget {
  const CorrectTilesCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleSize = ref.watch(puzzleSizeProvider);
    final correctTilesCount = ref.watch(correctTilesCountProvider);

    return RichText(
      text: TextSpan(
        text: 'Correct Tiles: ',
        style: AppTextStyles.body.copyWith(color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: '$correctTilesCount/${(puzzleSize * puzzleSize) - 1}',
            style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
