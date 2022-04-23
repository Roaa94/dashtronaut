import 'package:dashtronaut/services/storage/hive_storage_service.dart';
import 'package:dashtronaut/services/storage/storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerSingleton<StorageService>(HiveStorageService());
}
