import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:Dashtronaut/services/service_locator.dart';
import 'package:Dashtronaut/services/storage/storage_service.dart';

class StopWatchProvider with ChangeNotifier {
  Stream<int> timeStream = Stream.periodic(const Duration(seconds: 1), (x) => 1 + x++);
  static final StorageService _storageService = getIt<StorageService>();

  StreamSubscription<int>? streamSubscription;

  int secondsElapsed = _storageService.get(StorageKey.secondsElapsed) ?? 0;

  void start() {
    if (streamSubscription != null && streamSubscription!.isPaused) {
      streamSubscription!.resume();
    } else {
      streamSubscription = timeStream.listen((seconds) {
        secondsElapsed++;
        notifyListeners();
        _storageService.set(StorageKey.secondsElapsed, secondsElapsed);
      });
    }
  }

  void stop() {
    if (streamSubscription != null && !streamSubscription!.isPaused) {
      streamSubscription!.pause();
      secondsElapsed = 0;
      notifyListeners();
      _storageService.set(StorageKey.secondsElapsed, secondsElapsed);
    }
  }

  void cancel() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
  }
}
