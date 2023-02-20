import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_app.dart';

void main() {
  testWidgets('', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      const PuzzleBoard(),
    );
  });
}
