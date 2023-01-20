import 'package:dashtronaut/phrases/widgets/phrase_bubble.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/presentation/layout/phrase_bubble_layout.dart';
import 'package:dashtronaut/phrases/providers/phrases_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedPhraseBubble extends StatefulWidget {
  const AnimatedPhraseBubble({Key? key}) : super(key: key);

  @override
  State<AnimatedPhraseBubble> createState() => _AnimatedPhraseBubbleState();
}

class _AnimatedPhraseBubbleState extends State<AnimatedPhraseBubble>
    with SingleTickerProviderStateMixin {
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
    PhraseBubbleLayout phraseBubbleLayout = PhraseBubbleLayout(context);

    return Positioned(
      right: phraseBubbleLayout.position.right,
      bottom: phraseBubbleLayout.position.bottom,
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
                AnimationsManager.phraseBubble.duration +
                    AnimationsManager.phraseBubbleHoldAnimationDuration,
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
