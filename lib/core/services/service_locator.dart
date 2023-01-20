import 'package:dashtronaut/core/services/storage/hive_storage_service.dart';
import 'package:dashtronaut/core/services/storage/storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerSingleton<StorageService>(HiveStorageService());
}
