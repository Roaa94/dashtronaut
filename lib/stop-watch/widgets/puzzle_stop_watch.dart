import 'package:dashtronaut/core/helpers/duration_helper.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/stop-watch/providers/stop_watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleStopWatch extends ConsumerWidget {
  const PuzzleStopWatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Duration duration = Duration(
      seconds: ref.watch(stopWatchProvider),
    );

    return Text(
      DurationHelper.toFormattedTime(duration),
      style: AppTextStyles.bodyBold,
    );
  }
}
