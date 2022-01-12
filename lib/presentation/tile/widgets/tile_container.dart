import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class TileContainer extends StatelessWidget {
  final Tile tile;
  final bool isActiveTile;

  const TileContainer({
    Key? key,
    required this.tile,
    required this.isActiveTile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAtCorrectLocation = tile.currentLocation == tile.correctLocation;
    print('Built tile ${tile.value}');
    return Transform.scale(
      scale: isActiveTile ? 1.1 : 1,
      child: Container(
        decoration: BoxDecoration(
          color: isAtCorrectLocation ? Colors.pinkAccent : Colors.cyan,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${tile.value}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
