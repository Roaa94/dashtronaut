import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/core/repositories/storage_repository.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/models/scores_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scoresRepositoryProvider = Provider<ScoresStorageRepository>((ref) {
  return ScoresStorageRepository(ref.watch(storageServiceProvider));
});

class ScoresStorageRepository extends StorageRepository<ScoresData> {
  ScoresStorageRepository(
    super.storageService, {
    this.maxStorableScores = Constants.maxStorableScores,
  });

  final int maxStorableScores;

  @override
  String get storageKey => StorageKeys.scores;

  @override
  ScoresData fromJson(Map<String, dynamic> json) {
    return ScoresData.fromJsom(json);
  }

  void add(Score newScore) {
    final scoresData = get();
    if (scoresData != null) {
      final scores = scoresData.scores;
      if (scores.length == maxStorableScores) {
        scores.removeAt(0);
      }
      scores.add(newScore);
      update({
        'scores': Score.toJsonList(scores),
      });
    } else {
      set(ScoresData(scores: [newScore]));
    }
  }
}
