import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:provider/provider.dart';

class TileContainer extends StatelessWidget {
  final Tile tile;

  const TileContainer({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('Built tile ${tile.value}');
    return Selector<PuzzleProvider, int>(
      selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.activeTileValue,
      shouldRebuild: (int previousActiveTile, int nextActiveTile) {
        return previousActiveTile != nextActiveTile;
      },
      builder: (c, int activeTileValue, child) {
        print('Rebuilt active tile $activeTileValue');
        return Transform.scale(
          scale: activeTileValue == tile.value ? 1.2 : 1,
          child: child,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: tile.currentLocation == tile.correctLocation ? Colors.pinkAccent : Colors.cyan,
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
