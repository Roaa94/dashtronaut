import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/fade_in_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/pump_app.dart';

void main() {
  testWidgets(
    'Fade-in animation is triggered',
    (WidgetTester tester) async {
      await tester.pumpProviderApp(
        FadeInTransition(child: Container()),
      );
      var fadeInTransitionWidget =
          tester.widget(find.byType(FadeTransition)) as FadeTransition;
      expect(
        fadeInTransitionWidget.opacity.value,
        equals(AnimationsManager.fadeIn.tween.begin),
      );

      await tester.pump(AnimationsManager.fadeIn.duration);

      fadeInTransitionWidget =
          tester.widget(find.byType(FadeTransition)) as FadeTransition;

      expect(
        fadeInTransitionWidget.opacity.value,
        equals(AnimationsManager.fadeIn.tween.end),
      );
    },
  );

  testWidgets(
    'Fade-in animation is triggered after delay',
    (WidgetTester tester) async {
      const delay = Duration(seconds: 1);
      await tester.pumpProviderApp(
        FadeInTransition(
          delay: delay,
          child: Container(),
        ),
      );
      var fadeInTransitionWidget =
          tester.widget(find.byType(FadeTransition)) as FadeTransition;
      expect(
        fadeInTransitionWidget.opacity.value,
        equals(AnimationsManager.fadeIn.tween.begin),
      );

      await tester.pump(delay);
      fadeInTransitionWidget =
          tester.widget(find.byType(FadeTransition)) as FadeTransition;
      // Still at beginning fadeIn
      expect(
        fadeInTransitionWidget.opacity.value,
        equals(AnimationsManager.fadeIn.tween.begin),
      );

      await tester.pump(AnimationsManager.fadeIn.duration);

      fadeInTransitionWidget =
          tester.widget(find.byType(FadeTransition)) as FadeTransition;

      expect(
        fadeInTransitionWidget.opacity.value,
        equals(AnimationsManager.fadeIn.tween.end),
      );
    },
  );
}
