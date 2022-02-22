import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/providers/stop_watch_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class PuzzleStopWatch extends StatelessWidget {
  const PuzzleStopWatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    return Consumer<StopWatchProvider>(
      builder: (c, stopWatchProvider, _) {
        Duration _duration = Duration(seconds: stopWatchProvider.secondsElapsed);
        final String minutes = twoDigits(_duration.inMinutes.remainder(60));
        final String seconds = twoDigits(_duration.inSeconds.remainder(60));

        return Text(
          '$minutes:$seconds',
          style: AppTextStyles.bodyBold,
        );
      },
    );
  }
}
