import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class TileContainer extends StatelessWidget {
  final Tile tile;

  const TileContainer({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(5),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${tile.value}'),
          Text('(${tile.location.x},${tile.location.y})')
        ],
      ),
    );
  }
}
