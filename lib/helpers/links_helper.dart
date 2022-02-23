import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/helpers/duration_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksHelper {
  static const String officialWebsiteUrl = 'https://dashtronaut.app';

  static const String puzzleSolvedImagesUrlRoot = '$officialWebsiteUrl/images/puzzle-solved';

  static const String twitterIntentUrl = 'https://twitter.com/intent/tweet';

  static String getPuzzleSolvedImageUrl(int size) {
    return '$puzzleSolvedImagesUrlRoot/solved-${size}x$size.png';
  }

  static Future<void> openLink(String url, {VoidCallback? onError}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else if (onError != null) {
      onError();
    }
  }

  static String getPuzzleSolvedText(int movesCount, Duration duration, int tilesCount) {
    return 'I just solved this $tilesCount-Tile Dashtronaut slide puzzle in ${DurationHelper.toFormattedTime(duration)} with $movesCount moves!';
  }

  static String getPuzzleSolvedTextMobile(int movesCount, Duration duration, int tilesCount) {
    return '${getPuzzleSolvedText(movesCount, duration, tilesCount)} \n\n$officialWebsiteUrl';
  }

  static String getTwitterShareLink(int movesCount, Duration duration, int tilesCount) {
    return '$twitterIntentUrl?text=${getPuzzleSolvedText(movesCount, duration, tilesCount)}&url=$officialWebsiteUrl';
  }
}