import 'package:Dashtronaut/helpers/background_helper.dart';
import 'package:Dashtronaut/presentation/layout/background_layer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BackgroundHelper', () {
    BackgroundHelper.backgroundLayerTypes = [
      BackgroundLayerType.topBgPlanet,
      BackgroundLayerType.topRightPlanet,
    ];

    testWidgets('getLayers returned list length equals backgroundLayerTypes list length', (WidgetTester tester) async {
      await tester.pumpWidget(
        Builder(builder: (BuildContext context) {
          final List<BackgroundLayerLayout> _backgroundLayers = BackgroundHelper.getLayers(context);

          expect(_backgroundLayers.length, BackgroundHelper.backgroundLayerTypes.length);

          return const Placeholder();
        }),
      );
    });
  });
}
