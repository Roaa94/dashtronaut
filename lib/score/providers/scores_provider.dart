import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/repositories/scores_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scoresProvider = NotifierProvider<ScoresNotifier, List<Score>>(
  () => ScoresNotifier(),
);

class ScoresNotifier extends Notifier<List<Score>> {
  ScoresNotifier();

  ScoresStorageRepository get scoresRepository =>
      ref.watch(scoresRepositoryProvider);

  Configs get configs => ref.watch(configsProvider);

  @override
  List<Score> build() {
    final scores = scoresRepository.get() ?? [];
    return scores;
  }

  void addScore(Score newScore) {
    final scores = state.toList();
    if (scores.length >= configs.maxStorableScores) {
      scores.removeAt(0);
    }
    state = [...scores, newScore];
    scoresRepository.set(state);
  }
}
