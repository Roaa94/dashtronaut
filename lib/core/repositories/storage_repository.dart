import 'dart:developer';

import 'package:dashtronaut/core/models/model.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';

abstract class StorageRepository<T extends Model> {
  StorageRepository(this.storageService);

  final StorageService storageService;

  String get storageKey;

  T fromJson(Map<String, dynamic> json);

  bool get hasData => storageService.has(storageKey);

  T? get() {
    final data = storageService.get(storageKey);
    return data == null ? null : fromJson(data);
  }

  void set(T item) {
    storageService.set(storageKey, item.toJson());
  }

  void update(Map<String, dynamic> data) {
    final existingData = storageService.get(storageKey) as Map<String, dynamic>;
    existingData.addAll(data);
    storageService.set(storageKey, existingData);
  }

  void clear() {
    storageService.remove(storageKey);
  }
}
