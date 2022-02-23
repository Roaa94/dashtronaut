import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/data/models/phrase.dart';
import 'package:flutter_puzzle_hack/presentation/providers/phrases_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_colors.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';

class PhraseBubble extends StatelessWidget {
  final PhraseState state;

  const PhraseBubble({
    Key? key,
    required this.state,
  })  : assert(state != PhraseState.none),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String randomPhrase = PhrasesProvider.getPhrase(state);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -12,
          top: -4,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          right: -21,
          top: -8,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: AppColors.primary),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: UI.spaceMd, vertical: UI.space),
          constraints: const BoxConstraints(
            maxWidth: 220,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: AppColors.primary),
          ),
          child: Text(
            randomPhrase,
            style: AppTextStyles.h2.copyWith(
              color: AppColors.primary,
              fontSize: randomPhrase.length > 20 ? 16 : 20,
            ),
          ),
        ),
      ],
    );
  }
}
