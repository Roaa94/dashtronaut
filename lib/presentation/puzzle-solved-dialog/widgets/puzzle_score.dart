import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/helpers/duration_helper.dart';
import 'package:flutter_puzzle_hack/helpers/file_helper.dart';
import 'package:flutter_puzzle_hack/helpers/links_helper.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
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
            const SizedBox(height: UI.spaceXs),
            const Text('You solved the puzzle! Share your score to challenge your friends'),
            const SizedBox(height: UI.spaceSm),
            const Text('Score'),
            const SizedBox(height: UI.spaceXs),
            Row(
              children: [
                const Icon(Icons.watch_later_outlined),
                const SizedBox(width: 5),
                Text(
                  DurationHelper.toFormattedTime(duration),
                  style: AppTextStyles.h1Bold,
                ),
              ],
            ),
            const SizedBox(height: UI.spaceXs),
            Text('$movesCount Moves', style: AppTextStyles.h1Bold),
            const SizedBox(height: UI.space),
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
            const SizedBox(width: UI.spaceSm),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    File file = await FileHelper.getImageFileFromUrl(LinksHelper.getPuzzleSolvedImageUrl(puzzleSize));
                    if (kIsWeb) {
                      await LinksHelper.openLink(LinksHelper.getTwitterShareLink(movesCount, duration));
                    } else {
                      await Share.shareFiles(
                        [file.path],
                        text: LinksHelper.getPuzzleSolvedText(movesCount, duration),
                      );
                    }
                  } catch (e) {
                    await LinksHelper.openLink(LinksHelper.getTwitterShareLink(movesCount, duration));
                    rethrow;
                  }
                },
                label: const Text('Share'),
                icon: kIsWeb ? const Icon(FontAwesomeIcons.twitter) : const Icon(Icons.share),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
