import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/enums/direction.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_wrapper.dart';
import 'package:provider/provider.dart';

class PuzzleBoard extends StatefulWidget {
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  bool _isInit = true;

  late PuzzleProvider puzzleProvider;

  double get puzzleContainerWidth => MediaQuery.of(context).size.width - UI.screenHPadding * 2;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);
      puzzleProvider.generate(puzzleContainerWidth);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print('Rebuilt puzzle board!');
    return Container(
      width: puzzleContainerWidth,
      height: puzzleContainerWidth,
      margin: const EdgeInsets.all(UI.screenHPadding),
      color: Colors.grey.withOpacity(0.5),
      child: Stack(
        children: List.generate(
          puzzleProvider.tilesWithoutWhitespace.length,
          (index) => TileWrapper(
            tile: puzzleProvider.tilesWithoutWhitespace[index],
            stream: puzzleProvider.tileStreamControllers[puzzleProvider.tilesWithoutWhitespace[index].value]!.stream,
            handleDrag: (Direction direction, Tile tile) => puzzleProvider.handleDrag(direction: direction, tile: tile),
          ),
        ),
      ),
    );
  }
}
