class Constants {
  static const List<int> supportedPuzzleSizes = [3, 4, 5, 6];

  static const int maxStorableScores = 10;

  // Todo: remove string constants when localization is set up
  static const String scoresTitle = 'Latest Scores';

  static const String emptyScoresMessage =
      'Solve the puzzle to see your scores here! You can do it!';

  /// The Dashtronaut app official website
  static const String officialWebsiteUrl = 'https://dashtronaut.app';

  /// Url for Twitter intent to launch twitter with tweet content
  static const String twitterIntentUrl = 'https://twitter.com/intent/tweet';

  /// Path for images of solved puzzles stored on the official website
  static const String puzzleSolvedImagesUrlRoot =
      '$officialWebsiteUrl/images/puzzle-solved';
}
