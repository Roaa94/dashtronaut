import 'package:flutter_riverpod/flutter_riverpod.dart';

final stopWatchProvider = StreamProvider((ref) {
  return Stream.periodic(const Duration(seconds: 1), (x) => 1 + x++);
});