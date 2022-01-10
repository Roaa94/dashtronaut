import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class TileContainer extends StatelessWidget {
  final Tile tile;
  final bool isTileMovable;
  final String? extraText;

  const TileContainer({
    Key? key,
    required this.tile,
    this.isTileMovable = false,
    this.extraText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tile.isWhiteSpaceTile ? Colors.white.withOpacity(0.4) : Colors.cyan,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: isTileMovable ? Colors.red : Colors.transparent, width: 2),
      ),
      margin: const EdgeInsets.all(5),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${tile.value}'),
          tile.currentLocation == tile.correctLocation ? const Text('✅') : Text(tile.currentLocation.asString),
          Text(
            tile.correctLocation.asString,
            style: TextStyle(color: tile.isWhiteSpaceTile ? Colors.cyan : Colors.white),
          ),
          if (extraText != null)
            Text(
              extraText!,
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w700, fontSize: 10),
            ),
        ],
      ),
    );
  }
}
