import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/core/repositories/storage_repository.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final puzzleRepositoryProvider = Provider((ref) {
  return PuzzleStorageRepository(
    ref.watch(storageServiceProvider),
  );
});

class PuzzleStorageRepository extends StorageRepository<Puzzle> {
  PuzzleStorageRepository(super.storageService);

  @override
  String get storageKey => StorageKeys.puzzle;

  @override
  Puzzle fromJson(Map<String, dynamic> json) => Puzzle.fromJson(json);

  void updateTiles(List<Tile> tiles) {
    update({
      'tiles': List<dynamic>.from(tiles.map((x) => x.toJson())),
    });
  }

  void updateMovesCount(int movesCount) {
    update({'movesCount': movesCount});
  }

  void updatePuzzleSize(int n) {
    update({'n': n});
  }
}
