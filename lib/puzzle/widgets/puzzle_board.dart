import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/pulse_transition.dart';
import 'package:dashtronaut/core/animations/widgets/scale_up_transition.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/providers/tiles_provider.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_keyboard_listener.dart';
import 'package:dashtronaut/puzzle/widgets/tile/puzzle_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleBoard extends ConsumerWidget {
  const PuzzleBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleIsSolved = ref.watch(puzzleIsSolvedProvider);
    final puzzleSize = ref.watch(puzzleSizeProvider);
    final tilesState = ref.watch(tilesProvider);

    // Todo: set up listeners for solving puzzle & phrases
    // Starting the puzzle should: (moves count = 1)
    // - Start the stop watch
    // - Show a phrase with `PhraseState.puzzleStarted`
    //
    // Solving puzzle should:
    // - show the dialog
    // - stop the stop watch
    // - show a phrase with `PhraseState.puzzleSolved`
    //
    // Resetting puzzle with dialog should:
    // - Reset the stop watch (not start it, starting happens with first tile move)
    // - Reset phrases state to `PhraseState.none`

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

                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    width: tileWidth,
                    height: tileWidth,
                    left: tilePosition.left,
                    top: tilePosition.top,
                    child: PuzzleTile(
                      isMovable:
                          tilesState.tileIsMovable(tile) && !puzzleIsSolved,
                      tile: tile,
                      isPuzzleSolved: puzzleIsSolved,
                      puzzleSize: puzzleSize,
                      onTileInteraction: ([double? dx, double? dy]) {
                        ref
                            .read(tilesProvider.notifier)
                            .handleTileInteraction(tile, dy, dx);
                      },
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
