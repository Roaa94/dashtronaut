import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Todo: test this provider
final scoreProvider = Provider<Score>((ref) {
  return Score(
    // Todo: add correct secondsElapsed
    secondsElapsed: 20,
    winMovesCount: ref.watch(puzzleMovesCountProvider),
    puzzleSize: ref.watch(puzzleSizeProvider),
  );
});
