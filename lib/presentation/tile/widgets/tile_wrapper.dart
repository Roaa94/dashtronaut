import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/enums/direction.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_container.dart';

class TileWrapper extends StatelessWidget {
  final Tile tile;
  final Stream<Tile> stream;
  final Function handleDrag;

  const TileWrapper({
    Key? key,
    required this.tile,
    required this.stream,
    required this.handleDrag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Tile>(
      stream: stream,
      initialData: tile,
      builder: (c, AsyncSnapshot<Tile> snapshot) {
        Tile _tile = snapshot.data ?? tile;

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          width: _tile.width,
          height: _tile.width,
          left: _tile.position.left,
          top: _tile.position.top,
          child: IgnorePointer(
            ignoring: _tile.tileIsWhiteSpace,
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) => handleDrag(
                details.velocity.pixelsPerSecond.dx < 0 ? Direction.left : Direction.right,
                _tile,
              ),
              onVerticalDragEnd: (DragEndDetails details) => handleDrag(
                details.velocity.pixelsPerSecond.dy > 0 ? Direction.up : Direction.down,
                _tile,
              ),
              child: TileContainer(tile: _tile),
            ),
          ),
        );
      },
    );
  }
}
