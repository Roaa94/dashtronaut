import 'dart:developer';

import 'package:dashtronaut/core/providers/is_web_provider.dart';
import 'package:dashtronaut/core/services/share-score/file_share_service.dart';
import 'package:dashtronaut/core/services/share-score/url_service.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/providers/score_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shareScoreServiceProvider = Provider<ShareScoreService>((ref) {
  return AdaptiveShareScoreService(
    ref.watch(scoreProvider),
    isWeb: ref.watch(isWebProvider),
    urlLauncherService: ref.watch(urlLauncherServiceProvider),
    fileShareService: ref.watch(fileShareServiceProvider),
  );
});

/// Service for sharing puzzle score
///
/// e.g. sharing, launching a url, shared text, ...
abstract class ShareScoreService {
  final Score score;

  const ShareScoreService(this.score);

  Future<void> share();
}

class AdaptiveShareScoreService extends ShareScoreService {
  AdaptiveShareScoreService(
    super.score, {
    required this.isWeb,
    required this.urlLauncherService,
    required this.fileShareService,
  });

  final bool isWeb;
  final UrlService urlLauncherService;
  final FileShareService fileShareService;

  Future<void> _openLink() async {
    try {
      await urlLauncherService.openLink(score.twitterShareLink);
    } catch (e) {
      log('Error launching Twitter url!');
      log(e.toString());
    }
  }

  @override
  Future<void> share() async {
    if (isWeb) {
      _openLink();
    } else {
      try {
        await fileShareService.shareFileFromUrl(
          url: score.puzzleSolvedImageUrl,
          shareText: score.puzzleSolvedTextMobile,
        );
      } catch (e) {
        log('Error sharing file from url! Opening link instead');
        log(e.toString());
        _openLink();
      }
    }
  }
}
