class Configs {
  Configs({
    this.supportedPuzzleSizes = const [3, 4, 5, 6],
    this.maxStorableScores = 10,
  });

  final List<int> supportedPuzzleSizes;

  int get defaultPuzzleSize => supportedPuzzleSizes[1];

  final int maxStorableScores;
}
