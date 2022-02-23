enum PhraseState {
  none,
  puzzleStarted,
  puzzleSolved,
  hardPuzzleSelected,
  puzzleTakingTooLong,
  dashTapped,
}

class Phrase {
  final String text;
  final PhraseState state;

  const Phrase({
    required this.text,
    required this.state,
  });
}
