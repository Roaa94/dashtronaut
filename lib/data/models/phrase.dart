enum PhraseState {
  none,
  puzzleStarted,
  puzzleSolved,
  hardPuzzleSelected,
}

class Phrase {
  final String text;
  final PhraseState state;

  const Phrase({
    required this.text,
    required this.state,
  });
}
