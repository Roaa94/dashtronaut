import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_content.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_gesture_detector.dart';

class TileWrapper extends StatelessWidget {
  final Tile tile;
  final bool isPuzzleSolved;
  final int puzzleSize;

  const TileWrapper({
    Key? key,
    required this.tile,
    required this.isPuzzleSolved,
    required this.puzzleSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(tile);
    double tileWidth = Puzzle.containerWidth(context) / puzzleSize;
    Position tilePosition = tile.getPosition(context, tileWidth);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      width: tileWidth,
      height: tileWidth,
      left: tilePosition.left,
      top: tilePosition.top,
      child: TileGestureDetector(
        tile: tile,
        isPuzzleSolved: isPuzzleSolved,
        child: TileContent(
          tile: tile,
          isPuzzleSolved: isPuzzleSolved,
          puzzleSize: puzzleSize,
        ),
      ),
    );
  }
}
