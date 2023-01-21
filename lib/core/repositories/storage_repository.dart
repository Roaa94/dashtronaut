import 'dart:developer';

import 'package:dashtronaut/core/services/storage/storage.dart';

abstract class StorageRepository<T> {
  StorageRepository(this.storageService);

  final StorageService storageService;

  dynamic toJson(T item);

  String get storageKey;

  bool get hasData => storageService.has(storageKey);

  T get() {
    try {
      return storageService.get(storageKey);
    } catch (e) {
      log('Error getting $T from storage');
      log('$e');
      rethrow;
    }
  }

  void set(T item) {
    try {
      storageService.set(StorageKeys.tiles, toJson(item));
    } catch (e) {
      log('Error updating $T in storage');
      log('$e');
      rethrow;
    }
  }
}
