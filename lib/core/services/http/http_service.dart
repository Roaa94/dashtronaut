import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpServiceProvider = Provider<HttpService>(
  (ref) => DioHttpService(ref.watch(dioProvider)),
);

final dioProvider = Provider<Dio>((_) => Dio());

abstract class HttpService {
  Future<Uint8List> getBytes(String url);
}

class DioHttpService extends HttpService {
  final Dio dio;

  DioHttpService(this.dio);

  Options get byteResponseOptions => Options(
    responseType: ResponseType.bytes,
  );

  @override
  Future<Uint8List> getBytes(String url) async {
    final response = await dio.get(
      url,
      options: byteResponseOptions,
    );
    return response.data as Uint8List;
  }
}
