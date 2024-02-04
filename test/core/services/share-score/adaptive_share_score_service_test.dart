import 'package:dashtronaut/core/services/share-score/file_share_service.dart';
import 'package:dashtronaut/core/services/share-score/share_score_service.dart';
import 'package:dashtronaut/core/services/share-score/url_service.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late UrlService mockUrlService;
  late FileShareService mockFileShareService;

  const score = Score(secondsElapsed: 20, winMovesCount: 10, puzzleSize: 3);

  setUp(() {
    mockUrlService = MockUrlService();
    mockFileShareService = MockFileShareService();
  });

  test(
    'share method calls urlService.openLink for web platform',
    () async {
      when(() => mockUrlService.openLink(score.twitterShareLink))
          .thenAnswer((_) async {});

      final adaptiveShareService = AdaptiveShareScoreService(
        score,
        isWeb: true,
        urlLauncherService: mockUrlService,
        fileShareService: mockFileShareService,
      );

      await adaptiveShareService.share();

      verify(() => mockUrlService.openLink(score.twitterShareLink)).called(1);
    },
  );

  test(
    'urlService.openLink error is caught when it throws',
    () async {
      when(() => mockUrlService.openLink(score.twitterShareLink))
          .thenThrow('An Error Occurred!');

      final adaptiveShareService = AdaptiveShareScoreService(
        score,
        isWeb: true,
        urlLauncherService: mockUrlService,
        fileShareService: mockFileShareService,
      );

      expect(adaptiveShareService.share(), completes);
    },
  );

  test(
    'share method calls fileShareService.share for non web platform',
    () async {
      when(
        () => mockFileShareService.shareFileFromUrl(
          url: score.puzzleSolvedImageUrl,
          shareText: score.puzzleSolvedTextMobile,
        ),
      ).thenAnswer((_) async {});

      final adaptiveShareService = AdaptiveShareScoreService(
        score,
        isWeb: false,
        urlLauncherService: mockUrlService,
        fileShareService: mockFileShareService,
      );

      await adaptiveShareService.share();

      verify(
        () => mockFileShareService.shareFileFromUrl(
          url: score.puzzleSolvedImageUrl,
          shareText: score.puzzleSolvedTextMobile,
        ),
      ).called(1);
    },
  );

  test(
    'share method calls urlService.openLink for non web platform'
    ' if fileShareService.share throws',
    () async {
      when(() => mockUrlService.openLink(score.twitterShareLink))
          .thenAnswer((_) async {});

      when(
        () => mockFileShareService.shareFileFromUrl(
          url: score.puzzleSolvedImageUrl,
          shareText: score.puzzleSolvedTextMobile,
        ),
      ).thenThrow('An Error Occurred!');

      final adaptiveShareService = AdaptiveShareScoreService(
        score,
        isWeb: false,
        urlLauncherService: mockUrlService,
        fileShareService: mockFileShareService,
      );

      await adaptiveShareService.share();

      verify(() => mockUrlService.openLink(score.twitterShareLink)).called(1);
    },
  );
}
