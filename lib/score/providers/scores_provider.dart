import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/repositories/scores_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scoresProvider = NotifierProvider<ScoresNotifier, List<Score>>(
  () => ScoresNotifier(),
);

class ScoresNotifier extends Notifier<List<Score>> {
  ScoresNotifier({
    this.maxStorableScores = Constants.maxStorableScores,
  });

  final int maxStorableScores;

  @override
  List<Score> build() {
    final scoresRepository = ref.watch(scoresRepositoryProvider);
    final scores = scoresRepository.get() ?? [];
    return scores;
  }

  void add(Score newScore) {
    final scores = state;
    if (scores.length > maxStorableScores) {
      scores.removeAt(0);
    }
    state = [...scores, newScore];
  }
}
