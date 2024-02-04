import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovesCount extends ConsumerWidget {
  const MovesCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movesCount = ref.watch(puzzleMovesCountProvider);

    return RichText(
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
    );
  }
}
