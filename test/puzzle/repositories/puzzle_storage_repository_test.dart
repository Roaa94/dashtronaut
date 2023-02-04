import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository puzzleStorageRepository;

  group('$PuzzleStorageRepository tests', () {
    late StorageService hiveStorageService;

    setUp(() async {
      hiveStorageService = HiveStorageService();
      await setUpTestHive();
      await hiveStorageService.init();

      puzzleStorageRepository = PuzzleStorageRepository(
        hiveStorageService,
      );
    });

    test('Can set & get data in storage', () {
      puzzleStorageRepository.set(puzzle2x2Solved);

      expect(puzzleStorageRepository.get(), puzzle2x2Solved);
    });

    test('Can update puzzle tiles', () {
      puzzleStorageRepository.set(puzzle2x2Solved);
      puzzleStorageRepository.updateTiles(puzzle2x2Tiles);

      final updatedPuzzle2x2 = puzzle2x2Solved.copyWith(tiles: puzzle2x2Tiles);
      expect(puzzleStorageRepository.get(), updatedPuzzle2x2);
    });

    test('Can update puzzle moves count', () {
      puzzleStorageRepository.set(puzzle2x2Solved);
      puzzleStorageRepository.updateMovesCount(3);

      final updatedPuzzle2x2 = puzzle2x2Solved.copyWith(movesCount: 3);
      expect(puzzleStorageRepository.get(), updatedPuzzle2x2);
    });

    test('Can update puzzle size', () {
      puzzleStorageRepository.set(puzzle2x2Solved);
      puzzleStorageRepository.updatePuzzleSize(3);

      final updatedPuzzle2x2 = puzzle2x2Solved.copyWith(n: 3);
      expect(puzzleStorageRepository.get(), updatedPuzzle2x2);
    });

    test('Can clear puzzle data', () {
      puzzleStorageRepository.set(puzzle2x2Solved);
      puzzleStorageRepository.clear();

      expect(puzzleStorageRepository.get(), isNull);
    });

    test('hasData is false when there is no data', () {
      expect(puzzleStorageRepository.hasData, isFalse);
    });

    test('hasData is true when there is data', () {
      puzzleStorageRepository.set(puzzle2x2Solved);

      expect(puzzleStorageRepository.hasData, isTrue);
    });

    tearDown(() async {
      await hiveStorageService.close();
    });
  });

  group('$puzzleRepositoryProvider tests', () {
    late StorageService mockStorageService;

    setUp(() {
      mockStorageService = MockStorageService();
      puzzleStorageRepository = PuzzleStorageRepository(mockStorageService);
    });

    test(
      'calls set on storage service with correct data',
      () {
        final providerContainer = ProviderContainer(
          overrides: [
            storageServiceProvider.overrideWithValue(mockStorageService),
          ],
        );
        addTearDown(providerContainer.dispose);

        try {
          providerContainer.read(puzzleRepositoryProvider).set(puzzle2x2Solved);
        } catch (_) {}

        verify(
          () => mockStorageService.set(
            puzzleStorageRepository.storageKey,
            puzzle2x2Solved.toJson(),
          ),
        ).called(1);
      },
    );
  });
}
