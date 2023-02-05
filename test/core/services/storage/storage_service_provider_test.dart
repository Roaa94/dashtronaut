import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('serviceProvider returns HiveStorageService', () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(storageServiceProvider),
      isA<HiveStorageService>(),
    );
  });
}
