import 'dart:convert';

import 'package:dashtronaut/core/models/model.dart';

class Score extends Model {
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

  @override
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

  @override
  List<Object?> get props => [secondsElapsed, winMovesCount, puzzleSize];
}
