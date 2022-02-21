import 'package:flutter_puzzle_hack/domain/storage/hive_storage_service.dart';
import 'package:get_it/get_it.dart';

import 'storage/storage_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  //Storage Service must be located first because other services use it
  getIt.registerSingleton<StorageService>(HiveStorageService());
}
