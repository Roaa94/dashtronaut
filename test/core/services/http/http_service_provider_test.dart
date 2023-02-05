import 'package:dashtronaut/core/services/http/http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('httpServiceProvider implementation is $DioHttpService', () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(httpServiceProvider),
      isA<DioHttpService>(),
    );
  });
}