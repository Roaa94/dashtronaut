import 'dart:typed_data';

import 'package:dashtronaut/core/services/http/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  const testUrl = 'https://test.url';
  late DioHttpService dioHttpService;
  late DioAdapter dioAdapter;

  setUp(() {
    dioAdapter = DioAdapter(
      dio: Dio(
        BaseOptions(
          responseType: ResponseType.bytes,
        ),
      ),
    );

    dioHttpService = DioHttpService(dioAdapter.dio);

    dioAdapter.onGet(
      testUrl,
      (server) => server.reply(200, Uint8List(0)),
    );
  });

  test('can get bytes from url', () async {
    expect(dioHttpService.getBytes(testUrl), completes);

    expect(
      await dioHttpService.getBytes(testUrl),
      isA<Uint8List>(),
    );
  });
}
