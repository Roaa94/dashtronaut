import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final puzzleMovesCountProvider = NotifierProvider<PuzzleMovesCountNotifier, int>(
  () => PuzzleMovesCountNotifier(),
);

class PuzzleMovesCountNotifier extends Notifier<int> {
  @override
  int build() {
    return puzzleRepository.get()?.movesCount ?? 0;
  }

  PuzzleStorageRepository get puzzleRepository =>
      ref.watch(puzzleRepositoryProvider);

  void update(int value) {
    state = value;
    puzzleRepository.updateMovesCount(value);
  }

  void increment() {
    state = state + 1;
    puzzleRepository.updateMovesCount(state);
  }

  void reset() {
    state = 0;
    puzzleRepository.updateMovesCount(0);
  }
}
