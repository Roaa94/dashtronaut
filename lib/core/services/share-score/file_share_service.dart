import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';

final fileShareServiceProvider = Provider<FileShareService>(
  (_) => XFileShareService(),
);

abstract class FileShareService {
  /// Returns a type [File] from a url
  ///
  /// Writes the file's binary data to temporary location
  /// And returns the written file
  Future<File> getFileFromUrl(String url);

  Future<void> shareFileFromUrl({
    required String url,
    required String shareText,
  });
}

class XFileShareService extends FileShareService {
  /// Get temporary directory
  Future<Directory> getTemporaryDirectory() async {
    return await path.getTemporaryDirectory();
  }

  /// Write File as Bytes from path
  Future<File> writeFileAsBytes(dynamic byteData, String filePath) async {
    return await File(filePath).writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  @override
  Future<File> getFileFromUrl(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final byteData = response.bodyBytes;
    Directory tempDirectory = await getTemporaryDirectory();
    String tempPath = '${tempDirectory.path}/file.png';
    return await writeFileAsBytes(byteData, tempPath);
  }

  @override
  Future<void> shareFileFromUrl({
    required String url,
    required String shareText,
  }) async {
    File file = await getFileFromUrl(url);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: shareText,
    );
  }
}
