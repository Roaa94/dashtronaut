import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/providers/stop_watch_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack/presentation/ui-helpers/duration_helper.dart';
import 'package:provider/provider.dart';

class PuzzleStopWatch extends StatelessWidget {
  const PuzzleStopWatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StopWatchProvider>(
      builder: (c, stopWatchProvider, _) {
        Duration _duration = Duration(seconds: stopWatchProvider.secondsElapsed);

        return Text(
          DurationHelper.toFormattedTime(_duration),
          style: AppTextStyles.bodyBold,
        );
      },
    );
  }
}
