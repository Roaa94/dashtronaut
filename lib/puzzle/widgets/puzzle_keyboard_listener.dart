import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';

class PuzzleKeyboardListener extends ConsumerStatefulWidget {
  const PuzzleKeyboardListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<PuzzleKeyboardListener> createState() =>
      _PuzzleKeyboardListenerState();
}

class _PuzzleKeyboardListenerState
    extends ConsumerState<PuzzleKeyboardListener> {
  final FocusNode keyboardListenerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      onKey: (event) {
        ref.read(puzzleProvider.notifier).handleKeyboardEvent(event);
      },
      focusNode: keyboardListenerFocusNode,
      child: Builder(
        builder: (context) {
          if (!keyboardListenerFocusNode.hasFocus) {
            FocusScope.of(context).requestFocus(keyboardListenerFocusNode);
          }
          return widget.child;
        },
      ),
    );
  }
}
