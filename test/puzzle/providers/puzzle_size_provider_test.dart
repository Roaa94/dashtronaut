import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
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

  test('initialized with $Configs.defaultPuzzleSize value', () {
    const configs = Configs();

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        configsProvider.overrideWithValue(configs),
      ],
    );

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(puzzleSizeProvider),
      equals(configs.defaultPuzzleSize),
    );
  });

  test('initialized with data from repository when available', () {
    when(mockPuzzleRepository.get).thenReturn(puzzle2x2Solved);

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(puzzleSizeProvider),
      equals(puzzle2x2Solved.n),
    );
  });

  test('updates state', () {
    final puzzleSizeListener = Listener<int>();
    const newValue = 2;
    const configs = Configs();

    when(() => mockPuzzleRepository.updatePuzzle(puzzleSize: newValue))
        .thenAnswer((_) {});

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        configsProvider.overrideWithValue(configs),
      ],
    );

    addTearDown(providerContainer.dispose);

    puzzleSizeProvider.addListener(
      providerContainer,
      puzzleSizeListener,
      onError: (_, __) {},
      onDependencyMayHaveChanged: () {},
      fireImmediately: true,
    );
    verify(() => puzzleSizeListener(null, configs.defaultPuzzleSize)).called(1);

    providerContainer.read(puzzleSizeProvider.notifier).update(newValue);

    verify(() => puzzleSizeListener(configs.defaultPuzzleSize, newValue))
        .called(1);
    expect(
      providerContainer.read(puzzleSizeProvider),
      equals(newValue),
    );
    verifyNoMoreInteractions(puzzleSizeListener);
  });

  test('updates repository when state is updated', () {
    const newValue = 2;
    const configs = Configs();

    when(() => mockPuzzleRepository.updatePuzzle(puzzleSize: newValue))
        .thenAnswer((_) {});

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        configsProvider.overrideWithValue(configs),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.read(puzzleSizeProvider.notifier).update(newValue);

    verify(
      () => mockPuzzleRepository.updatePuzzle(puzzleSize: newValue),
    ).called(1);
  });
}
