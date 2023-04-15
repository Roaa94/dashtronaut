import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/pulse_transition.dart';
import 'package:dashtronaut/core/animations/widgets/scale_up_transition.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/providers/tiles_provider.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_keyboard_listener.dart';
import 'package:dashtronaut/puzzle/widgets/tile/tile_animated_positioned.dart';
import 'package:dashtronaut/puzzle/widgets/tile/tile_content.dart';
import 'package:dashtronaut/puzzle/widgets/tile/tile_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleBoard extends ConsumerWidget {
  const PuzzleBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleIsSolved = ref.watch(puzzleIsSolvedProvider);
    final puzzleSize = ref.watch(puzzleSizeProvider);
    final tilesState = ref.watch(tilesProvider);

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
                  return TileAnimatedPositioned(
                    tile: tile,
                    tileGestureDetector: TileGestureDetector(
                      tile: tilesState.withoutWhitespace[index],
                      tileContent: PulseTransition(
                        isActive:
                            tilesState.tileIsMovable(tile) && !puzzleIsSolved,
                        child: TileContent(
                          tile: tile,
                          isPuzzleSolved: puzzleIsSolved,
                          puzzleSize: puzzleSize,
                        ),
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
