import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/data/models/phrase.dart';

class PhrasesProvider with ChangeNotifier {
  static const List<String> puzzleStartedPhrases = [
    'Good luck!',
    'You can do it!',
    'I believe in you!',
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

  static final Random random = Random();

  static String getPhrase(PhraseState phraseState) {
    assert(phraseState != PhraseState.none);
    switch (phraseState) {
      case PhraseState.puzzleStarted:
        return puzzleStartedPhrases[random.nextInt(puzzleSolvedPhrases.length - 1)];
      case PhraseState.puzzleSolved:
        return puzzleSolvedPhrases[random.nextInt(puzzleSolvedPhrases.length - 1)];
      case PhraseState.hardPuzzleSelected:
        return hardPuzzlePhrases[random.nextInt(puzzleSolvedPhrases.length - 1)];
      default:
        return '';
    }
  }

  PhraseState phraseState = PhraseState.none;

  void setPhraseState(PhraseState _phraseState) {
    phraseState = _phraseState;
    notifyListeners();
  }
}
