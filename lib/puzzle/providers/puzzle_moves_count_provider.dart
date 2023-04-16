import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final puzzleMovesCountProvider = Provider<int>((ref) {
  return ref.watch(puzzleProvider.select((value) => value.movesCount));
});
