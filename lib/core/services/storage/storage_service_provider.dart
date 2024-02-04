import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider that locates an [StorageService] interface to implementation
final storageServiceProvider = Provider<StorageService>(
  (_) => HiveStorageService(),
);
