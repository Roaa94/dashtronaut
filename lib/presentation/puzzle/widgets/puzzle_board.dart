import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_wrapper.dart';

class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = Puzzle(context: context, dimension: 3);
    puzzle.printData();

    return Container(
      width: puzzle.containerWidth,
      height: puzzle.containerWidth,
      margin: const EdgeInsets.all(UI.screenHPadding),
      color: Colors.grey.withOpacity(0.5),
      child: Stack(
        children: List.generate(
          puzzle.tileCount,
          (index) => TileWrapper(tile: puzzle.tiles[index]),
        ),
      ),
    );
  }
}
