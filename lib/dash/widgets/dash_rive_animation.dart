import 'package:dashtronaut/core/layout/dash_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

class DashRiveAnimation extends ConsumerStatefulWidget {
  const DashRiveAnimation({
    super.key,
    this.onDashTapped,
  });

  final VoidCallback? onDashTapped;

  @override
  _DashRiveAnimationState createState() => _DashRiveAnimationState();
}

class _DashRiveAnimationState extends ConsumerState<DashRiveAnimation> {
  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'dashtronaut');

    artboard.addController(controller!);
  }

  @override
  Widget build(BuildContext context) {
    DashLayout dash = DashLayout(context);

    return Positioned(
      right: dash.position.right,
      bottom: dash.position.bottom,
      child: GestureDetector(
        onTap: widget.onDashTapped,
        child: SizedBox(
          width: dash.size.width,
          height: dash.size.height,
          child: RiveAnimation.asset(
            'assets/rive/dashtronaut.riv',
            onInit: _onRiveInit,
            stateMachines: const ['dashtronaut'],
          ),
        ),
      ),
    );
  }
}
