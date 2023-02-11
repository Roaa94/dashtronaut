import 'dart:convert';

import 'package:dashtronaut/core/services/storage/storage.dart';

abstract class StorageRepository<T> {
  StorageRepository(this.storageService);

  final StorageService storageService;

  String get storageKey;

  T fromJson(dynamic json) => json;

  dynamic toJson(T item) => item;

  bool get hasData => storageService.has(storageKey);

  T? get() {
    final data = storageService.get(storageKey);
    return data == null ? null : fromJson(json.decode(json.encode(data)));
  }

  void set(T item) {
    storageService.set(storageKey, toJson(item));
  }

  void update(Map<String, dynamic> data) {
    final existingData =
        storageService.get(storageKey) as Map<String, dynamic>? ?? {};
    existingData.addAll(data);
    storageService.set(storageKey, existingData);
  }

  void clear() {
    storageService.remove(storageKey);
  }
}
