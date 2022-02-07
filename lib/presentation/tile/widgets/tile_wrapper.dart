import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_container.dart';
import 'package:provider/provider.dart';

class TileWrapper extends StatefulWidget {
  final Tile tile;

  const TileWrapper({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  State<TileWrapper> createState() => _TileWrapperState();
}

class _TileWrapperState extends State<TileWrapper> {
  late PuzzleProvider puzzleProvider;

  @override
  void initState() {
    puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PuzzleProvider, Tile>(
      selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.getTileFromValue(widget.tile.value),
      builder: (c, Tile _tile, _) {
        return Selector<PuzzleProvider, Position>(
          selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.draggedTilePositions[_tile.value]!,
          child: TileContainer(tile: _tile),
          builder: (c, Position tilePosition, child) {
            return Selector<PuzzleProvider, Duration>(
              selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.tileDragDurations[_tile.value]!,
              builder: (c, Duration animationDuration, child) {
                return AnimatedPositioned(
                  duration: animationDuration,
                  curve: Curves.easeOut,
                  width: _tile.width,
                  height: _tile.width,
                  left: tilePosition.left,
                  top: tilePosition.top,
                  child: child!,
                );
              },
              child: IgnorePointer(
                ignoring: _tile.tileIsWhiteSpace,
                child: GestureDetector(
                  onHorizontalDragEnd: (_) {
                    if (puzzleProvider.puzzle.tileIsMovableOnXAxis(_tile)) {
                      puzzleProvider.swapTilesAndUpdatePuzzle(_tile);
                    }
                  },
                  onVerticalDragEnd: (_) {
                    if (puzzleProvider.puzzle.tileIsMovableOnYAxis(_tile)) {
                      puzzleProvider.swapTilesAndUpdatePuzzle(_tile);
                    }
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    Position _newPosition = Position(left: tilePosition.left! + details.delta.dx, top: tilePosition.top);
                    if (puzzleProvider.puzzle.tileIsMovableOnXAxis(_tile) && puzzleProvider.puzzle.tileCanMoveTo(_tile, _newPosition)) {
                      puzzleProvider.setDraggedTilePosition(_tile.value, _newPosition);
                    }
                  },
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    Position _newPosition = Position(left: tilePosition.left, top: tilePosition.top! + details.delta.dy);
                    if (puzzleProvider.puzzle.tileIsMovableOnYAxis(_tile) && puzzleProvider.puzzle.tileCanMoveTo(_tile, _newPosition)) {
                      puzzleProvider.setDraggedTilePosition(_tile.value, _newPosition);
                    }
                  },
                  child: child!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
