import 'dart:math';

import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_state.dart';
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
        providerContainer.read(puzzleProvider).tiles,
        equals(puzzle2x2Solved.tiles),
      );
    });

    test('Initialized with new solvable 2x2 puzzle tiles', () {
      final random = Random(seed);
      const configs = Configs(defaultPuzzleSize: 2);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          puzzleProvider.overrideWith(() => PuzzleNotifier(random: random)),
          configsProvider.overrideWithValue(configs),
        ],
      );
      addTearDown(providerContainer.dispose);

      expect(
        providerContainer.read(puzzleProvider).tiles,
        equals(solvable2x2PuzzleWithSeed2),
      );
    });

    test('Initialized with new solvable 3x3 puzzle tiles', () {
      final random = Random(seed);
      const configs = Configs(defaultPuzzleSize: 3);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          puzzleProvider.overrideWith(() => PuzzleNotifier(random: random)),
          configsProvider.overrideWithValue(configs),
        ],
      );
      addTearDown(providerContainer.dispose);

      expect(
        providerContainer.read(puzzleProvider).tiles,
        equals(solvable3x3PuzzleWithSeed2),
      );
    });
  });

  group('Puzzle reset', () {
    test('can reset tiles state', () {
      final random = Random(seed);
      const configs = Configs(defaultPuzzleSize: 2);
      final tilesListener = Listener<PuzzleState>();
      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          puzzleProvider.overrideWith(() => PuzzleNotifier(random: random)),
          configsProvider.overrideWithValue(configs),
        ],
      );

      providerContainer.listen(
        puzzleProvider,
        tilesListener,
        fireImmediately: true,
      );

      addTearDown(providerContainer.dispose);

      verify(
        () => tilesListener(
          null,
          const PuzzleState(tiles: solvable2x2PuzzleWithSeed2),
        ),
      ).called(1);

      expect(
        providerContainer.read(puzzleProvider).tiles,
        equals(solvable2x2PuzzleWithSeed2),
      );

      providerContainer.read(puzzleProvider.notifier).reset();
      verify(() => tilesListener(
            const PuzzleState(tiles: solvable2x2PuzzleWithSeed2),
            const PuzzleState(tiles: solvable2x2PuzzleWithSeed2Reset),
          )).called(1);

      expect(
        providerContainer.read(puzzleProvider).tiles,
        equals(solvable2x2PuzzleWithSeed2Reset),
      );
    });

    test('updates tiles in puzzle repository when tiles state is reset', () {
      final random = Random(seed);
      const configs = Configs(defaultPuzzleSize: 2);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          puzzleProvider.overrideWith(() => PuzzleNotifier(random: random)),
          configsProvider.overrideWithValue(configs),
        ],
      );

      addTearDown(providerContainer.dispose);
      expect(
        providerContainer.read(puzzleProvider).tiles,
        equals(solvable2x2PuzzleWithSeed2),
      );

      providerContainer.read(puzzleProvider.notifier).reset();

      verify(
        () => mockPuzzleRepository.updatePuzzle(
          tiles: solvable2x2PuzzleWithSeed2Reset,
          movesCount: 0,
        ),
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

      providerContainer.read(puzzleProvider.notifier).swapTiles(tileToMove);

      expect(
        providerContainer.read(puzzleProvider).tiles,
        newTiles,
      );
    });

    test('Updates repository when swapping tiles', () {
      const initialMovesCount = 20;
      when(mockPuzzleRepository.get)
          .thenReturn(puzzle2x2.copyWith(movesCount: initialMovesCount));

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      addTearDown(providerContainer.dispose);

      providerContainer.read(puzzleProvider.notifier).swapTiles(tileToMove);
      verify(
        () => mockPuzzleRepository.updatePuzzle(
          tiles: newTiles,
          movesCount: initialMovesCount + 1,
        ),
      ).called(1);
    });

    test('Does not swap tiles when puzzle is already solved', () {
      final tilesListener = Listener<PuzzleState>();
      when(mockPuzzleRepository.get).thenReturn(puzzle2x2Solved);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      providerContainer.listen(
        puzzleProvider,
        tilesListener,
        fireImmediately: true,
      );

      addTearDown(providerContainer.dispose);

      verify(
        () => tilesListener(
          null,
          PuzzleState(tiles: puzzle2x2Solved.tiles),
        ),
      ).called(1);

      providerContainer.read(puzzleProvider.notifier).swapTiles(tileToMove);

      verifyNoMoreInteractions(tilesListener);
    });
  });

  test('updating puzzle size resets tiles', () async {
    final random = Random(seed);
    const currentSize = 2;
    const newSize = 3;
    final tilesListener = Listener<PuzzleState>();
    when(() => mockPuzzleRepository.get()).thenReturn(
      const Puzzle(
        n: currentSize,
        movesCount: 0,
        tiles: [],
      ),
    );

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleProvider.overrideWith(() => PuzzleNotifier(random: random)),
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen(
      puzzleProvider,
      tilesListener,
      fireImmediately: true,
    );

    verify(
      () => tilesListener.call(
        null,
        const PuzzleState(tiles: solvable2x2PuzzleWithSeed2),
      ),
    ).called(1);

    providerContainer.read(puzzleSizeProvider.notifier).update(newSize);
    await Future.delayed(Duration.zero);

    verify(
      () => tilesListener.call(
        const PuzzleState(tiles: solvable2x2PuzzleWithSeed2),
        const PuzzleState(tiles: solvable3x3PuzzleWithSeed2SizeReset),
      ),
    ).called(1);
  });
}
