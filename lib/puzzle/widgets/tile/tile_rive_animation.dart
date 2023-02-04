import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TileRiveAnimation extends StatefulWidget {
  final bool isAtCorrectLocation;
  final bool isPuzzleSolved;

  const TileRiveAnimation({
    this.isAtCorrectLocation = false,
    this.isPuzzleSolved = false,
    super.key,
  });

  @override
  _TileRiveAnimationState createState() => _TileRiveAnimationState();
}

class _TileRiveAnimationState extends State<TileRiveAnimation> {
  SMIBool? _isAtCorrectPositionSM;
  SMIBool? _isPuzzleSolvedSM;
  late RiveAnimationController correctPositionAnimationController;
  late RiveAnimationController nonCorrectPositionAnimationController;

  @override
  void initState() {
    correctPositionAnimationController =
        OneShotAnimation('correctPosition', autoplay: false);
    nonCorrectPositionAnimationController =
        OneShotAnimation('nonCorrectPosition', autoplay: false);
    super.initState();
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'tile',
      // onStateChange: onTryStateChange,
    );

    artboard.addController(controller!);
    _isAtCorrectPositionSM =
        controller.findInput<bool>('isAtCorrectPosition') as SMIBool?;
    _isPuzzleSolvedSM =
        controller.findInput<bool>('isPuzzleSolved') as SMIBool?;
    _isAtCorrectPositionSM?.value = widget.isAtCorrectLocation;
    _isPuzzleSolvedSM?.value = widget.isPuzzleSolved;
  }

  @override
  void didUpdateWidget(covariant TileRiveAnimation oldWidget) {
    _isAtCorrectPositionSM?.value = widget.isAtCorrectLocation;
    _isPuzzleSolvedSM?.value = widget.isPuzzleSolved;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/rive/tile.riv',
      onInit: _onRiveInit,
      stateMachines: const ['tile'],
      controllers: [
        correctPositionAnimationController,
        nonCorrectPositionAnimationController
      ],
    );
  }
}
