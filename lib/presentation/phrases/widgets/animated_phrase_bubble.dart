import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/phrase.dart';
import 'package:flutter_puzzle_hack/data/models/phrase_bubble_layout.dart';
import 'package:flutter_puzzle_hack/presentation/animations/utils/animations_manager.dart';
import 'package:flutter_puzzle_hack/presentation/phrases/widgets/phrase_bubble.dart';
import 'package:flutter_puzzle_hack/presentation/providers/phrases_provider.dart';
import 'package:provider/provider.dart';

class AnimatedPhraseBubble extends StatefulWidget {
  const AnimatedPhraseBubble({Key? key}) : super(key: key);

  @override
  State<AnimatedPhraseBubble> createState() => _AnimatedPhraseBubbleState();
}

class _AnimatedPhraseBubbleState extends State<AnimatedPhraseBubble> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.phraseBubble.duration,
    );
    _scale = AnimationsManager.phraseBubble.tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AnimationsManager.phraseBubble.curve,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PhraseBubbleLayout _phraseBubbleLayout = PhraseBubbleLayout(context);

    return Positioned(
      right: _phraseBubbleLayout.position.right,
      bottom: _phraseBubbleLayout.position.bottom,
      child: ScaleTransition(
        scale: _scale,
        alignment: Alignment.topRight,
        child: Consumer<PhrasesProvider>(
          builder: (c, phrasesProvider, child) {
            if (phrasesProvider.phraseState == PhraseState.none) {
              return Container();
            } else {
              _animationController.forward();
              Future.delayed(
                AnimationsManager.phraseBubble.duration + AnimationsManager.phraseBubbleHoldAnimationDuration,
                () {
                  _animationController.reverse();
                },
              );
              return PhraseBubble(state: phrasesProvider.phraseState);
            }
          },
        ),
      ),
    );
  }
}
