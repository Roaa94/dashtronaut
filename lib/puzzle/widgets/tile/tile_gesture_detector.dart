// import 'package:dashtronaut/puzzle/models/tile.dart';
// import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
// import 'package:dashtronaut/core/layout/phrase_bubble_layout.dart';
// import 'package:dashtronaut/puzzle/providers/tiles_provider.dart';
// import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog.dart';
// import 'package:dashtronaut/dash/providers/phrases_provider.dart';
// import 'package:dashtronaut/puzzle/providers/old_puzzle_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class TileGestureDetector extends ConsumerWidget {
//   final Tile tile;
//   final Widget tileContent;
//
//   const TileGestureDetector({
//     super.key,
//     required this.tile,
//     required this.tileContent,
//   });
//
//   // Todo: show this dialog based on a listener on puzzleIsSolvedProvider
//   //  in the puzzle board widget
//   Future<void> _showPuzzleSolvedDialog(
//     BuildContext context,
//     int secondsElapsed,
//   ) async {
//     await showDialog(
//       context: context,
//       builder: (c) {
//         return SolvedPuzzleDialog(
//           solvingDuration: Duration(seconds: secondsElapsed),
//         );
//       },
//     );
//   }
//
//   void _swapTilesAndUpdatePuzzle(
//     BuildContext context,
//     PhrasesProvider phrasesProvider,
//   ) {
//     puzzleProvider.swapTilesAndUpdatePuzzle(tile);
//
//     // Handle Phrases
//     if (puzzleProvider.movesCount == 1) {
//       // Todo: start the stop watch
//       // stopWatchProvider.start();
//       phrasesProvider.setPhraseState(PhraseState.puzzleStarted);
//     } else if (puzzleProvider.puzzle.isSolved) {
//       phrasesProvider.setPhraseState(PhraseState.puzzleSolved);
//       Future.delayed(AnimationsManager.phraseBubbleTotalAnimationDuration, () {
//         phrasesProvider.setPhraseState(PhraseState.none);
//       });
//
//       Future.delayed(AnimationsManager.puzzleSolvedDialogDelay, () {
//         // Todo: stop the stop watch & show puzzle solved dialog
//         //   int secondsElapsed = stopWatchProvider.secondsElapsed;
//         //   stopWatchProvider.stop();
//         //   _showPuzzleSolvedDialog(
//         //     context,
//         //     secondsElapsed,
//         //   ).then((_) {
//         //     puzzleProvider.generate(forceRefresh: true);
//         //   });
//       });
//     } else {
//       if (phrasesProvider.phraseState != PhraseState.none) {
//         if (phrasesProvider.phraseState == PhraseState.puzzleStarted ||
//             phrasesProvider.phraseState == PhraseState.dashTapped ||
//             phrasesProvider.phraseState == PhraseState.puzzleSolved) {
//           Future.delayed(AnimationsManager.phraseBubbleTotalAnimationDuration,
//               () {
//             phrasesProvider.setPhraseState(PhraseState.none);
//           });
//         } else {
//           phrasesProvider.setPhraseState(PhraseState.none);
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // PhrasesProvider phrasesProvider =
//     //     Provider.of<PhrasesProvider>(context, listen: false);
//
//     return IgnorePointer(
//       ignoring: tile.tileIsWhiteSpace || puzzleProvider.puzzle.isSolved,
//       child: GestureDetector(
//         onHorizontalDragEnd: (details) {
//           bool canMoveRight = details.velocity.pixelsPerSecond.dx >= 0 &&
//               puzzleProvider.puzzle.tileIsLeftOfWhiteSpace(tile);
//           bool canMoveLeft = details.velocity.pixelsPerSecond.dx <= 0 &&
//               puzzleProvider.puzzle.tileIsRightOfWhiteSpace(tile);
//           bool tileIsMovable = puzzleProvider.puzzle.tileIsMovable(tile);
//           if (tileIsMovable && (canMoveLeft || canMoveRight)) {
//             _swapTilesAndUpdatePuzzle(context, puzzleProvider, phrasesProvider);
//           }
//         },
//         onVerticalDragEnd: (details) {
//           bool canMoveUp = details.velocity.pixelsPerSecond.dy <= 0 &&
//               puzzleProvider.puzzle.tileIsBottomOfWhiteSpace(tile);
//           bool canMoveDown = details.velocity.pixelsPerSecond.dy >= 0 &&
//               puzzleProvider.puzzle.tileIsTopOfWhiteSpace(tile);
//           bool tileIsMovable = puzzleProvider.puzzle.tileIsMovable(tile);
//           if (tileIsMovable && (canMoveUp || canMoveDown)) {
//             _swapTilesAndUpdatePuzzle(context, puzzleProvider, phrasesProvider);
//           }
//         },
//         onTap: () {
//           bool tileIsMovable = puzzleProvider.puzzle.tileIsMovable(tile);
//           if (tileIsMovable) {
//             _swapTilesAndUpdatePuzzle(context, puzzleProvider, phrasesProvider);
//           }
//         },
//         child: tileContent,
//       ),
//     );
//   }
// }
