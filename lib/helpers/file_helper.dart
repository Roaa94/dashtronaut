import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FileHelper {
  static Future<File> getImageFileFromAsset(String path) async {
    final byteData = await rootBundle.load(path);
    Directory _tempDirectory = await getApplicationDocumentsDirectory();
    String _tempPath = '${_tempDirectory.path}/$path';
    final _file = await File(_tempPath).writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return _file;
  }

  static Future<File> getImageFileFromUrl(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final byteData = response.bodyBytes;
    Directory _tempDirectory = await getTemporaryDirectory();
    String _tempPath = '${_tempDirectory.path}/image.png';
    final _file = await File(_tempPath).writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return _file;
  }
}
