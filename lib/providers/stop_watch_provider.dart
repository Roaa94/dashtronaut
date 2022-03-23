import 'dart:async';

import 'package:Dashtronaut/services/storage/storage_service.dart';
import 'package:flutter/cupertino.dart';

class StopWatchProvider with ChangeNotifier {
  Stream<int> timeStream =
      Stream.periodic(const Duration(seconds: 1), (x) => 1 + x++);

  final StorageService storageService;

  StopWatchProvider(this.storageService);

  StreamSubscription<int>? streamSubscription;

  int secondsElapsed = 0;

  void init() {
    secondsElapsed = storageService.get(StorageKey.secondsElapsed) ?? 0;
  }

  void start() {
    if (streamSubscription != null && streamSubscription!.isPaused) {
      streamSubscription!.resume();
    } else {
      streamSubscription = timeStream.listen((seconds) {
        secondsElapsed++;
        notifyListeners();
        storageService.set(StorageKey.secondsElapsed, secondsElapsed);
      });
    }
  }

  void stop() {
    if (streamSubscription != null && !streamSubscription!.isPaused) {
      streamSubscription!.pause();
      secondsElapsed = 0;
      notifyListeners();
      storageService.set(StorageKey.secondsElapsed, secondsElapsed);
    }
  }

  void cancel() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }
}
