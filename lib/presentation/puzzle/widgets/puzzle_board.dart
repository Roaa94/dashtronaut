import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_wrapper.dart';
import 'package:provider/provider.dart';

class PuzzleBoard extends StatelessWidget {
  PuzzleBoard({Key? key}) : super(key: key);

  final FocusNode keyboardListenerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<PuzzleProvider>(
      builder: (c, PuzzleProvider puzzleProvider, _) => Center(
        child: SizedBox(
          width: Puzzle.containerWidth(context),
          height: Puzzle.containerWidth(context),
          child: Stack(
            children: List.generate(
              puzzleProvider.tilesWithoutWhitespace.length,
              (index) => TileWrapper(
                tile: puzzleProvider.tilesWithoutWhitespace[index],
                isPuzzleSolved: puzzleProvider.puzzle.isSolved,
                puzzleSize: puzzleProvider.n,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
