import 'dart:convert';

class Score {
  final int secondsElapsed;
  final int movesCount;
  final int puzzleSize;

  const Score({
    required this.secondsElapsed,
    required this.movesCount,
    required this.puzzleSize,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      secondsElapsed: json['secondsElapsed'],
      movesCount: json['movesCount'],
      puzzleSize: json['puzzleSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secondsElapsed': secondsElapsed,
      'movesCount': movesCount,
      'puzzleSize': puzzleSize,
    };
  }

  static List<dynamic> toJsonList(List<Score> scores) => List<dynamic>.from(scores.map((x) => x.toJson()));

  static List<Score> fromJsonList(dynamic scores) => List<Score>.from(json.decode(json.encode(scores)).map((x) => Score.fromJson(x)));
}
