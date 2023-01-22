import 'package:dashtronaut/core/repositories/storage_repository.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scoresRepositoryProvider = Provider<ScoresStorageRepository>((ref) {
  return ScoresStorageRepository(ref.watch(storageServiceProvider));
});

class ScoresStorageRepository extends StorageRepository<List<Score>> {
  ScoresStorageRepository(super.storageService);

  @override
  String get storageKey => StorageKeys.scores;

  @override
  List<Score> fromJson(dynamic json) {
    return Score.fromJsonList(json);
  }

  @override
  dynamic toJson(List<Score> item) => Score.toJsonList(item);
}
