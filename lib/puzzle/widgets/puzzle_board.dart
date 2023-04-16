
import 'dart:developer';

import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/scale_up_transition.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/puzzle/providers/correct_tiles_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_keyboard_listener.dart';
import 'package:dashtronaut/puzzle/widgets/tile/puzzle_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleBoard extends ConsumerWidget {
  const PuzzleBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleIsSolved = ref.watch(puzzleIsSolvedProvider);
    final puzzleSize = ref.watch(puzzleSizeProvider);
    final tilesState = ref.watch(puzzleProvider);

    ref.listen(correctTilesCountProvider, (previous, next) {
      if (previous != null && next > previous) {
        log('Triggering Haptic feedback!');
        HapticFeedback.mediumImpact();
      }
    });

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
        ),
      ),
    );
  }
}
