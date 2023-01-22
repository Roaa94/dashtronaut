import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final puzzleSizeProvider = NotifierProvider<PuzzleSizeNotifier, int>(
  () => PuzzleSizeNotifier(),
);

class PuzzleSizeNotifier extends Notifier<int> {
  @override
  int build() {
    return puzzleRepository.get()?.n ?? configs.defaultPuzzleSize;
  }

  PuzzleStorageRepository get puzzleRepository =>
      ref.watch(puzzleRepositoryProvider);

  Configs get configs => ref.watch(configsProvider);

  void update(int value) {
    state = value;
    puzzleRepository.updatePuzzleSize(value);
  }
}
