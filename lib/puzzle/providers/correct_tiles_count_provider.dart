import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final correctTilesCountProvider = Provider<int>((ref) {
  return ref.watch(
    puzzleProvider.select((state) => state.correctTilesCount),
  );
});
