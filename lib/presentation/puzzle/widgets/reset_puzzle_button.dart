import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class ResetPuzzleButton extends StatelessWidget {
  const ResetPuzzleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PuzzleProvider puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => puzzleProvider.generate(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.2), blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.refresh),
            SizedBox(width: 7),
            Text('Reset', style: AppTextStyles.button),
          ],
        ),
      ),
    );
  }
}
