import 'package:dashtronaut/stop-watch/providers/stop_watch_provider.dart';
import 'package:dashtronaut/stop-watch/repositories/stop_watch_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late StopWatchStorageRepository mockStopWatchRepository;

  setUp(() {
    mockStopWatchRepository = MockStopWatchStorageRepository();
  });

  test('Updates state and repository when listening to the stream', () async {
    final stopWatchListener = Listener<int>();
    final providerContainer = ProviderContainer(
      overrides: [
        stopWatchRepositoryProvider.overrideWithValue(mockStopWatchRepository),
      ],
    );

    providerContainer.listen(
      stopWatchProvider,
      stopWatchListener,
      fireImmediately: true,
    );

    verify(() => stopWatchListener(null, 0)).called(1);
    providerContainer.read(stopWatchProvider.notifier).start();

    await Future.delayed(const Duration(seconds: 1));
    verify(() => stopWatchListener(0, 1)).called(1);
    verify(() => mockStopWatchRepository.set(1)).called(1);

    await Future.delayed(const Duration(seconds: 1));
    verify(() => stopWatchListener(1, 2)).called(1);
    verify(() => mockStopWatchRepository.set(2)).called(1);
  });

  test(
    'Can stop the stream and reset the elapsed time to 0 seconds',
    () async {
      final stopWatchListener = Listener<int>();
      final providerContainer = ProviderContainer(
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
        ],
      );

      providerContainer.listen(
        stopWatchProvider,
        stopWatchListener,
        fireImmediately: true,
      );

      verify(() => stopWatchListener(null, 0)).called(1);
      providerContainer.read(stopWatchProvider.notifier).start();

      await Future.delayed(const Duration(seconds: 1));
      verify(() => stopWatchListener(0, 1)).called(1);

      providerContainer.read(stopWatchProvider.notifier).stop();
      verify(() => stopWatchListener(1, 0)).called(1);
      verify(() => mockStopWatchRepository.set(0)).called(1);
    },
  );

  test(
    'Can resume the stream after it has been stopped',
    () async {
      final stopWatchListener = Listener<int>();
      final providerContainer = ProviderContainer(
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
        ],
      );

      providerContainer.listen(
        stopWatchProvider,
        stopWatchListener,
        fireImmediately: true,
      );

      providerContainer.read(stopWatchProvider.notifier).start();
      await Future.delayed(const Duration(seconds: 1));

      providerContainer.read(stopWatchProvider.notifier).stop();
      await Future.delayed(const Duration(seconds: 1));

      providerContainer.read(stopWatchProvider.notifier).start();
      verify(() => stopWatchListener(0, 1)).called(1);
    },
  );

  test('initialized from repository value when available', () {
    const elapsed = 20;
    when(() => mockStopWatchRepository.get()).thenReturn(elapsed);

    final providerContainer = ProviderContainer(
      overrides: [
        stopWatchRepositoryProvider.overrideWithValue(mockStopWatchRepository),
      ],
    );
    addTearDown(providerContainer.dispose);

    expect(providerContainer.read(stopWatchProvider), elapsed);
  });

  test(
    'Resumes the elapsed time stream from the value stored in the repository',
        () async {
      const elapsed = 20;
      when(() => mockStopWatchRepository.get()).thenReturn(elapsed);
      final stopWatchListener = Listener<int>();
      final providerContainer = ProviderContainer(
        overrides: [
          stopWatchRepositoryProvider
              .overrideWithValue(mockStopWatchRepository),
        ],
      );

      providerContainer.listen(
        stopWatchProvider,
        stopWatchListener,
        fireImmediately: true,
      );

      verify(() => stopWatchListener(null, elapsed)).called(1);
      providerContainer.read(stopWatchProvider.notifier).start();

      await Future.delayed(const Duration(seconds: 1));
      verify(() => stopWatchListener(elapsed, elapsed + 1)).called(1);
      verify(() => mockStopWatchRepository.set(elapsed + 1)).called(1);
    },
  );
}
