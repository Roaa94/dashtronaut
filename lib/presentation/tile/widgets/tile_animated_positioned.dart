import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:provider/provider.dart';

class TileAnimatedPositioned extends StatelessWidget {
  final Tile tile;
  final Widget tileGestureDetector;
  final Position tilePosition;

  const TileAnimatedPositioned({
    Key? key,
    required this.tile,
    required this.tileGestureDetector,
    required this.tilePosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<PuzzleProvider, Duration>(
      child: tileGestureDetector,
      selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.tileDragDurations[tile.value]!,
      builder: (c, Duration animationDuration, tileGestureDetector) {
        return AnimatedPositioned(
          duration: animationDuration,
          curve: Curves.easeOut,
          width: tile.width,
          height: tile.width,
          left: tilePosition.left,
          top: tilePosition.top,
          child: tileGestureDetector!,
        );
      },
    );
  }
}
