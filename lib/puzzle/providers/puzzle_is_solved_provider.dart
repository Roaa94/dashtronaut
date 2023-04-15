import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final puzzleIsSolvedProvider = Provider<bool>((ref) {
  final tilesState = ref.watch(puzzleProvider);

  return tilesState.isSolved;
});
