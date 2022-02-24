enum PhraseState {
  none,
  puzzleStarted,
  puzzleSolved,
  hardPuzzleSelected,
  puzzleTakingTooLong,
  dashTapped,
  doingGreat,
}

class Phrase {
  final String text;
  final PhraseState state;

  const Phrase({
    required this.text,
    required this.state,
  });
}
