import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/layout/puzzle_layout.dart';

class TileAnimatedPositioned extends StatelessWidget {
  final Tile tile;
  final bool isPuzzleSolved;
  final int puzzleSize;
  final Widget tileGestureDetector;

  const TileAnimatedPositioned({
    Key? key,
    required this.tile,
    required this.isPuzzleSolved,
    required this.puzzleSize,
    required this.tileGestureDetector,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tileWidth = PuzzleLayout.containerWidth(context) / puzzleSize;
    Position tilePosition = tile.getPosition(context, tileWidth);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      width: tileWidth,
      height: tileWidth,
      left: tilePosition.left,
      top: tilePosition.top,
      child: tileGestureDetector,
    );
  }
}
