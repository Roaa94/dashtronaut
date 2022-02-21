import 'package:flutter_puzzle_hack/domain/storage/hive_storage_service.dart';
import 'package:flutter_puzzle_hack/domain/storage/storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerSingleton<StorageService>(HiveStorageService());
}
