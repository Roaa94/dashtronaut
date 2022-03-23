import 'package:Dashtronaut/models/puzzle.dart';
import 'package:Dashtronaut/presentation/drawer/puzzle_size_item.dart';
import 'package:Dashtronaut/presentation/layout/spacing.dart';
import 'package:Dashtronaut/presentation/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class PuzzleSizeSettings extends StatelessWidget {
  const PuzzleSizeSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double drawerStartPadding = MediaQuery.of(context).padding.left == 0
        ? Spacing.md
        : MediaQuery.of(context).padding.left;

    return Container(
      padding: EdgeInsets.only(
          right: Spacing.md, left: drawerStartPadding, bottom: Spacing.md),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Puzzle Size', style: AppTextStyles.h2),
          const SizedBox(height: 5),
          const Text('Select the size of your puzzle'),
          const SizedBox(height: 2),
          Text(
            '(This will reset your progress!)',
            style: AppTextStyles.bodyXs.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
              Puzzle.supportedPuzzleSizes.length,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: index < Puzzle.supportedPuzzleSizes.length - 1
                        ? Spacing.xs / 2
                        : 0,
                    start: index > 0 ? Spacing.xs / 2 : 0,
                  ),
                  child: PuzzleSizeItem(
                    size: Puzzle.supportedPuzzleSizes[index],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
