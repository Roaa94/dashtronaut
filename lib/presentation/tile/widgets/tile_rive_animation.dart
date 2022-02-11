import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TileRiveAnimation extends StatefulWidget {
  final bool isAtCorrectLocation;

  const TileRiveAnimation({this.isAtCorrectLocation = false, Key? key}) : super(key: key);

  @override
  _TileRiveAnimationState createState() => _TileRiveAnimationState();
}

class _TileRiveAnimationState extends State<TileRiveAnimation> {
  SMIBool? _isAtCorrectPositionSM;
  late RiveAnimationController tileRiveAnimationController;

  @override
  void initState() {
    tileRiveAnimationController = SimpleAnimation(
      'correctPosition',
      autoplay: false,
    );
    super.initState();
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'tile',
      // onStateChange: onTryStateChange,
    );

    artboard.addController(controller!);
    _isAtCorrectPositionSM = controller.findInput<bool>('isAtCorrectPosition') as SMIBool?;
  }

  @override
  void didUpdateWidget(covariant TileRiveAnimation oldWidget) {
    print('Is at correct location: ${widget.isAtCorrectLocation}');
    _isAtCorrectPositionSM?.value = widget.isAtCorrectLocation;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/rive/tile.riv',
      onInit: _onRiveInit,
      controllers: [tileRiveAnimationController],
    );
  }
}
