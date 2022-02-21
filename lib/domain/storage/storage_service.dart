class StorageKey {
  static const String tiles = 'tiles';

  static const String puzzleSize = 'n';
}

abstract class StorageService {
  Future<void> init();

  Future<void> remove(String key);

  dynamic get(String key);

  dynamic getAll();

  Future<void> clear();

  Future<void> clearBox();

  bool has(String key);

  Future<void> set(String? key, dynamic data);
}
