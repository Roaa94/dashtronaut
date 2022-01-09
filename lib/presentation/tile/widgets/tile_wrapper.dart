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
  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: widget.tile.width,
      height: widget.tile.width,
      left: widget.tile.position.left,
      top: widget.tile.position.top,
      child: TileContainer(value: widget.tile.value),
    );
  }
}
