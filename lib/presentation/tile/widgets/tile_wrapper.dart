import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
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
  _TileWrapperState createState() => _TileWrapperState();
}

class _TileWrapperState extends State<TileWrapper> {
  late ValueNotifier<Position> tilePositionNotifier;

  @override
  void initState() {
    tilePositionNotifier = ValueNotifier<Position>(Position(
      left: widget.tile.position.left,
      top: widget.tile.position.top,
    ));
    super.initState();
  }

  @override
  void dispose() {
    tilePositionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PuzzleProvider>(
      builder: (c, puzzleProvider, _) {
        Puzzle puzzle = puzzleProvider.puzzle;
        bool isMovableOnX = puzzle.tileIsMovableOnXAxis(widget.tile);
        bool isMovableOnY = puzzle.tileIsMovableOnYAxis(widget.tile);
        bool tileIsRightOfWhiteSpace = puzzle.tileIsRightOfWhiteSpace(widget.tile);
        bool tileIsTopOfWhiteSpace = puzzle.tileIsTopOfWhiteSpace(widget.tile);

        return ValueListenableBuilder(
          valueListenable: tilePositionNotifier,
          child: TileContainer(
            tile: widget.tile,
            isTileMovable: isMovableOnX || isMovableOnY,
            extraText: puzzle.getTileLocationText(widget.tile),
          ),
          builder: (c, Position tilePosition, child) => AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            width: widget.tile.width,
            height: widget.tile.width,
            left: tilePosition.left,
            top: tilePosition.top,
            child: IgnorePointer(
              ignoring: widget.tile.isWhiteSpaceTile,
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  if (isMovableOnX) {
                    if ((tileIsRightOfWhiteSpace && details.delta.dx < 0) || (!tileIsRightOfWhiteSpace && details.delta.dx > 0)) {
                      tilePositionNotifier.value = puzzle.whiteSpaceTile.position;
                    }
                  }
                },
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  if (isMovableOnY) {
                    if ((tileIsTopOfWhiteSpace && details.delta.dy > 0) || (!tileIsTopOfWhiteSpace && details.delta.dy < 0)) {
                      tilePositionNotifier.value = puzzle.whiteSpaceTile.position;
                    }
                  }
                },
                child: child!,
              ),
            ),
          ),
        );
      },
    );
  }
}
