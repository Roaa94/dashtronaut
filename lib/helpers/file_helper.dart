import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Helper class for handling [File]s
class FileHelper {
  /// Returns a type [File] from an asset path
  ///
  /// Writes the file's binary data to temporary location
  /// And returns the written file
  static Future<File> getFileFromAsset(String path) async {
    final byteData = await rootBundle.load(path);
    Directory _tempDirectory = await getTemporaryDirectory();
    String _tempPath = '${_tempDirectory.path}/$path';
    return await File(_tempPath).writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  /// Returns a type [File] from a url
  ///
  /// Writes the file's binary data to temporary location
  /// And returns the written file
  static Future<File> getFileFromUrl(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final byteData = response.bodyBytes;
    Directory _tempDirectory = await getTemporaryDirectory();
    String _tempPath = '${_tempDirectory.path}/file.png';
    return await File(_tempPath).writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
}
