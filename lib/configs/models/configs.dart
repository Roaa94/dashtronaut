class Configs {
  const Configs({
    this.supportedPuzzleSizes = const [3, 4, 5, 6],
    this.maxStorableScores = 10,
    this.defaultPuzzleSize = 4,
  });

  final List<int> supportedPuzzleSizes;

  final int defaultPuzzleSize;

  final int maxStorableScores;
}
