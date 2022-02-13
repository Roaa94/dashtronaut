import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:provider/provider.dart';

class TileGestureDetector extends StatelessWidget {
  final Tile tile;
  final bool isPuzzleSolved;
  final Widget child;
  final Position tilePosition;

  const TileGestureDetector({
    Key? key,
    required this.tile,
    required this.tilePosition,
    required this.isPuzzleSolved,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PuzzleProvider puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);

    return IgnorePointer(
      ignoring: tile.tileIsWhiteSpace || isPuzzleSolved,
      child: GestureDetector(
        onHorizontalDragEnd: (_) {
          if (puzzleProvider.puzzle.tileIsMovableOnXAxis(tile)) {
            puzzleProvider.swapTilesAndUpdatePuzzle(tile);
          }
        },
        onVerticalDragEnd: (_) {
          if (puzzleProvider.puzzle.tileIsMovableOnYAxis(tile)) {
            puzzleProvider.swapTilesAndUpdatePuzzle(tile);
          }
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          Position _newPosition = Position(left: tilePosition.left! + details.delta.dx, top: tilePosition.top);
          if (puzzleProvider.puzzle.tileIsMovableOnXAxis(tile) && puzzleProvider.puzzle.tileCanMoveTo(tile, _newPosition)) {
            puzzleProvider.setDraggedTilePosition(tile.value, _newPosition);
          }
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          Position _newPosition = Position(left: tilePosition.left, top: tilePosition.top! + details.delta.dy);
          if (puzzleProvider.puzzle.tileIsMovableOnYAxis(tile) && puzzleProvider.puzzle.tileCanMoveTo(tile, _newPosition)) {
            puzzleProvider.setDraggedTilePosition(tile.value, _newPosition);
          }
        },
        child: child,
      ),
    );
  }
}
