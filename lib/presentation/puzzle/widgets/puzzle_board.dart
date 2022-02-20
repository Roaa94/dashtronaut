import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_wrapper.dart';
import 'package:provider/provider.dart';

class PuzzleBoard extends StatelessWidget {
  PuzzleBoard({Key? key}) : super(key: key);

  final FocusNode keyboardListenerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (c, PuzzleProvider puzzleProvider, _) => RawKeyboardListener(
        focusNode: keyboardListenerFocusNode,
        autofocus: true,
        onKey: (RawKeyEvent event) => puzzleProvider.handleKeyboardEvent(event),
        child: Center(
          child: SizedBox(
            width: puzzleProvider.puzzleContainerWidth,
            height: puzzleProvider.puzzleContainerWidth,
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
      ),
    );
  }
}
