import 'dart:io';
import 'package:dashtronaut/core/services/http/http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:cross_file/cross_file.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';

final fileShareServiceProvider = Provider<FileShareService>(
  (ref) => XFileShareService(
    ref.watch(httpServiceProvider),
    ref.watch(sharePlatformProvider),
  ),
);

final sharePlatformProvider = Provider<SharePlatform>(
  (_) => SharePlatform.instance,
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
  final HttpService httpService;
  final SharePlatform sharePlatform;

  XFileShareService(
    this.httpService,
    this.sharePlatform,
  );

  /// Get temporary directory
  Future<Directory> getTemporaryDirectory() async {
    return await path.getTemporaryDirectory();
  }

  /// Write File as Bytes from path
  Future<File> writeFileAsBytes(dynamic byteData, String filePath) async {
    return await File(filePath).writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
  }

  @override
  Future<File> getFileFromUrl(String url) async {
    final byteData = await httpService.getBytes(url);
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

    await sharePlatform.shareXFiles(
      [XFile(file.path)],
      text: shareText,
    );
  }
}
