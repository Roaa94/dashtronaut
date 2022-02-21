class StorageKeys {
  static const String localeCode = 'locale_code';
}

class StorageBoxNames {
  static const String appBox = 'flutter_festival_sa';
}

abstract class StorageService {
  Future<void> init();

  Future<void> remove(String key, {String boxName = StorageBoxNames.appBox});

  dynamic get(String key, {String boxName = StorageBoxNames.appBox});

  dynamic getAll({String boxName = StorageBoxNames.appBox});

  Future<void> clear();

  Future<void> clearBox({String boxName = StorageBoxNames.appBox});

  bool has(String key, {String boxName = StorageBoxNames.appBox});

  Future<void> set(String? key, dynamic data, {String boxName = StorageBoxNames.appBox});
}
