import 'dart:convert';

import 'package:dashtronaut/core/services/storage/storage.dart';

abstract class Repository<T> {
  T? get();

  void set(T item);

  void update(Map<String, dynamic> data);

  void clear();
}

abstract class StorageRepository<T> implements Repository<T> {
  StorageRepository(this.storageService);

  final StorageService storageService;

  String get storageKey;

  T fromJson(dynamic json) => json;

  dynamic toJson(T item) => item;

  bool get hasData => storageService.has(storageKey);

  @override
  T? get() {
    final data = storageService.get(storageKey);
    return data == null ? null : fromJson(json.decode(json.encode(data)));
  }

  @override
  void set(T item) {
    storageService.set(storageKey, toJson(item));
  }

  @override
  void update(Map<String, dynamic> data) {
    final existingData =
        storageService.get(storageKey) as Map<String, dynamic>? ?? {};
    existingData.addAll(data);
    storageService.set(storageKey, existingData);
  }

  @override
  void clear() {
    storageService.remove(storageKey);
  }
}
