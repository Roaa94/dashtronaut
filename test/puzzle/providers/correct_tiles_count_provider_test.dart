import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/correct_tiles_count_provider.dart';
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

  test('Returns 2 for a puzzle with 2 correct tiles', () {
    when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(correctTilesCountProvider),
      equals(2),
    );
  });

  test(
    'updating tilesProvider by moving a tile to a correct location'
    ' will update correctTilesCountProvider',
    () async {
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);
      final correctTilesCountListener = Listener<int>();

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
        correctTilesCountProvider,
        correctTilesCountListener,
        fireImmediately: true,
      );

      addTearDown(providerContainer.dispose);

      verify(() => correctTilesCountListener(null, 2)).called(1);

      providerContainer
          .read(puzzleProvider.notifier)
          .swapTiles(tileToMoveToSolvePuzzle);

      await Future.delayed(Duration.zero);

      verify(() => correctTilesCountListener(2, 3)).called(1);
    },
  );

  test(
    'updating tilesProvider by moving a tile to a non-correct location'
    ' will not update correctTilesCountProvider',
    () async {
      // 3
      // 2  1
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2Solvable);
      final correctTilesCountListener = Listener<int>();

      final tileToMoveToNonCorrectLocation =
          puzzle2x2.tiles.firstWhere((tile) => tile.value == 1);

      final providerContainer = ProviderContainer(
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      providerContainer.listen(
        correctTilesCountProvider,
        correctTilesCountListener,
        fireImmediately: true,
      );

      addTearDown(providerContainer.dispose);

      verify(() => correctTilesCountListener(null, 0)).called(1);

      providerContainer
          .read(puzzleProvider.notifier)
          .swapTiles(tileToMoveToNonCorrectLocation);

      await Future.delayed(Duration.zero);

      verifyNoMoreInteractions(correctTilesCountListener);
    },
  );
}
