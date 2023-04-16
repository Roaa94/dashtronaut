import 'package:dashtronaut/puzzle/widgets/tile/tile_rive_animation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/pump_app.dart';

void main() {
  testWidgets(
    '',
    (WidgetTester tester) async {
      // Todo: add golden test
      await tester.pumpProviderApp(
        const TileRiveAnimation(),
      );
    },
  );
}
