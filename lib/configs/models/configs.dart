class Configs {
  Configs({
    this.supportedPuzzleSizes = const [3, 4, 5, 6],
    this.maxStorableScores = 10,
  });

  final List<int> supportedPuzzleSizes;

  final int maxStorableScores;
}
