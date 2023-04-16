import 'dart:math';

enum PhraseStatus {
  none,
  puzzleStarted,
  puzzleSolved,
  hardPuzzleSelected,
  puzzleTakingTooLong,
  dashTapped,
  doingGreat;

  String getText(Random random, [int? dashTapCount]) {
    if (this == PhraseStatus.dashTapped &&
        dashTapCount != null &&
        dashTapCount >= 0) {
      return Phrases.dashTappedPhrases[dashTapCount];
    }
    switch (this) {
      case PhraseStatus.puzzleStarted:
        return Phrases.puzzleStartedPhrases[
            random.nextInt(Phrases.puzzleStartedPhrases.length - 1)];
      case PhraseStatus.puzzleSolved:
        return Phrases.puzzleSolvedPhrases[
            random.nextInt(Phrases.puzzleSolvedPhrases.length - 1)];
      case PhraseStatus.hardPuzzleSelected:
        return Phrases.hardPuzzlePhrases[
            random.nextInt(Phrases.hardPuzzlePhrases.length - 1)];
      case PhraseStatus.doingGreat:
        return Phrases.doingGreatPhrases[
            random.nextInt(Phrases.doingGreatPhrases.length - 1)];
      case PhraseStatus.none:
      default:
        return '';
    }
  }
}

class Phrases {
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
    'The mascot for Flutter 💙 & Dart',
    'Which is what this app is built with!',
    'And I\'m an astronaut here',
    'So you can call me Dashtronaut 🚀',
    'You can stop poking me now 😃',
    'Why don\'t you play with the puzzle instead???',
    'You\'re starting to annoy me!',
    'Argh! Never mind!',
    'You\'ll probably keep doing this 😒',
    'I can start over you know!!',
    'Hi! I\'m Dash',
    'Nah I didn\'t start over',
    'Now I will...',
    'Hi! I\'m Dash',
    'Still didn\'t',
  ];
}
