import 'dart:developer';

import 'package:dashtronaut/core/providers/is_web_provider.dart';
import 'package:dashtronaut/core/services/share-score/share_score_service.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/scale_up_transition.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/puzzle/providers/correct_tiles_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/providers/tiles_provider.dart';
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
    final puzzleIsSolved = ref.watch(puzzleIsSolvedProvider);
    final puzzleSize = ref.watch(puzzleSizeProvider);
    final tilesState = ref.watch(tilesProvider);
    final movesCount = ref.watch(puzzleMovesCountProvider);
    final secondsElapsed = ref.watch(stopWatchProvider);
    final isWeb = ref.watch(isWebProvider);

    ref.listen(correctTilesCountProvider, (previous, next) {
      if (previous != null && next > previous) {
        log('Triggering Haptic feedback!');
        HapticFeedback.mediumImpact();
      }
    });

    ref.listen(puzzleIsSolvedProvider, (previous, next) async {
      if (next != previous && next) {
        // Puzzle is solved!
        HapticFeedback.vibrate();
        ref.read(stopWatchProvider.notifier).pause();

        Future.delayed(const Duration(milliseconds: 200)).then((value) {
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
                  ref.read(stopWatchProvider.notifier).stop();
                  ref.read(tilesProvider.notifier).reset();
                  ref.read(puzzleMovesCountProvider.notifier).reset();
                  Navigator.of(context).pop();
                },
              );
            },
          );
        });
      }
    });

    // Todo: set up listeners for solving puzzle & phrases
    // Starting the puzzle should: (moves count = 1)
    // - Show a phrase with `PhraseState.puzzleStarted`
    //
    // Solving puzzle should:
    // - show a phrase with `PhraseState.puzzleSolved`
    // - Adds score to list
    //
    // Resetting puzzle with dialog should:
    // - Reset phrases state to `PhraseState.none`
    //
    // For any tile movement:
    // - Increase moves count provider
    // - If a tile gets to correct location, trigger `HapticFeedback.mediumImpact()`

    return ScaleUpTransition(
      delay: AnimationsManager.bgLayerAnimationDuration,
      child: PuzzleKeyboardListener(
        child: Center(
          child: SizedBox(
            width: PuzzleLayout(context).containerWidth,
            height: PuzzleLayout(context).containerWidth,
            child: Stack(
              children: List.generate(
                tilesState.withoutWhitespace.length,
                (index) {
                  Tile tile = tilesState.withoutWhitespace[index];
                  double tileWidth =
                      PuzzleLayout(context).containerWidth / puzzleSize;
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
                        if (isMovable) {
                          ref.read(tilesProvider.notifier).swapTiles(tile);
                          ref
                              .read(puzzleMovesCountProvider.notifier)
                              .increment();
                        }
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
        ),
      ),
    );
  }
}
