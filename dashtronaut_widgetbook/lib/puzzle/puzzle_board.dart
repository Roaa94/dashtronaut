import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'PuzzleBoard',
  type: PuzzleBoard,
)
Widget puzzleBoard4x4(BuildContext context) {
  return const Center(
    child: PuzzleBoard(),
  );
}

// Widget puzzleBoard3x3(BuildContext context) {
//   return ProviderScope(
//     overrides: [
//       configsProvider.overrideWith(
//             (_) => const Configs(
//           defaultPuzzleSize: 3,
//         ),
//       ),
//       puzzleSizeProvider,
//       puzzleProvider,
//       puzzleIsSolvedProvider,
//       correctTilesCountProvider,
//       puzzleMovesCountProvider,
//       stopWatchProvider,
//       isWebProvider,
//       shareScoreServiceProvider,
//     ],
//     child: const Center(
//       child: PuzzleBoard(),
//     ),
//   );
// }

// Widget puzzleBoard5x5(BuildContext context) {
//   return ProviderScope(
//     parent: ProviderScope.containerOf(context),
//     overrides: [
//       configsProvider.overrideWith(
//             (_) => const Configs(
//           defaultPuzzleSize: 5,
//         ),
//       ),
//       puzzleSizeProvider,
//       puzzleProvider,
//       puzzleIsSolvedProvider,
//       correctTilesCountProvider,
//       puzzleMovesCountProvider,
//       stopWatchProvider,
//       isWebProvider,
//       shareScoreServiceProvider,
//     ],
//     child: const Center(
//       child: PuzzleBoard(),
//     ),
//   );
// }

// Widget puzzleBoard6x6(BuildContext context) {
//   return ProviderScope(
//     overrides: [
//       configsProvider.overrideWith(
//             (_) => const Configs(
//           defaultPuzzleSize: 6,
//         ),
//       ),
//       puzzleSizeProvider,
//       puzzleProvider,
//       puzzleIsSolvedProvider,
//       puzzleMovesCountProvider,
//       correctTilesCountProvider,
//       puzzleMovesCountProvider,
//       stopWatchProvider,
//       isWebProvider,
//       shareScoreServiceProvider,
//     ],
//     child: const Center(
//       child: PuzzleBoard(),
//     ),
//   );
// }
