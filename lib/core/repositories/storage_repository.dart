import 'dart:developer';

import 'package:dashtronaut/core/models/model.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';

abstract class StorageRepository<T extends Model> {
  StorageRepository(this.storageService);

  final StorageService storageService;

  T fromJson(Map<String, dynamic> json);

  String get storageKey;

  bool get hasData => storageService.has(storageKey);

  T get() {
    try {
      final data = storageService.get(storageKey);
      return fromJson(data);
    } catch (e) {
      log('Error getting $T from storage');
      log('$e');
      rethrow;
    }
  }

  void set(T item) {
    try {
      storageService.set(storageKey, item.toJson());
    } catch (e) {
      log('Error setting $T in storage');
      log('$e');
      rethrow;
    }
  }

  void update(Map<String, dynamic> data) {
    try {
      final existingData = storageService.get(storageKey) as Map<String, dynamic>;
      existingData.addAll(data);
      storageService.set(storageKey, existingData);
    } catch (e) {
      log('Error setting $T in storage');
      log('$e');
      rethrow;
    }
  }
}
