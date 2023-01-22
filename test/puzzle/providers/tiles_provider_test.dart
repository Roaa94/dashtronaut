import 'dart:math';

import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/puzzle/providers/tiles_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;
  late TilesNotifier tilesNotifier;

  const seed = 2;
  final random = Random(seed);

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
    tilesNotifier = TilesNotifier(random: random);
  });

  group('Initialization', () {
    test('Initialized with value from repository when available', () {
      when(mockPuzzleRepository.get).thenReturn(puzzle2x2);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      addTearDown(providerContainer.dispose);

      expect(
        providerContainer.read(tilesProvider),
        equals(puzzle2x2.tiles),
      );
    });

    test('Initialized with new solvable 2x2 puzzle tiles', () {
      const configs = Configs(defaultPuzzleSize: 2);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          tilesProvider.overrideWith(() => tilesNotifier),
          configsProvider.overrideWithValue(configs),
        ],
      );
      addTearDown(providerContainer.dispose);

      expect(
        providerContainer.read(tilesProvider),
        equals(solvable2x2PuzzleWithSeed2),
      );
    });

    test('Initialized with new solvable 3x3 puzzle tiles', () {
      const configs = Configs(defaultPuzzleSize: 3);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          tilesProvider.overrideWith(() => tilesNotifier),
          configsProvider.overrideWithValue(configs),
        ],
      );
      addTearDown(providerContainer.dispose);

      expect(
        providerContainer.read(tilesProvider),
        equals(solvable3x3PuzzleWithSeed2),
      );
    });
  });
}
