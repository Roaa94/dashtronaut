import 'package:dashtronaut/dash/phrases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashTapCountProvider = NotifierProvider<DashTapCountNotifier, int>(
  () => DashTapCountNotifier(),
);

class DashTapCountNotifier extends Notifier<int> {
  @override
  int build() => -1;

  final int maxDashTaps = Phrases.dashTappedPhrases.length - 1;

  increment() {
    if (state == maxDashTaps) {
      state = 0;
    }
    state = state + 1;
  }
}
