import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/background/background_helper.dart';

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> with AutomaticKeepAliveClientMixin {
  late AssetImage bgImage;
  List<AssetImage> backgroundLayers = [];

  @override
  void initState() {
    bgImage = const AssetImage('assets/images/background/bg.png');
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
        delegate: BackgroundFlowDelegate(screenSize: MediaQuery.of(context).size),
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

  BackgroundFlowDelegate({required this.screenSize});

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i <= BackgroundHelper.layerUrls.length - 1; i++) {
      context.paintChild(
        i,
        transform: BackgroundHelper.getLayers(screenSize)[i].transform,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
