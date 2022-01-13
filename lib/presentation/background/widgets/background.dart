import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> with AutomaticKeepAliveClientMixin {
  late AssetImage bgImage;

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
      child: Flow(
        delegate: BackgroundFlowDelegate(),
        children: [],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BackgroundFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
