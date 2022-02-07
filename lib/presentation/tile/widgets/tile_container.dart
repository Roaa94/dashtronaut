import 'package:flutter/foundation.dart' show kIsWeb;
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
    bool _isInCorrectLocation = tile.currentLocation == tile.correctLocation;

    return Selector<PuzzleProvider, int>(
      selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.activeTileValue,
      builder: (c, int activeTileValue, child) {
        return AnimatedScale(
          scale: activeTileValue == tile.value && kIsWeb ? 1.05 : 1,
          duration: const Duration(milliseconds: 200),
          child: child,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isInCorrectLocation ? const Color(0xff50e6ff).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(_isInCorrectLocation ? 1 : 0.6), width: 2),
          boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.2), blurRadius: 10)],
        ),
        margin: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${tile.value}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
