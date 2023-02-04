import 'dart:convert';

import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/core/helpers/duration_helper.dart';
import 'package:equatable/equatable.dart';

class Score extends Equatable {
  final int secondsElapsed;
  final int winMovesCount;
  final int puzzleSize;

  const Score({
    required this.secondsElapsed,
    required this.winMovesCount,
    required this.puzzleSize,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      secondsElapsed: json['secondsElapsed'],
      winMovesCount: json['winMovesCount'],
      puzzleSize: json['puzzleSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secondsElapsed': secondsElapsed,
      'winMovesCount': winMovesCount,
      'puzzleSize': puzzleSize,
    };
  }

  static List<dynamic> toJsonList(List<Score> scores) =>
      List<dynamic>.from(scores.map((x) => x.toJson()));

  static List<Score> fromJsonList(dynamic scores) => List<Score>.from(
        json.decode(json.encode(scores)).map((x) => Score.fromJson(x)),
      );

  int get tilesCount => puzzleSize * puzzleSize - 1;

  /// Get the puzzle solved text based on score
  String get puzzleSolvedText =>
      'I just solved this $tilesCount-Tile Dashtronaut '
      'slide puzzle in ${DurationHelper.toFormattedTime(
        Duration(seconds: secondsElapsed),
      )} with $winMovesCount moves!';

  /// Get the puzzle solved text based on score for mobile
  String get puzzleSolvedTextMobile =>
      '$puzzleSolvedText \n\n${Constants.officialWebsiteUrl}';

  /// Get image of solved puzzle based on size
  ///
  /// There should be an image for each supported size
  /// in the puzzle [Puzzle.supportedPuzzleSizes]
  String get puzzleSolvedImageUrl => '${Constants.puzzleSolvedImagesUrlRoot}/'
      'solved-${puzzleSize}x$puzzleSize.png';

  String get twitterShareLink => '${Constants.twitterIntentUrl}?'
      'text=$puzzleSolvedText'
      '&url=${Constants.officialWebsiteUrl}';

  @override
  List<Object?> get props => [secondsElapsed, winMovesCount, puzzleSize];
}
