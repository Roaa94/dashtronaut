import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/scale_up_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/pump_app.dart';

void main() {
  testWidgets(
    'Scale up animation is triggered',
    (WidgetTester tester) async {
      await tester.pumpProviderApp(
        ScaleUpTransition(child: Container()),
      );
      var scaleTransitionWidget =
          tester.widget(find.byType(ScaleTransition)) as ScaleTransition;
      expect(
        scaleTransitionWidget.scale.value,
        equals(AnimationsManager.scaleUp.tween.begin),
      );

      await tester.pump(AnimationsManager.scaleUp.duration);

      scaleTransitionWidget =
          tester.widget(find.byType(ScaleTransition)) as ScaleTransition;

      expect(
        scaleTransitionWidget.scale.value,
        equals(AnimationsManager.scaleUp.tween.end),
      );
    },
  );

  testWidgets(
    'Scale up animation is triggered after delay',
    (WidgetTester tester) async {
      const delay = Duration(seconds: 1);
      await tester.pumpProviderApp(
        ScaleUpTransition(
          delay: delay,
          child: Container(),
        ),
      );
      var scaleTransitionWidget =
          tester.widget(find.byType(ScaleTransition)) as ScaleTransition;
      expect(
        scaleTransitionWidget.scale.value,
        equals(AnimationsManager.scaleUp.tween.begin),
      );

      await tester.pump(delay);
      scaleTransitionWidget =
          tester.widget(find.byType(ScaleTransition)) as ScaleTransition;
      // Still at beginning scale
      expect(
        scaleTransitionWidget.scale.value,
        equals(AnimationsManager.scaleUp.tween.begin),
      );

      await tester.pump(AnimationsManager.scaleUp.duration);

      scaleTransitionWidget =
          tester.widget(find.byType(ScaleTransition)) as ScaleTransition;

      expect(
        scaleTransitionWidget.scale.value,
        equals(AnimationsManager.scaleUp.tween.end),
      );
    },
  );
}
