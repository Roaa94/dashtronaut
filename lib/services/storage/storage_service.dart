class StorageKey {
  static const String puzzle = 'puzzle';

  static const String secondsElapsed = 'secondsElapsed';

  static const String scores = 'scores';
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
