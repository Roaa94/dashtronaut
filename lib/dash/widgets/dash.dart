import 'package:dashtronaut/dash/phrases.dart';
import 'package:dashtronaut/dash/providers/dash_tap_count_provider.dart';
import 'package:dashtronaut/dash/providers/phrases_provider.dart';
import 'package:dashtronaut/dash/widgets/animated_phrase_bubble.dart';
import 'package:dashtronaut/dash/widgets/dash_rive_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dash extends ConsumerWidget {
  const Dash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phraseStatus = ref.watch(phraseStatusProvider);
    final dashTapCount = ref.watch(dashTapCountProvider);

    return Stack(
      children: [
        DashRiveAnimation(
          onDashTapped: () {
            ref.read(dashTapCountProvider.notifier).increment();
            ref.read(phraseStatusProvider.notifier).state = PhraseStatus.dashTapped;
            HapticFeedback.lightImpact();
          },
        ),
        AnimatedPhraseBubble(
          phraseStatus: phraseStatus,
          dashTapCount: dashTapCount,
        ),
      ],
    );
  }
}
