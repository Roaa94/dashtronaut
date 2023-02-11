import 'dart:async';

import 'package:dashtronaut/stop-watch/repositories/stop_watch_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stopWatchProvider = NotifierProvider<StopWatchNotifier, int>(
  () => StopWatchNotifier(),
);

class StopWatchNotifier extends Notifier<int> {
  @override
  int build() {
    return stopWatchRepository.get() ?? 0;
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

  void stop() {
    if (streamSubscription != null && !streamSubscription!.isPaused) {
      streamSubscription!.cancel();
      state = 0;
      stopWatchRepository.set(state);
    }
  }
}
