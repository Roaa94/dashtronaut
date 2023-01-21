import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/core/repositories/storage_repository.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tilesRepositoryProvider = Provider((ref) {
  return TilesStorageRepository(
    ref.watch(storageServiceProvider),
  );
});

class TilesStorageRepository extends StorageRepository<List<Tile>> {
  TilesStorageRepository(super.storageService);

  @override
  String get storageKey => StorageKeys.tiles;

  @override
  dynamic toJson(List<Tile> item) =>
      List<dynamic>.from(item.map((x) => x.toJson()));
}
