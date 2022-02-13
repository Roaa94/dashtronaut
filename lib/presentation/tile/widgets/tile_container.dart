import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_rive_animation.dart';
import 'package:provider/provider.dart';

class TileContainer extends StatelessWidget {
  final Tile tile;

  const TileContainer({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAtCorrectLocation = tile.currentLocation == tile.correctLocation;

    return Selector<PuzzleProvider, int>(
      selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.activeTileValue,
      builder: (c, int activeTileValue, child) {
        return AnimatedScale(
          scale: activeTileValue == tile.value && kIsWeb ? 1.05 : 1,
          duration: const Duration(milliseconds: 200),
          child: child,
        );
      },
      child: Selector<PuzzleProvider, int>(
        selector: (c, PuzzleProvider puzzleProvider) => puzzleProvider.n,
        child: Selector<PuzzleProvider, bool>(
          selector: (c, puzzleProvider) => puzzleProvider.puzzle.isSolved,
          builder: (c, bool isPuzzleSolved, _) => TileRiveAnimation(
            isAtCorrectLocation: isAtCorrectLocation,
            isPuzzleSolved: isPuzzleSolved,
            tile: tile,
          ),
        ),
        builder: (c, puzzleSize, tileRiveAnimation) {
          // print('Built tile ${tile.value}');
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.1), blurRadius: 10)],
            ),
            margin: EdgeInsets.all(puzzleSize > 3 ? 5 : 8),
            alignment: Alignment.center,
            child: Stack(
              children: [
                tileRiveAnimation!,
                Positioned.fill(
                  child: Center(
                    child: Text(
                      '${tile.value}',
                      style: AppTextStyles.tile.copyWith(
                          fontSize: puzzleSize > 4
                              ? 25
                              : puzzleSize > 3
                                  ? 30
                                  : null),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
