import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/puzzle.dart';
import 'package:flutter_puzzle_hack/data/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_animated_positioned.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_content.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_gesture_detector.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_pulse_transition.dart';
import 'package:provider/provider.dart';

class PuzzleBoard extends StatelessWidget {
  PuzzleBoard({Key? key}) : super(key: key);

  final FocusNode keyboardListenerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<PuzzleProvider>(
      builder: (c, PuzzleProvider puzzleProvider, _) => Center(
        child: SizedBox(
          width: Puzzle.containerWidth(context),
          height: Puzzle.containerWidth(context),
          child: Stack(
            children: List.generate(
              puzzleProvider.tilesWithoutWhitespace.length,
              (index) {
                Tile _tile = puzzleProvider.tilesWithoutWhitespace[index];
                return TileAnimatedPositioned(
                  tile: _tile,
                  isPuzzleSolved: puzzleProvider.puzzle.isSolved,
                  puzzleSize: puzzleProvider.n,
                  tileGestureDetector: TileGestureDetector(
                    tile: puzzleProvider.tilesWithoutWhitespace[index],
                    isPuzzleSolved: puzzleProvider.puzzle.isSolved,
                    tileContent: TilePulseTransition(
                      tileIsMovable: puzzleProvider.puzzle.tileIsMovable(_tile),
                      tileContent: TileContent(
                        tile: _tile,
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
      ),
    );
  }
}
