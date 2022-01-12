import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_wrapper.dart';
import 'package:provider/provider.dart';

class PuzzleBoard extends StatefulWidget {
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  late PuzzleProvider puzzleProvider;
  final FocusNode keyboardListenerFocusNode = FocusNode();

  @override
  void initState() {
    puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: keyboardListenerFocusNode,
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
            puzzleProvider.setNextActiveTile();
          }
        }
      },
      child: _buildPuzzleBoard,
    );
  }

  Widget get _buildPuzzleBoard {
    return Center(
      child: Container(
        width: puzzleProvider.puzzleContainerWidth,
        height: puzzleProvider.puzzleContainerWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: List.generate(
            puzzleProvider.tilesWithoutWhitespace.length,
            (index) => TileWrapper(tile: puzzleProvider.tilesWithoutWhitespace[index]),
          ),
        ),
      ),
    );
  }
}
