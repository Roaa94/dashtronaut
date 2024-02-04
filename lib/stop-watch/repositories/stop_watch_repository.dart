import 'package:dashtronaut/core/repositories/storage_repository.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stopWatchRepositoryProvider = Provider((ref) {
  return StopWatchStorageRepository(
    ref.watch(storageServiceProvider),
  );
});

class StopWatchStorageRepository extends StorageRepository<int> {
  StopWatchStorageRepository(super.storageService);

  @override
  String get storageKey => StorageKeys.secondsElapsed;
}
