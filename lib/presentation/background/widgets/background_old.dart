// import 'package:flutter/material.dart';
// import 'package:Dashtronaut/models/background.dart';
// import 'package:Dashtronaut/models/position.dart';
// import 'package:Dashtronaut/models/vector.dart';
//
// class BackgroundOld extends StatefulWidget {
//   const BackgroundOld({Key? key}) : super(key: key);
//
//   @override
//   _BackgroundOldState createState() => _BackgroundOldState();
// }
//
// class _BackgroundOldState extends State<BackgroundOld> {
//   late AssetImage bgImage;
//   List<AssetImage> backgroundLayers = [];
//   Vector gyroscopeVector = Vector.zero();
//
//   @override
//   void initState() {
//     bgImage = const AssetImage('assets/images/background/bg.png');
//     // gyroscopeEvents.listen((GyroscopeEvent event) {
//     // print(event);
//     // if (gyroscopeVector.greaterThan(Vector.fromGyroscopeEvent(event))) {
//     //   setState(() {
//     //     gyroscopeVector = Vector.fromGyroscopeEvent(event);
//     //   });
//     //   print(gyroscopeVector);
//     // }
//     // });
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     precacheImage(bgImage, context);
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(image: bgImage),
//       ),
//       width: screenSize.width,
//       height: double.infinity,
//       alignment: Alignment.topLeft,
//       // child: Center(
//       //   child: Transform(
//       //     origin: Offset(50, 50),
//       //     transform: Matrix4.translationValues(gyroscopeVector.y * 10, gyroscopeVector.x * 10, 0),
//       //       // ..rotateX(gyroscopeVector.x)
//       //       // ..rotateY(gyroscopeVector.y)
//       //       // ..rotateZ(gyroscopeVector.z),
//       //     child: Container(
//       //       width: 100,
//       //       height: 100,
//       //       color: Colors.red,
//       //     ),
//       //   ),
//       // ),
//       child: Stack(
//         children: List.generate(
//           Background.layerUrls.length,
//           (i) {
//             int inverseIndex = Background.layerUrls.length - i;
//             Position initialLayerPosition = Background.getLayers(screenSize)[i].position;
//             Position dynamicLayerPosition = Position(
//               left: initialLayerPosition.left + gyroscopeVector.y * inverseIndex,
//               top: initialLayerPosition.top + gyroscopeVector.x * inverseIndex,
//             );
//
//             return AnimatedPositioned(
//               duration: const Duration(milliseconds: 100),
//               left: dynamicLayerPosition.left,
//               top: dynamicLayerPosition.top,
//               child: Image.asset(
//                 Background.layerUrls[i],
//                 width: screenSize.width,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
