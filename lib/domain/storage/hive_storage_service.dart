import 'package:flutter_puzzle_hack/domain/storage/storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageService implements StorageService {
  late Box _hiveAppBox;

  Future<void> _openBoxes() async {
    _hiveAppBox = await Hive.openBox(StorageBoxNames.appBox);
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await _openBoxes();
  }

  Box _getTargetBox(String? boxName) {
    switch (boxName) {
      case StorageBoxNames.appBox:
        return _hiveAppBox;
      default:
        return _hiveAppBox;
    }
  }

  @override
  Future<void> remove(String key,
      {String boxName = StorageBoxNames.appBox}) async {
    _getTargetBox(boxName).delete(key);
  }

  @override
  dynamic get(String key, {String boxName = StorageBoxNames.appBox}) {
    return _getTargetBox(boxName).get(key);
  }

  @override
  dynamic getAll({String boxName = StorageBoxNames.appBox}) {
    return _getTargetBox(boxName).values.toList();
  }

  @override
  bool has(String key, {String? boxName}) {
    return _getTargetBox(boxName).containsKey(key);
  }

  @override
  Future<void> set(String? key, dynamic data,
      {String boxName = StorageBoxNames.appBox}) async {
    _getTargetBox(boxName).put(key, data);
  }

  @override
  Future<void> clear() async {
    await _hiveAppBox.clear();
  }

  @override
  Future<void> clearBox({String boxName = StorageBoxNames.appBox}) async {
    await _getTargetBox(boxName).clear();
  }
}
