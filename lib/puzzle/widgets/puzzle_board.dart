import 'dart:developer';

import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/core/providers/is_web_provider.dart';
import 'package:dashtronaut/core/services/share-score/share_score_service.dart';
import 'package:dashtronaut/dash/phrases.dart';
import 'package:dashtronaut/dash/providers/phrases_provider.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/correct_tiles_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_keyboard_listener.dart';
import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog.dart';
import 'package:dashtronaut/puzzle/widgets/tile/puzzle_tile.dart';
import 'package:dashtronaut/stop-watch/providers/stop_watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleBoard extends ConsumerWidget {
  const PuzzleBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleContainerWidth = PuzzleLayout(context).containerWidth;
    final puzzleIsSolved = ref.watch(puzzleIsSolvedProvider);
    final puzzleSize = ref.watch(puzzleSizeProvider);
    final tilesState = ref.watch(puzzleProvider);
    final movesCount = ref.watch(puzzleMovesCountProvider);
    final secondsElapsed = ref.watch(stopWatchProvider);
    final isWeb = ref.watch(isWebProvider);

    ref.listen(correctTilesCountProvider, (previous, next) {
      if (previous != null && next > previous) {
        if (next < ((puzzleSize * puzzleSize) - 1)) {
          log('Triggering Haptic feedback!');
          HapticFeedback.mediumImpact();
        }
      }
    });

    // Todo: set up listeners for solving puzzle & phrases
    // Starting the puzzle should: (moves count = 1)
    // - Show a phrase with `PhraseState.puzzleStarted`
    //
    // Solving puzzle should:
    // - Adds score to list
    ref.listen(puzzleIsSolvedProvider, (previous, next) {
      if (next != previous && next) {
        // Puzzle is solved!
        HapticFeedback.vibrate();
        ref.read(stopWatchProvider.notifier).pause();
        ref.read(phraseStatusProvider.notifier).state =
            PhraseStatus.puzzleSolved;

        Future.delayed(AnimationsManager.puzzleSolvedDialogDelay, () {
          showDialog(
            context: context,
            builder: (context) {
              return SolvedPuzzleDialog(
                movesCount: movesCount,
                solvingDuration: Duration(seconds: secondsElapsed),
                puzzleSize: puzzleSize,
                isWeb: isWeb,
                onSharePressed: ref.read(shareScoreServiceProvider).share,
                onRestartPressed: () {
                  ref.read(puzzleProvider.notifier).reset();
                  Navigator.of(context).pop(true);
                },
              );
            },
          ).then((result) {
            if (result == null) {
              // Dialog dismissed
              ref.read(puzzleProvider.notifier).reset();
            }
          });
        });
      }
    });

    return PuzzleKeyboardListener(
      child: SizedBox(
        width: puzzleContainerWidth,
        height: puzzleContainerWidth,
        child: Stack(
          children: List.generate(
            tilesState.withoutWhitespace.length,
            (index) {
              Tile tile = tilesState.withoutWhitespace[index];
              double tileWidth = puzzleContainerWidth / puzzleSize;
              final tilePosition = tile.getPosition(context, tileWidth);
              final isMovable =
                  tilesState.tileIsMovable(tile) && !puzzleIsSolved;

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                width: tileWidth,
                height: tileWidth,
                left: tilePosition.left,
                top: tilePosition.top,
                child: GestureDetector(
                  onTap: () {
                    ref.read(puzzleProvider.notifier).swapTiles(tile);
                  },
                  child: PuzzleTile(
                    isMovable: isMovable,
                    tile: tile,
                    isPuzzleSolved: puzzleIsSolved,
                    puzzleSize: puzzleSize,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
