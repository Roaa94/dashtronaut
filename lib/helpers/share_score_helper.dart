import 'package:Dashtronaut/helpers/duration_helper.dart';
import 'package:Dashtronaut/models/puzzle.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper class that handles sharing puzzle score
///
/// e.g. sharing, launching a url, shared text, ...
class ShareScoreHelper {
  /// The Dashtronaut app official website
  static const String officialWebsiteUrl = 'https://dashtronaut.app';

  /// Path for images of solved puzzles stored on the official website
  static const String puzzleSolvedImagesUrlRoot =
      '$officialWebsiteUrl/images/puzzle-solved';

  /// Url for Twitter intent to launch twitter with tweet content
  static const String twitterIntentUrl = 'https://twitter.com/intent/tweet';

  /// Get image of solved puzzle based on size
  ///
  /// There should be an image for each supported size
  /// in the puzzle [Puzzle.supportedPuzzleSizes]
  static String getPuzzleSolvedImageUrl(int size) {
    return '$puzzleSolvedImagesUrlRoot/solved-${size}x$size.png';
  }

  /// Open a link using the url_launcher package
  ///
  /// Check if link can be opened first
  static Future<void> openLink(String url, {VoidCallback? onError}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else if (onError != null) {
      onError();
    }
  }

  /// Get the puzzle solved text based on score
  static String getPuzzleSolvedText(
      int movesCount, Duration duration, int tilesCount) {
    return 'I just solved this $tilesCount-Tile Dashtronaut slide puzzle in ${DurationHelper.toFormattedTime(duration)} with $movesCount moves!';
  }

  /// Get the puzzle solved text based on score for mobile
  static String getPuzzleSolvedTextMobile(
      int movesCount, Duration duration, int tilesCount) {
    return '${getPuzzleSolvedText(movesCount, duration, tilesCount)} \n\n$officialWebsiteUrl';
  }

  /// Get the link to Twitter with text and url params filled based on score
  static String getTwitterShareLink(
      int movesCount, Duration duration, int tilesCount) {
    return '$twitterIntentUrl?text=${getPuzzleSolvedText(movesCount, duration, tilesCount)}&url=$officialWebsiteUrl';
  }
}
