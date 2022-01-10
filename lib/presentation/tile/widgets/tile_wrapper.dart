import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/enums/direction.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_container.dart';
import 'package:provider/provider.dart';

class TileWrapper extends StatelessWidget {
  final int tileValue;

  const TileWrapper({
    Key? key,
    required this.tileValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PuzzleProvider>(
      builder: (c, puzzleProvider, child) {
        Tile tile = puzzleProvider.tiles.firstWhere((_tile) => _tile.value == tileValue);

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          width: tile.width,
          height: tile.width,
          left: tile.position.left,
          top: tile.position.top,
          child: IgnorePointer(
            ignoring: tile.isWhiteSpaceTile,
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) => puzzleProvider.handleDrag(
                tile: tile,
                direction: details.velocity.pixelsPerSecond.dx < 0 ? Direction.left : Direction.right,
              ),
              onVerticalDragEnd: (DragEndDetails details) => puzzleProvider.handleDrag(
                tile: tile,
                direction: details.velocity.pixelsPerSecond.dy > 0 ? Direction.up : Direction.down,
              ),
              child: TileContainer(tile: tile),
            ),
          ),
        );
      },
    );
  }
}
