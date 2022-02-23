import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/phrase.dart';
import 'package:flutter_puzzle_hack/data/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack/presentation/providers/phrases_provider.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/providers/stop_watch_provider.dart';
import 'package:provider/provider.dart';

class TileGestureDetector extends StatelessWidget {
  final Tile tile;
  final bool isPuzzleSolved;
  final Widget tileContent;

  const TileGestureDetector({
    Key? key,
    required this.tile,
    required this.isPuzzleSolved,
    required this.tileContent,
  }) : super(key: key);

  void _swapTilesAndUpdatePuzzle(
    PuzzleProvider puzzleProvider,
    StopWatchProvider stopWatchProvider,
    PhrasesProvider phrasesProvider,
  ) {
    puzzleProvider.swapTilesAndUpdatePuzzle(tile);

    // Handle Phrases
    if (puzzleProvider.movesCount == 1) {
      stopWatchProvider.start();
      phrasesProvider.setPhraseState(PhraseState.puzzleStarted);
    } else if (puzzleProvider.puzzle.isSolved) {
      phrasesProvider.setPhraseState(PhraseState.puzzleSolved);
      stopWatchProvider.stop();
    } else {
      if (phrasesProvider.phraseState != PhraseState.none) {
        if (phrasesProvider.phraseState == PhraseState.puzzleStarted || phrasesProvider.phraseState == PhraseState.dashTapped) {
          Future.delayed(AnimationsManager.phraseBubbleTotalAnimationDuration, () {
            phrasesProvider.setPhraseState(PhraseState.none);
          });
        } else {
          phrasesProvider.setPhraseState(PhraseState.none);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PuzzleProvider puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);
    StopWatchProvider stopWatchProvider = Provider.of<StopWatchProvider>(context, listen: false);
    PhrasesProvider phrasesProvider = Provider.of<PhrasesProvider>(context, listen: false);

    return IgnorePointer(
      ignoring: tile.tileIsWhiteSpace || isPuzzleSolved,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          bool _canMoveRight = details.velocity.pixelsPerSecond.dx >= 0 && puzzleProvider.puzzle.tileIsLeftOfWhiteSpace(tile);
          bool _canMoveLeft = details.velocity.pixelsPerSecond.dx <= 0 && puzzleProvider.puzzle.tileIsRightOfWhiteSpace(tile);
          bool _tileIsMovable = puzzleProvider.puzzle.tileIsMovable(tile);
          if (_tileIsMovable && (_canMoveLeft || _canMoveRight)) {
            _swapTilesAndUpdatePuzzle(puzzleProvider, stopWatchProvider, phrasesProvider);
          }
        },
        onVerticalDragEnd: (details) {
          bool _canMoveUp = details.velocity.pixelsPerSecond.dy <= 0 && puzzleProvider.puzzle.tileIsBottomOfWhiteSpace(tile);
          bool _canMoveDown = details.velocity.pixelsPerSecond.dy >= 0 && puzzleProvider.puzzle.tileIsTopOfWhiteSpace(tile);
          bool _tileIsMovable = puzzleProvider.puzzle.tileIsMovable(tile);
          if (_tileIsMovable && (_canMoveUp || _canMoveDown)) {
            _swapTilesAndUpdatePuzzle(puzzleProvider, stopWatchProvider, phrasesProvider);
          }
        },
        onTap: () {
          bool _tileIsMovable = puzzleProvider.puzzle.tileIsMovable(tile);
          if (_tileIsMovable) {
            _swapTilesAndUpdatePuzzle(puzzleProvider, stopWatchProvider, phrasesProvider);
          }
        },
        child: tileContent,
      ),
    );
  }
}
