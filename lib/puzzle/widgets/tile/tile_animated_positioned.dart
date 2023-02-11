import 'package:dashtronaut/puzzle/models/position.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileAnimatedPositioned extends ConsumerWidget {
  final Tile tile;
  final Widget tileGestureDetector;

  const TileAnimatedPositioned({
    super.key,
    required this.tile,
    required this.tileGestureDetector,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleSize = ref.watch(puzzleSizeProvider);
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
