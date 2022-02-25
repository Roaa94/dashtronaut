import 'package:Dashtronaut/helpers/share_score_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const int puzzleSize = 3;
  int tilesCount = 8;
  const int movesCount = 55;
  const Duration duration = Duration(seconds: 500);
  String officialWebsiteUrl = 'https://dashtronaut.app';

  group('ShareScoreHelper', () {
    test('Gets ${puzzleSize}x$puzzleSize solved puzzle image', () {
      String imageUrl = ShareScoreHelper.getPuzzleSolvedImageUrl(puzzleSize);

      expect(imageUrl, '${ShareScoreHelper.puzzleSolvedImagesUrlRoot}/solved-3x3.png');
    });

    test('Gets solved puzzle text with 55 moves and 08:20', () {
      String puzzleSolvedText = ShareScoreHelper.getPuzzleSolvedText(movesCount, duration, tilesCount);

      expect(
        puzzleSolvedText,
        'I just solved this $tilesCount-Tile Dashtronaut slide puzzle in 08:20 with 55 moves!',
      );
    });

    test('Gets solved puzzle text with 55 moves and 08:20 with website link', () {
      String puzzleSolvedTextMobile = ShareScoreHelper.getPuzzleSolvedTextMobile(movesCount, duration, tilesCount);

      expect(
        puzzleSolvedTextMobile,
        'I just solved this 8-Tile Dashtronaut slide puzzle in 08:20 with 55 moves! \n\n$officialWebsiteUrl',
      );
    });

    test('Gets solved puzzle Twitter intent link with 55 moves and 08:20', () {
      String twitterShareLink = ShareScoreHelper.getTwitterShareLink(movesCount, duration, tilesCount);

      expect(
        twitterShareLink,
        'https://twitter.com/intent/tweet?text=I just solved this 8-Tile Dashtronaut slide puzzle in 08:20 with 55 moves!&url=$officialWebsiteUrl',
      );
    });
  });
}
