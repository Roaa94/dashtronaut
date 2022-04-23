import 'dart:io';

import 'package:dashtronaut/helpers/duration_helper.dart';
import 'package:dashtronaut/helpers/file_helper.dart';
import 'package:dashtronaut/helpers/share_score_helper.dart';
import 'package:dashtronaut/presentation/layout/spacing.dart';
import 'package:dashtronaut/presentation/styles/app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class PuzzleScore extends StatelessWidget {
  final Duration duration;
  final int movesCount;
  final int puzzleSize;

  const PuzzleScore({
    Key? key,
    required this.duration,
    required this.movesCount,
    required this.puzzleSize,
  }) : super(key: key);

  int get tilesCount => (puzzleSize * puzzleSize) - 1;

  @override
  Widget build(BuildContext context) {
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
                'You solved the puzzle! Share your score to challenge your friends'),
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
                        DurationHelper.toFormattedTime(duration),
                        style: AppTextStyles.h1Bold,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child:
                        Text('$movesCount Moves', style: AppTextStyles.h1Bold)),
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
                onPressed: () async {
                  try {
                    if (kIsWeb) {
                      await ShareScoreHelper.openLink(
                          ShareScoreHelper.getTwitterShareLink(
                              movesCount, duration, tilesCount));
                    } else {
                      File file = await FileHelper.getFileFromUrl(
                          ShareScoreHelper.getPuzzleSolvedImageUrl(puzzleSize));
                      await Share.shareFiles(
                        [file.path],
                        text: ShareScoreHelper.getPuzzleSolvedTextMobile(
                            movesCount, duration, tilesCount),
                      );
                    }
                  } catch (e) {
                    await ShareScoreHelper.openLink(
                        ShareScoreHelper.getTwitterShareLink(
                            movesCount, duration, tilesCount));
                    rethrow;
                  }
                },
                label: const Text('Share'),
                icon: kIsWeb
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
