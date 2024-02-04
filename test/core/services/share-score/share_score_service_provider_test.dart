import 'package:dashtronaut/core/services/share-score/share_score_service.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';

void main() {
  test('serviceProvider returns HiveStorageService', () {
    final providerContainer = ProviderContainer(
      overrides: [
        storageServiceProvider.overrideWithValue(MockStorageService()),
      ]
    );

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(shareScoreServiceProvider),
      isA<AdaptiveShareScoreService>(),
    );
  });
}
