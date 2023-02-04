
import 'package:dashtronaut/core/helpers/duration_helper.dart';
import 'package:dashtronaut/core/layout/spacing.dart';
import 'package:dashtronaut/core/providers/is_web_provider.dart';
import 'package:dashtronaut/core/services/share-score/share_score_service.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';

class SolvedPuzzleDialogInfo extends ConsumerWidget {
  final Duration solvingDuration;

  const SolvedPuzzleDialogInfo({
    super.key,
    required this.solvingDuration,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movesCount = ref.watch(puzzleMovesCountProvider);
    final isWeb = ref.watch(isWebProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Congrats! You did it!',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: Spacing.xs),
            const Text(
              'You solved the puzzle! Share your score to challenge your friends',
            ),
            const SizedBox(height: Spacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.watch_later_outlined),
                      const SizedBox(width: 5),
                      Text(
                        DurationHelper.toFormattedTime(solvingDuration),
                        style: AppTextStyles.h1Bold,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    '$movesCount Moves',
                    style: AppTextStyles.h1Bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.md),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                label: const Text('Restart'),
                icon: const Icon(Icons.refresh),
              ),
            ),
            const SizedBox(width: Spacing.sm),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: ref.watch(shareScoreServiceProvider).share,
                label: const Text('Share'),
                icon: isWeb
                    ? const Icon(FontAwesomeIcons.twitter)
                    : const Icon(Icons.share),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
