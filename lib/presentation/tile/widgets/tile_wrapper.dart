import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_container.dart';

class TileWrapper extends StatelessWidget {
  final Tile tile;
  final Puzzle puzzle;
  final ValueChanged<Tile> swapTiles;

  const TileWrapper({
    Key? key,
    required this.tile,
    required this.puzzle,
    required this.swapTiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMovableOnX = puzzle.tileIsMovableOnXAxis(tile);
    bool isMovableOnY = puzzle.tileIsMovableOnYAxis(tile);
    bool tileIsRightOfWhiteSpace = puzzle.tileIsRightOfWhiteSpace(tile);
    bool tileIsLeftOfWhiteSpace = puzzle.tileIsLeftOfWhiteSpace(tile);
    bool tileIsTopOfWhiteSpace = puzzle.tileIsTopOfWhiteSpace(tile);
    bool tileIsBottomOfWhiteSpace = puzzle.tileIsBottomOfWhiteSpace(tile);

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
          onHorizontalDragEnd: (DragEndDetails details) {
            if (isMovableOnX) {
              if ((tileIsRightOfWhiteSpace && details.velocity.pixelsPerSecond.dx < 0) ||
                  (tileIsLeftOfWhiteSpace && details.velocity.pixelsPerSecond.dx > 0)) {
                swapTiles(tile);
              }
            }
          },
          onVerticalDragEnd: (DragEndDetails details) {
            if (isMovableOnY) {
              if ((tileIsTopOfWhiteSpace && details.velocity.pixelsPerSecond.dy > 0) ||
                  (tileIsBottomOfWhiteSpace && details.velocity.pixelsPerSecond.dy < 0)) {
                swapTiles(tile);
              }
            }
          },
          child: TileContainer(
            tile: tile,
            isTileMovable: isMovableOnX || isMovableOnY,
            // extraText: puzzle.getTileLocationText(tile),
          ),
        ),
      ),
    );
  }
}
