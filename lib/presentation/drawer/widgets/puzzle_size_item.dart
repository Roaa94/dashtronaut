import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_colors.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class PuzzleSizeItem extends StatelessWidget {
  final int size;

  const PuzzleSizeItem({required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<PuzzleProvider>(
          builder: (c, puzzleProvider, _) {
            bool _isSelected = puzzleProvider.n == size;
            return GestureDetector(
              onTap: _isSelected
                  ? null
                  : () {
                      puzzleProvider.resetPuzzleSize(size);
                      if (Scaffold.of(context).hasDrawer && Scaffold.of(context).isDrawerOpen) {
                        Navigator.of(context).pop();
                      }
                    },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(_isSelected ? 1 : 0.1),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    '$size x $size',
                    style: AppTextStyles.buttonSm.copyWith(color: _isSelected ? AppColors.primary : Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 5),
        Text('${(size * size) - 1} Tiles', style: AppTextStyles.bodyXxs),
      ],
    );
  }
}
