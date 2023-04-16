import 'dart:async';

import 'package:dashtronaut/stop-watch/repositories/stop_watch_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stopWatchProvider = NotifierProvider<StopWatchNotifier, int>(
  () => StopWatchNotifier(),
);

class StopWatchNotifier extends Notifier<int> {
  @override
  int build() {
    final storedDuration = stopWatchRepository.get();
    if (storedDuration != null && storedDuration > 0) {
      start();
    }
    ref.onDispose(() {
      streamSubscription?.cancel();
      timeStream = null;
      // Todo: investigate
      // state = 0;
    });
    return storedDuration ?? 0;
  }

  StopWatchStorageRepository get stopWatchRepository =>
      ref.watch(stopWatchRepositoryProvider);

  Stream<int>? timeStream;

  StreamSubscription<int>? streamSubscription;

  void start() {
    timeStream = Stream.periodic(const Duration(seconds: 1), (x) => 1 + x++);
    streamSubscription = timeStream!.listen((seconds) {
      state = state + 1;
      stopWatchRepository.set(state);
    });
  }

  void pause() {
    streamSubscription?.pause();
  }

  // Todo: add resume
  void stop() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
      timeStream = null;
      state = 0;
      stopWatchRepository.set(state);
    }
  }
}
