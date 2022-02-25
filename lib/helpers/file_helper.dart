import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path;

/// Helper class for handling [File]s
class FileHelper {
  /// Get temporary directory
  static Future<Directory> getTemporaryDirectory() async {
    return await path.getTemporaryDirectory();
  }

  /// Write File as Bytes from path
  static Future<File> writeFileAsBytes(dynamic byteData, String filePath) async {
    return await File(filePath).writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  /// Returns a type [File] from an asset path
  ///
  /// Writes the file's binary data to temporary location
  /// And returns the written file
  static Future<File> getFileFromAsset(String path) async {
    final byteData = await rootBundle.load(path);
    Directory _tempDirectory = await getTemporaryDirectory();
    String _tempPath = '${_tempDirectory.path}/$path';
    return await writeFileAsBytes(byteData, _tempPath);
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
    return await writeFileAsBytes(byteData, _tempPath);
  }
}
