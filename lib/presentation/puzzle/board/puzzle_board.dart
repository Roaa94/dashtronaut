import 'package:dashtronaut/models/tile.dart';
import 'package:dashtronaut/presentation/common/animations/utils/animations_manager.dart';
import 'package:dashtronaut/presentation/common/animations/widgets/pulse_transition.dart';
import 'package:dashtronaut/presentation/common/animations/widgets/scale_up_transition.dart';
import 'package:dashtronaut/presentation/layout/puzzle_layout.dart';
import 'package:dashtronaut/presentation/tile/tile_animated_positioned.dart';
import 'package:dashtronaut/presentation/tile/tile_content.dart';
import 'package:dashtronaut/presentation/tile/tile_gesture_detector.dart';
import 'package:dashtronaut/providers/puzzle_provider.dart';
import 'package:dashtronaut/providers/stop_watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PuzzleBoard extends StatelessWidget {
  PuzzleBoard({Key? key}) : super(key: key);

  final FocusNode keyboardListenerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    StopWatchProvider stopWatchProvider =
        Provider.of<StopWatchProvider>(context, listen: false);
    return ScaleUpTransition(
      delay: AnimationsManager.bgLayerAnimationDuration,
      child: Consumer<PuzzleProvider>(
        builder: (c, PuzzleProvider puzzleProvider, _) => RawKeyboardListener(
          onKey: (event) {
            puzzleProvider.handleKeyboardEvent(event);
            if (event is RawKeyDownEvent &&
                puzzleProvider.movesCount == 1 &&
                keyboardListenerFocusNode.hasFocus) {
              stopWatchProvider.start();
            }
          },
          focusNode: keyboardListenerFocusNode,
          child: Builder(
            builder: (context) {
              if (!keyboardListenerFocusNode.hasFocus) {
                FocusScope.of(context).requestFocus(keyboardListenerFocusNode);
              }
              return Center(
                child: SizedBox(
                  width: PuzzleLayout(context).containerWidth,
                  height: PuzzleLayout(context).containerWidth,
                  child: Stack(
                    children: List.generate(
                      puzzleProvider.tilesWithoutWhitespace.length,
                      (index) {
                        Tile tile =
                            puzzleProvider.tilesWithoutWhitespace[index];
                        return TileAnimatedPositioned(
                          tile: tile,
                          isPuzzleSolved: puzzleProvider.puzzle.isSolved,
                          puzzleSize: puzzleProvider.n,
                          tileGestureDetector: TileGestureDetector(
                            tile: puzzleProvider.tilesWithoutWhitespace[index],
                            tileContent: PulseTransition(
                              isActive:
                                  puzzleProvider.puzzle.tileIsMovable(tile) &&
                                      !puzzleProvider.puzzle.isSolved,
                              child: TileContent(
                                tile: tile,
                                isPuzzleSolved: puzzleProvider.puzzle.isSolved,
                                puzzleSize: puzzleProvider.n,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
