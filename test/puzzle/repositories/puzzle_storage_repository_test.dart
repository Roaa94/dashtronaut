import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';

import '../../utils/test_data.dart';

void main() {
  late StorageService hiveStorageService;
  late PuzzleStorageRepository puzzleStorageRepository;

  setUp(() async {
    hiveStorageService = HiveStorageService();
    await setUpTestHive();
    await hiveStorageService.init();

    puzzleStorageRepository = PuzzleStorageRepository(
      hiveStorageService,
    );
  });

  test('Can set & get data in storage', () {
    puzzleStorageRepository.set(puzzle2x2);

    expect(puzzleStorageRepository.get(), puzzle2x2);
  });

  test('Can update puzzle tiles', () {
    puzzleStorageRepository.set(puzzle2x2);
    puzzleStorageRepository.updateTiles(puzzle2x2Tiles);

    final updatedPuzzle2x2 = puzzle2x2.copyWith(tiles: puzzle2x2Tiles);
    expect(puzzleStorageRepository.get(), updatedPuzzle2x2);
  });

  test('Can update puzzle moves count', () {
    puzzleStorageRepository.set(puzzle2x2);
    puzzleStorageRepository.updateMovesCount(3);

    final updatedPuzzle2x2 = puzzle2x2.copyWith(movesCount: 3);
    expect(puzzleStorageRepository.get(), updatedPuzzle2x2);
  });

  test('Can update puzzle size', () {
    puzzleStorageRepository.set(puzzle2x2);
    puzzleStorageRepository.updatePuzzleSize(3);

    final updatedPuzzle2x2 = puzzle2x2.copyWith(n: 3);
    expect(puzzleStorageRepository.get(), updatedPuzzle2x2);
  });

  test('Can clear puzzle data', () {
    puzzleStorageRepository.set(puzzle2x2);
    puzzleStorageRepository.clear();

    expect(puzzleStorageRepository.get(), isNull);
  });

  tearDown(() async {
    await hiveStorageService.close();
  });
}
