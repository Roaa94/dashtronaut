import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/vector.dart';
import 'package:flutter_puzzle_hack/presentation/background/background_helper.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late AssetImage bgImage;
  List<AssetImage> backgroundLayers = [];
  Vector? gyroscopeVector;

  @override
  void initState() {
    bgImage = const AssetImage('assets/images/background/bg.png');
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (gyroscopeVector == null) {
        gyroscopeVector = Vector.fromGyroscopeEvent(event);
        print(gyroscopeVector);
      } else {
        if (gyroscopeVector!.greaterThan(Vector.fromGyroscopeEvent(event))) {
          setState(() {
            gyroscopeVector = Vector.fromGyroscopeEvent(event);
          });
          // print(gyroscopeVector);
        }
      }
      // print(event);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(bgImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: bgImage),
      ),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.topLeft,
      child: Flow(
        delegate: BackgroundFlowDelegate(screenSize: MediaQuery.of(context).size, gyroscopeVector: gyroscopeVector ?? Vector.zero()),
        children: List.generate(
          BackgroundHelper.layerUrls.length,
          (index) => Image.asset(
            BackgroundHelper.layerUrls[index],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BackgroundFlowDelegate extends FlowDelegate {
  final Size screenSize;
  final Vector gyroscopeVector;

  BackgroundFlowDelegate({
    required this.screenSize,
    required this.gyroscopeVector,
  });

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i <= context.childCount - 1; i++) {
      Vector layerVector = BackgroundHelper.getLayers(screenSize)[i].vector;
      Vector dynamicLayerVector = Vector(
        layerVector.x + (gyroscopeVector.x * i),
        layerVector.y + (gyroscopeVector.y * i),
        layerVector.z,
      );
      print(dynamicLayerVector);
      context.paintChild(
        i,
        transform: dynamicLayerVector.transform,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }
}
