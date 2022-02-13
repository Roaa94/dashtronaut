import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_animated_positioned.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_content.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_gesture_detector.dart';
import 'package:provider/provider.dart';

class TileWrapper extends StatefulWidget {
  final Tile tile;

  const TileWrapper({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  State<TileWrapper> createState() => _TileWrapperState();
}

class _TileWrapperState extends State<TileWrapper> {
  late PuzzleProvider puzzleProvider;

  @override
  void initState() {
    puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PuzzleProvider, Tile>(
      selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.getTileFromValue(widget.tile.value),
      builder: (c, Tile _tile, _) => Selector<PuzzleProvider, bool>(
        selector: (c, puzzleProvider) => puzzleProvider.puzzle.isSolved,
        builder: (c, bool isPuzzleSolved, _) => Selector<PuzzleProvider, Position>(
          selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.draggedTilePositions[_tile.value]!,
          child: TileContent(tile: _tile, isPuzzleSolved: isPuzzleSolved),
          builder: (c, Position tilePosition, tileContent) {
            return TileAnimatedPositioned(
              tilePosition: tilePosition,
              tile: _tile,
              tileGestureDetector: TileGestureDetector(
                tile: _tile,
                child: tileContent!,
                tilePosition: tilePosition,
                isPuzzleSolved: isPuzzleSolved,
              ),
            );
          },
        ),
      ),
    );
  }
}
