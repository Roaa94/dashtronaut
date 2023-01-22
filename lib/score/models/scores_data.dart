import 'package:dashtronaut/core/models/model.dart';
import 'package:dashtronaut/score/models/score.dart';

class ScoresData extends Model {
  const ScoresData({
    this.scores = const [],
  });

  final List<Score> scores;

  @override
  List<Object?> get props => [scores];

  @override
  Map<String, dynamic> toJson() => {
        'scores': Score.toJsonList(scores),
      };

  factory ScoresData.fromJsom(Map<String, dynamic> json) {
    return ScoresData(
      scores: Score.fromJsonList(json['scores']),
    );
  }

  ScoresData copyWith({List<Score>? scores}) {
    return ScoresData(scores: scores ?? this.scores);
  }
}
