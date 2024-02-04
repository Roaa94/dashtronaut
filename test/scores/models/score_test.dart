import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const int puzzleSize = 3;
  int tilesCount = 8;
  const int movesCount = 55;
  const Duration duration = Duration(seconds: 500);
  String officialWebsiteUrl = 'https://dashtronaut.app';

  final score = Score(
    secondsElapsed: duration.inSeconds,
    winMovesCount: movesCount,
    puzzleSize: puzzleSize,
  );

  test('Gets ${puzzleSize}x$puzzleSize solved puzzle image', () {
    expect(
      score.puzzleSolvedImageUrl,
      '${Constants.puzzleSolvedImagesUrlRoot}/solved-3x3.png',
    );
  });

  test('Gets solved puzzle text with 55 moves and 08:20', () {
    expect(
      score.puzzleSolvedText,
      'I just solved this $tilesCount-Tile Dashtronaut slide puzzle in 08:20 with 55 moves!',
    );
  });

  test('Gets solved puzzle text with 55 moves and 08:20 with website link', () {
    expect(
      score.puzzleSolvedTextMobile,
      'I just solved this 8-Tile Dashtronaut slide puzzle in 08:20 with 55 moves! \n\n$officialWebsiteUrl',
    );
  });

  test('Gets solved puzzle Twitter intent link with 55 moves and 08:20', () {
    expect(
      score.twitterShareLink,
      'https://twitter.com/intent/tweet?text=I just solved this 8-Tile Dashtronaut slide puzzle in 08:20 with 55 moves!&url=$officialWebsiteUrl',
    );
  });
}
