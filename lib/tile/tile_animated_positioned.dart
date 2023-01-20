import 'package:dashtronaut/core/models/position.dart';
import 'package:dashtronaut/core/models/tile.dart';
import 'package:dashtronaut/layout/puzzle_layout.dart';
import 'package:flutter/material.dart';

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
    double tileWidth = PuzzleLayout(context).containerWidth / puzzleSize;
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
