import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_container.dart';
import 'package:provider/provider.dart';

class TileWrapper extends StatefulWidget {
  final Tile tile;
  final Function handleDragEnd;
  final Position? Function({required double distance, required Tile tile}) getPositionFromDragUpdate;

  const TileWrapper({
    Key? key,
    required this.tile,
    required this.handleDragEnd,
    required this.getPositionFromDragUpdate,
  }) : super(key: key);

  @override
  State<TileWrapper> createState() => _TileWrapperState();
}

class _TileWrapperState extends State<TileWrapper> {
  late final ValueNotifier<Position> tilePositionNotifier;

  @override
  void initState() {
    tilePositionNotifier = ValueNotifier<Position>(widget.tile.position);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PuzzleProvider, Tile>(
      selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.tiles.firstWhere((_tile) => _tile.value == widget.tile.value),
      builder: (c, Tile _tile, _) {
        return ValueListenableBuilder(
          valueListenable: tilePositionNotifier,
          builder: (c, Position tilePosition, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              width: _tile.width,
              height: _tile.width,
              left: tilePosition.left,
              top: tilePosition.top,
              child: IgnorePointer(
                ignoring: _tile.tileIsWhiteSpace,
                child: GestureDetector(
                  onHorizontalDragEnd: (DragEndDetails details) {
                    // Snap to destination if crossed distance is > tileWidth / 2
                    // Snap back to original position if crossed distance is < tileWidth / 2
                  },
                  onVerticalDragEnd: (DragEndDetails details) {
                    // Snap to destination if crossed distance is > tileWidth / 2
                    // Snap back to original position if crossed distance is < tileWidth / 2
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    Position? _newPosition = widget.getPositionFromDragUpdate(
                      distance: details.delta.dx,
                      tile: _tile,
                    );
                    if (_newPosition != null) {
                      tilePositionNotifier.value = _newPosition;
                    }
                  },
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    Position? _newPosition = widget.getPositionFromDragUpdate(
                      distance: details.delta.dy,
                      tile: _tile,
                    );
                    if (_newPosition != null) {
                      tilePositionNotifier.value = _newPosition;
                    }
                  },
                  child: TileContainer(tile: _tile),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
