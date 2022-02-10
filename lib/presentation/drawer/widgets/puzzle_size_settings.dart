import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/presentation/drawer/widgets/puzzle_size_item.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';

class PuzzleSizeSettings extends StatelessWidget {
  const PuzzleSizeSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).orientation == Orientation.landscape && !kIsWeb
          ? EdgeInsets.only(left: MediaQuery.of(context).padding.left, top: 0, bottom: 20, right: 20)
          : const EdgeInsets.only(right: 20, left: 20, bottom: 20),
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
                  padding: EdgeInsetsDirectional.only(end: index < Puzzle.supportedPuzzleSizes.length - 1 ? 5 : 0, start: index > 0 ? 5 : 0),
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
