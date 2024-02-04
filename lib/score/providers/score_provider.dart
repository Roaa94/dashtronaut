import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/stop-watch/providers/stop_watch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scoreProvider = Provider<Score>((ref) {
  return Score(
    secondsElapsed: ref.watch(stopWatchProvider),
    winMovesCount: ref.watch(puzzleMovesCountProvider),
    puzzleSize: ref.watch(puzzleSizeProvider),
  );
});
