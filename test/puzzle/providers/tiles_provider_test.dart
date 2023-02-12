import 'dart:math';

import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/providers/tiles_provider.dart';
import 'package:dashtronaut/puzzle/providers/tiles_state.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;

  const seed = 2;

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
  });

  group('Initialization', () {
    test('Initialized with value from repository when available', () {
      when(mockPuzzleRepository.get).thenReturn(puzzle2x2Solved);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      addTearDown(providerContainer.dispose);

      expect(
        providerContainer.read(tilesProvider).tiles,
        equals(puzzle2x2Solved.tiles),
      );
    });

    test('Initialized with new solvable 2x2 puzzle tiles', () {
      final random = Random(seed);
      const configs = Configs(defaultPuzzleSize: 2);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          tilesProvider.overrideWith(() => TilesNotifier(random: random)),
          configsProvider.overrideWithValue(configs),
        ],
      );
      addTearDown(providerContainer.dispose);

      expect(
        providerContainer.read(tilesProvider).tiles,
        equals(solvable2x2PuzzleWithSeed2),
      );
    });

    test('Initialized with new solvable 3x3 puzzle tiles', () {
      final random = Random(seed);
      const configs = Configs(defaultPuzzleSize: 3);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          tilesProvider.overrideWith(() => TilesNotifier(random: random)),
          configsProvider.overrideWithValue(configs),
        ],
      );
      addTearDown(providerContainer.dispose);

      expect(
        providerContainer.read(tilesProvider).tiles,
        equals(solvable3x3PuzzleWithSeed2),
      );
    });
  });

  group('Puzzle reset', () {
    test('can reset tiles state', () {
      final random = Random(seed);
      const configs = Configs(defaultPuzzleSize: 2);
      final tilesListener = Listener<TilesState>();
      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          tilesProvider.overrideWith(() => TilesNotifier(random: random)),
          configsProvider.overrideWithValue(configs),
        ],
      );

      providerContainer.listen(
        tilesProvider,
        tilesListener,
        fireImmediately: true,
      );

      addTearDown(providerContainer.dispose);

      verify(
        () => tilesListener(
          null,
          const TilesState(tiles: solvable2x2PuzzleWithSeed2),
        ),
      ).called(1);

      expect(
        providerContainer.read(tilesProvider).tiles,
        equals(solvable2x2PuzzleWithSeed2),
      );

      providerContainer.read(tilesProvider.notifier).reset();
      verify(() => tilesListener(
            const TilesState(tiles: solvable2x2PuzzleWithSeed2),
            const TilesState(tiles: solvable2x2PuzzleWithSeed2Reset),
          )).called(1);

      expect(
        providerContainer.read(tilesProvider).tiles,
        equals(solvable2x2PuzzleWithSeed2Reset),
      );
    });

    test('updates tiles in puzzle repository when tiles state is reset', () {
      final random = Random(seed);
      const configs = Configs(defaultPuzzleSize: 2);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          tilesProvider.overrideWith(() => TilesNotifier(random: random)),
          configsProvider.overrideWithValue(configs),
        ],
      );

      addTearDown(providerContainer.dispose);
      expect(
        providerContainer.read(tilesProvider).tiles,
        equals(solvable2x2PuzzleWithSeed2),
      );

      providerContainer.read(tilesProvider.notifier).reset();

      verify(
        () => mockPuzzleRepository.updateTiles(solvable2x2PuzzleWithSeed2Reset),
      ).called(1);
    });
  });

  group('Swapping tiles', () {
    const newTiles = [
      Tile(
        value: 1,
        currentLocation: Location(x: 1, y: 2),
        correctLocation: Location(x: 1, y: 1),
      ),
      Tile(
        value: 2,
        currentLocation: Location(x: 2, y: 1),
        correctLocation: Location(x: 2, y: 1),
      ),
      Tile(
        value: 3,
        currentLocation: Location(x: 2, y: 2),
        correctLocation: Location(x: 1, y: 2),
      ),
      Tile(
        value: 4,
        tileIsWhiteSpace: true,
        currentLocation: Location(x: 1, y: 1),
        correctLocation: Location(x: 2, y: 2),
      ),
    ];

    const tileToMove = Tile(
      value: 1,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 1, y: 1),
    );

    test('Swaps tile with whitespace tile if puzzle is not solved yet', () {
      when(mockPuzzleRepository.get).thenReturn(puzzle2x2);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      addTearDown(providerContainer.dispose);

      providerContainer.read(tilesProvider.notifier).swapTiles(tileToMove);

      expect(
        providerContainer.read(tilesProvider).tiles,
        newTiles,
      );
    });

    test('Updates repository when swapping tiles', () {
      when(mockPuzzleRepository.get).thenReturn(puzzle2x2);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      addTearDown(providerContainer.dispose);

      providerContainer.read(tilesProvider.notifier).swapTiles(tileToMove);
      verify(
        () => mockPuzzleRepository.updateTiles(newTiles),
      ).called(1);
    });

    test('Does not swap tiles when puzzle is already solved', () {
      final tilesListener = Listener<TilesState>();
      when(mockPuzzleRepository.get).thenReturn(puzzle2x2Solved);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      providerContainer.listen(
        tilesProvider,
        tilesListener,
        fireImmediately: true,
      );

      addTearDown(providerContainer.dispose);

      verify(
        () => tilesListener(
          null,
          TilesState(tiles: puzzle2x2Solved.tiles),
        ),
      ).called(1);

      providerContainer.read(tilesProvider.notifier).swapTiles(tileToMove);

      verifyNoMoreInteractions(tilesListener);
    });
  });

  group('Tile inversions', () {
    late TilesNotifier tilesNotifier;

    setUp(() {
      tilesNotifier = TilesNotifier();
    });

    test('isInversion returns false for equal tiles', () {
      const tile1 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      expect(tilesNotifier.isInversion(tile1, tile2), isFalse);
    });

    test('isInversion returns false when second tile is a whitespace', () {
      const tile1 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 7,
        correctLocation: Location(y: 3, x: 1),
        currentLocation: Location(y: 1, x: 1),
        tileIsWhiteSpace: true,
      );

      expect(tilesNotifier.isInversion(tile1, tile2), isFalse);
    });

    test('isInversion returns true when tiles are not inverted', () {
      const tile1 = Tile(
        value: 7,
        correctLocation: Location(y: 3, x: 1),
        currentLocation: Location(y: 1, x: 1),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      expect(tilesNotifier.isInversion(tile1, tile2), isFalse);
    });

    test(
        'isInversion returns true when tiles are inverted, '
        'and tile2 value is more than tile1 value', () {
      const tile1 = Tile(
        value: 7,
        correctLocation: Location(y: 3, x: 1),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 1, x: 1),
        tileIsWhiteSpace: false,
      );

      expect(tile2.value < tile1.value, isFalse);
      expect(tilesNotifier.isInversion(tile1, tile2), isTrue);
    });

    test(
        'isInversion returns true when tiles are inverted, '
        'and tile2 value is less than tile1 value', () {
      const tile1 = Tile(
        value: 8,
        correctLocation: Location(y: 3, x: 2),
        currentLocation: Location(y: 1, x: 1),
        tileIsWhiteSpace: false,
      );

      const tile2 = Tile(
        value: 7,
        correctLocation: Location(y: 3, x: 1),
        currentLocation: Location(y: 3, x: 3),
        tileIsWhiteSpace: false,
      );

      expect(tile2.value < tile1.value, isTrue);
      expect(tilesNotifier.isInversion(tile1, tile2), isTrue);
    });
  });

  test('updating puzzle size resets tiles', () async {
    final random = Random(seed);
    const currentSize = 2;
    const newSize = 3;
    final tilesListener = Listener<TilesState>();
    when(() => mockPuzzleRepository.get()).thenReturn(
      const Puzzle(
        n: currentSize,
        movesCount: 0,
        tiles: [],
      ),
    );

    final providerContainer = ProviderContainer(
      overrides: [
        tilesProvider.overrideWith(() => TilesNotifier(random: random)),
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen(
      tilesProvider,
      tilesListener,
      fireImmediately: true,
    );

    verify(
      () => tilesListener.call(
        null,
        const TilesState(tiles: solvable2x2PuzzleWithSeed2),
      ),
    ).called(1);

    providerContainer.read(puzzleSizeProvider.notifier).update(newSize);
    await Future.delayed(Duration.zero);

    verify(
      () => tilesListener.call(
        const TilesState(tiles: solvable2x2PuzzleWithSeed2),
        const TilesState(tiles: solvable3x3PuzzleWithSeed2SizeReset),
      ),
    ).called(1);
  });
}
