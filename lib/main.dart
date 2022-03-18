import 'dart:async';

import 'package:Dashtronaut/app.dart';
import 'package:Dashtronaut/services/service_locator.dart';
import 'package:Dashtronaut/services/storage/storage_service.dart';
import 'package:flutter/material.dart';

void main() {
  setupServiceLocator();
  runZonedGuarded<Future<void>>(() async {
    final StorageService storageService = getIt<StorageService>();
    await storageService.init();

    runApp(App(storageService: storageService));
  }, (e, _) => throw e);
}
