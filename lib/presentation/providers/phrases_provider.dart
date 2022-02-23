import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/data/models/phrase.dart';

class PhrasesProvider with ChangeNotifier {
  static const List<String> puzzleStartedPhrases = [
    'Good luck!',
    'You can do it!',
    'I believe in you!',
  ];

  static const List<String> doingGreatPhrases = [
    'Keep going!',
    'You\'r doing great!',
    'Not much left!',
  ];

  static const List<String> puzzleSolvedPhrases = [
    'You Are AMAZING!',
    'You Are AWESOME!',
    'Wow! You Did It!',
  ];

  static const List<String> hardPuzzlePhrases = [
    'You sure you can handle all of that?!',
    'WOW! That\'s not easy!',
    'Easy is boring 😉',
  ];

  static const List<String> puzzleTakingTooLongPhrases = [
    'This is taking too long!',
    'Don\'t lose hope',
    'Better late than never',
  ];

  static const List<String> dashTappedPhrases = [
    'Hi! I\'m Dash',
    'Dash the Astronaut',
    'So you can call me Dashtronaut',
    'You can stop poking me now',
    'Why don\'t you play with the puzzle instead???',
    'No really, stop please',
    'You\'re starting to annoy me!',
    'Argh! Never mind!',
    'You\'ll probably keep doing this 😒',
    'I can start over you know!!',
  ];

  static final Random random = Random();

  static int maxDashTaps = dashTappedPhrases.length - 1;

  int dashTapCount = -1;

  String getPhrase(PhraseState phraseState) {
    assert(phraseState != PhraseState.none);
    switch (phraseState) {
      case PhraseState.puzzleStarted:
        return puzzleStartedPhrases[random.nextInt(puzzleSolvedPhrases.length - 1)];
      case PhraseState.puzzleSolved:
        return puzzleSolvedPhrases[random.nextInt(puzzleSolvedPhrases.length - 1)];
      case PhraseState.hardPuzzleSelected:
        return hardPuzzlePhrases[random.nextInt(hardPuzzlePhrases.length - 1)];
      case PhraseState.doingGreat:
        return doingGreatPhrases[random.nextInt(doingGreatPhrases.length - 1)];
      case PhraseState.dashTapped:
        return dashTappedPhrases[dashTapCount];
      default:
        return '';
    }
  }

  PhraseState phraseState = PhraseState.none;

  void setPhraseState(PhraseState _phraseState) {
    phraseState = _phraseState;
    if (_phraseState == PhraseState.dashTapped) {
      if (dashTapCount == maxDashTaps) {
        dashTapCount = 0;
      } else {
        dashTapCount++;
      }
    }
    notifyListeners();
  }
}
