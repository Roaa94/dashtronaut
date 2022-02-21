import 'package:flutter_puzzle_hack/domain/storage/storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageService implements StorageService {
  late Box _hiveAppBox;

  Future<void> _openBoxes() async {
    _hiveAppBox = await Hive.openBox('dashtronaut');
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await _openBoxes();
  }

  @override
  Future<void> remove(String key) async {
    _hiveAppBox.delete(key);
  }

  @override
  dynamic get(String key) {
    return _hiveAppBox.get(key);
  }

  @override
  dynamic getAll() {
    return _hiveAppBox.values.toList();
  }

  @override
  bool has(String key) {
    return _hiveAppBox.containsKey(key);
  }

  @override
  Future<void> set(String? key, dynamic data) async {
    _hiveAppBox.put(key, data);
  }

  @override
  Future<void> clear() async {
    await _hiveAppBox.clear();
  }

  @override
  Future<void> clearBox() async {
    await _hiveAppBox.clear();
  }
}
