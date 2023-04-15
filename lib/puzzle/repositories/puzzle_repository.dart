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
  Puzzle fromJson(dynamic json) =>
      Puzzle.fromJson(json as Map<String, dynamic>);

  @override
  Map<String, dynamic> toJson(Puzzle item) => item.toJson();

  void updatePuzzle({
    List<Tile>? tiles,
    int? movesCount,
    int? puzzleSize,
  }) {
    final data = <String, dynamic>{};
    if (tiles != null) {
      data['tiles'] = Tile.toJsonList(tiles);
    }
    if (movesCount != null) {
      data['movesCount'] = movesCount;
    }
    if (puzzleSize != null) {
      data['n'] = puzzleSize;
    }
    if (data.isNotEmpty) {
      update(data);
    }
  }
}
