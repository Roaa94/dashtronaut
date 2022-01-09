import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/puzzle_tile.dart';

import 'constants/ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = Puzzle(context: context, dimension: 2);
    puzzle.printData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        width: puzzle.containerWidth,
        height: puzzle.containerWidth,
        margin: const EdgeInsets.all(UI.screenHPadding),
        color: Colors.grey.withOpacity(0.5),
        child: Stack(
          children: List.generate(
            puzzle.tileCount,
            (index) => Positioned(
              width: puzzle.tileContainerWidth,
              height: puzzle.tileContainerWidth,
              left: puzzle.tilesLeftPositions[index],
              top: puzzle.tilesTopPositions[index],
              child: PuzzleTile(value: index + 1),
            ),
          ),
        ),
      ),
    );
  }
}
