import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/layout/dash_layout.dart';
import 'package:dashtronaut/core/layout/phrase_bubble_layout.dart';
import 'package:dashtronaut/phrases/providers/phrases_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class DashRiveAnimation extends StatefulWidget {
  const DashRiveAnimation({Key? key}) : super(key: key);

  @override
  _DashRiveAnimationState createState() => _DashRiveAnimationState();
}

class _DashRiveAnimationState extends State<DashRiveAnimation> {
  late final PhrasesProvider phrasesProvider;

  final ValueNotifier<bool> canTapDashNotifier = ValueNotifier<bool>(true);

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'dashtronaut');

    artboard.addController(controller!);
  }

  @override
  void initState() {
    phrasesProvider = Provider.of<PhrasesProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DashLayout dash = DashLayout(context);

    return Positioned(
      right: dash.position.right,
      bottom: dash.position.bottom,
      child: ValueListenableBuilder(
        valueListenable: canTapDashNotifier,
        child: SizedBox(
          width: dash.size.width,
          height: dash.size.height,
          child: RiveAnimation.asset(
            'assets/rive/dashtronaut.riv',
            onInit: _onRiveInit,
            stateMachines: const ['dashtronaut'],
          ),
        ),
        builder: (c, bool canTapDash, child) => GestureDetector(
          onTap: () {
            if (canTapDash) {
              canTapDashNotifier.value = false;
              phrasesProvider.setPhraseState(PhraseState.dashTapped);
              HapticFeedback.lightImpact();
              Future.delayed(
                  AnimationsManager.phraseBubbleTotalAnimationDuration, () {
                phrasesProvider.setPhraseState(PhraseState.none);
                canTapDashNotifier.value = true;
              });
            }
          },
          child: child,
        ),
      ),
    );
  }
}
