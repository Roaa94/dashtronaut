import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class TileContainer extends StatelessWidget {
  final Tile tile;
  final bool tileIsMovable;
  final String? extraText;

  const TileContainer({
    Key? key,
    required this.tile,
    this.tileIsMovable = false,
    this.extraText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('Rebuilt tile ${tile.value}');
    bool isAtCorrectLocation = tile.currentLocation == tile.correctLocation;
    return Container(
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
    );
  }
}
