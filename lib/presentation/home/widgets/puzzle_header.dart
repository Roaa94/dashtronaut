import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/animations/widgets/fade_in_transition.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';

class PuzzleHeader extends StatelessWidget {
  const PuzzleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInTransition(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Dashtronaut', style: AppTextStyles.title),
            SizedBox(height: 5),
            Text(
              'Solve This Slide Puzzle..',
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }
}
