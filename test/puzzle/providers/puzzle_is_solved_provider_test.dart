import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
  });

  test('returns true when tilesProvider tiles are in a solved arrangement', () {
    when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2Solved);

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    expect(providerContainer.read(puzzleIsSolvedProvider), isTrue);
  });

  test('returns true when tilesProvider tiles are in a solved arrangement', () {
    when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    expect(providerContainer.read(puzzleIsSolvedProvider), isFalse);
  });

  test(
      'updating tilesProvider with a solved tiles arrangement will update puzzleIsSolvedProvider',
      () async {
    when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);
    final isSolvedListener = Listener<bool>();

    const tileToMoveToSolvePuzzle = Tile(
      value: 3,
      currentLocation: Location(x: 2, y: 2),
      correctLocation: Location(x: 1, y: 2),
    );

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    providerContainer.listen(
      puzzleIsSolvedProvider,
      isSolvedListener,
      fireImmediately: true,
    );

    addTearDown(providerContainer.dispose);

    verify(() => isSolvedListener(null, false)).called(1);

    providerContainer
        .read(puzzleProvider.notifier)
        .swapTiles(tileToMoveToSolvePuzzle);

    await Future.delayed(Duration.zero);

    verify(() => isSolvedListener(false, true)).called(1);
  });

  test(
      'puzzleIsSolvedProvider listener does not fire '
      'when tilesProvider state is updated but the puzzle is not solved yet',
      () async {
    when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);
    final isSolvedListener = Listener<bool>();

    const tileToMoveWithoutSolvingPuzzle = Tile(
      value: 1,
      currentLocation: Location(x: 1, y: 1),
      correctLocation: Location(x: 1, y: 1),
    );

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    providerContainer.listen(
      puzzleIsSolvedProvider,
      isSolvedListener,
      fireImmediately: true,
    );

    addTearDown(providerContainer.dispose);

    verify(() => isSolvedListener(null, false)).called(1);

    providerContainer
        .read(puzzleProvider.notifier)
        .swapTiles(tileToMoveWithoutSolvingPuzzle);

    await Future.delayed(Duration.zero);

    verifyNoMoreInteractions(isSolvedListener);
  });
}
