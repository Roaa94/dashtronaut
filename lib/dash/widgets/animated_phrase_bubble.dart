import 'dart:math';

import 'package:dashtronaut/dash/phrases.dart';
import 'package:dashtronaut/dash/widgets/phrase_bubble.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/layout/phrase_bubble_layout.dart';
import 'package:flutter/material.dart';

class AnimatedPhraseBubble extends StatefulWidget {
  const AnimatedPhraseBubble({
    super.key,
    required this.phraseStatus,
    this.dashTapCount = 0,
    this.random,
  });

  final PhraseStatus phraseStatus;
  final int dashTapCount;
  final Random? random;

  @override
  State<AnimatedPhraseBubble> createState() => _AnimatedPhraseBubbleState();
}

class _AnimatedPhraseBubbleState extends State<AnimatedPhraseBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleUp;
  late final Animation<double> _scaleDown;

  late String text;
  late final Random random;

  @override
  void initState() {
    random = widget.random ?? Random();
    text = widget.phraseStatus.getText(
      random,
      widget.dashTapCount,
    );

    _animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.phraseBubbleTotalAnimationDuration,
    );

    _scaleUp = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.3, curve: Curves.easeOutBack),
      ),
    );

    _scaleDown = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1, curve: Curves.easeInBack),
      ),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedPhraseBubble oldWidget) {
    if ((oldWidget.phraseStatus != widget.phraseStatus ||
            (widget.phraseStatus == PhraseStatus.dashTapped &&
                oldWidget.dashTapCount != widget.dashTapCount)) &&
        widget.phraseStatus != PhraseStatus.none) {
      text = widget.phraseStatus.getText(
        random,
        widget.dashTapCount,
      );

      if (_animationController.isAnimating ||
          _animationController.isCompleted) {
        _animationController.reset();
      }
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PhraseBubbleLayout phraseBubbleLayout = PhraseBubbleLayout(context);

    return Positioned(
      right: phraseBubbleLayout.position.right,
      bottom: phraseBubbleLayout.position.bottom,
      child: ScaleTransition(
        scale: _scaleUp,
        alignment: Alignment.topRight,
        child: ScaleTransition(
          scale: _scaleDown,
          alignment: Alignment.topRight,
          child: PhraseBubble(
            text: text,
          ),
        ),
      ),
    );
  }
}
