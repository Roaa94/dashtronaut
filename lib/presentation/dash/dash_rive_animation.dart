import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/dash.dart';
import 'package:rive/rive.dart';

class DashRiveAnimation extends StatefulWidget {
  const DashRiveAnimation({Key? key}) : super(key: key);

  @override
  _DashRiveAnimationState createState() => _DashRiveAnimationState();
}

class _DashRiveAnimationState extends State<DashRiveAnimation> {
  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'dashtronaut',
      // onStateChange: onTryStateChange,
    );

    artboard.addController(controller!);
  }

  @override
  Widget build(BuildContext context) {
    Dash _dash = Dash(context);

    return Positioned(
      right: _dash.position.right,
      bottom: _dash.position.bottom,
      child: SizedBox(
        width: _dash.size.width,
        height: _dash.size.height,
        child: RiveAnimation.asset(
          'assets/rive/dashtronaut.riv',
          onInit: _onRiveInit,
          stateMachines: const ['dashtronaut'],
        ),
      ),
    );
  }
}
