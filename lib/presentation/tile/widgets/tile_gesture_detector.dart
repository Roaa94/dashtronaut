import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/phrase.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack/presentation/providers/phrases_provider.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/providers/stop_watch_provider.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle-solved-dialog/widgets/puzzle_solved_dialog.dart';
import 'package:provider/provider.dart';

class TileGestureDetector extends StatelessWidget {
  final Tile tile;
  final Widget tileContent;

  const TileGestureDetector({
    Key? key,
    required this.tile,
    required this.tileContent,
  }) : super(key: key);

  Future<void> _showPuzzleSolvedDialog(
    BuildContext context,
    PuzzleProvider puzzleProvider,
    int secondsElapsed,
  ) async {
    await showDialog(
      context: context,
      builder: (c) {
        return PuzzleSolvedDialog(
          puzzleSize: puzzleProvider.n,
          movesCount: puzzleProvider.movesCount,
          solvingDuration: Duration(seconds: secondsElapsed),
        );
      },
    );
  }

  void _swapTilesAndUpdatePuzzle(
    BuildContext context,
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
      Future.delayed(AnimationsManager.phraseBubbleTotalAnimationDuration, () {
        phrasesProvider.setPhraseState(PhraseState.none);
      });

      Future.delayed(AnimationsManager.puzzleSolvedDialogDelay, () {
        int _secondsElapsed = stopWatchProvider.secondsElapsed;
        stopWatchProvider.stop();
        _showPuzzleSolvedDialog(
          context,
          puzzleProvider,
          _secondsElapsed,
        ).then((_) {
          puzzleProvider.generate(forceRefresh: true);
        });
      });
    } else {
      if (phrasesProvider.phraseState != PhraseState.none) {
        if (phrasesProvider.phraseState == PhraseState.puzzleStarted ||
            phrasesProvider.phraseState == PhraseState.dashTapped ||
            phrasesProvider.phraseState == PhraseState.puzzleSolved) {
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
      ignoring: tile.tileIsWhiteSpace || puzzleProvider.puzzle.isSolved,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          bool _canMoveRight = details.velocity.pixelsPerSecond.dx >= 0 && puzzleProvider.puzzle.tileIsLeftOfWhiteSpace(tile);
          bool _canMoveLeft = details.velocity.pixelsPerSecond.dx <= 0 && puzzleProvider.puzzle.tileIsRightOfWhiteSpace(tile);
          bool _tileIsMovable = puzzleProvider.puzzle.tileIsMovable(tile);
          if (_tileIsMovable && (_canMoveLeft || _canMoveRight)) {
            _swapTilesAndUpdatePuzzle(context, puzzleProvider, stopWatchProvider, phrasesProvider);
          }
        },
        onVerticalDragEnd: (details) {
          bool _canMoveUp = details.velocity.pixelsPerSecond.dy <= 0 && puzzleProvider.puzzle.tileIsBottomOfWhiteSpace(tile);
          bool _canMoveDown = details.velocity.pixelsPerSecond.dy >= 0 && puzzleProvider.puzzle.tileIsTopOfWhiteSpace(tile);
          bool _tileIsMovable = puzzleProvider.puzzle.tileIsMovable(tile);
          if (_tileIsMovable && (_canMoveUp || _canMoveDown)) {
            _swapTilesAndUpdatePuzzle(context, puzzleProvider, stopWatchProvider, phrasesProvider);
          }
        },
        onTap: () {
          bool _tileIsMovable = puzzleProvider.puzzle.tileIsMovable(tile);
          if (_tileIsMovable) {
            _swapTilesAndUpdatePuzzle(context, puzzleProvider, stopWatchProvider, phrasesProvider);
          }
        },
        child: tileContent,
      ),
    );
  }
}
