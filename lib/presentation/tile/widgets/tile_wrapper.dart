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

const Duration dragAnimationDuration = Duration(milliseconds: 0);
const Duration snapAnimationDuration = Duration(milliseconds: 150);

class _TileWrapperState extends State<TileWrapper> {
  late final ValueNotifier<Position> tilePositionNotifier;
  final ValueNotifier<Duration> animationDurationNotifier = ValueNotifier<Duration>(dragAnimationDuration);
  late PuzzleProvider puzzleProvider;

  @override
  void initState() {
    tilePositionNotifier = ValueNotifier<Position>(widget.tile.position);
    puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PuzzleProvider, Tile>(
      selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.tiles.firstWhere((_tile) => _tile.value == widget.tile.value),
      builder: (c, Tile _tile, _) {
        return ValueListenableBuilder(
          valueListenable: tilePositionNotifier,
          child: TileContainer(tile: _tile),
          builder: (c, Position tilePosition, child) {
            void onDragEnd() {
              // Snap to destination if crossed distance is > tileWidth / 2
              // Snap back to original position if crossed distance is < tileWidth / 2
              animationDurationNotifier.value = snapAnimationDuration;
              tilePositionNotifier.value = puzzleProvider.swapTilesAndUpdatePuzzle(_tile);
              Future.delayed(snapAnimationDuration, () {
                animationDurationNotifier.value = dragAnimationDuration;
              });
            }

            return ValueListenableBuilder(
              valueListenable: animationDurationNotifier,
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
                  onHorizontalDragEnd: (DragEndDetails details) => onDragEnd(),
                  onVerticalDragEnd: (DragEndDetails details) => onDragEnd(),
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    Position _newPosition = Position(left: tilePosition.left + details.delta.dx, top: tilePosition.top);
                    if (puzzleProvider.puzzle.tileIsMovableOnXAxis(_tile) && puzzleProvider.puzzle.tileCanMoveTo(_tile, _newPosition)) {
                      tilePositionNotifier.value = _newPosition;
                    }
                  },
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    Position _newPosition = Position(left: tilePosition.left, top: tilePosition.top + details.delta.dy);
                    if (puzzleProvider.puzzle.tileIsMovableOnYAxis(_tile) && puzzleProvider.puzzle.tileCanMoveTo(_tile, _newPosition)) {
                      tilePositionNotifier.value = _newPosition;
                    }
                  },
                  child: child,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
