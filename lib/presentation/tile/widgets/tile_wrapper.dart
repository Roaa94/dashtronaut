import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_container.dart';

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
  late double leftPosition;
  late double topPosition;

  @override
  void initState() {
    leftPosition = widget.tile.position.left;
    topPosition = widget.tile.position.top;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1),
      width: widget.tile.width,
      height: widget.tile.width,
      left: leftPosition,
      top: topPosition,
      child: GestureDetector(
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (widget.tile.isMovable) {
            setState(() {
              leftPosition += details.delta.dx;
            });
          }
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          if (widget.tile.isMovable) {
            setState(() {
              topPosition += details.delta.dy;
            });
          }
        },
        child: TileContainer(tile: widget.tile),
      ),
    );
  }
}
