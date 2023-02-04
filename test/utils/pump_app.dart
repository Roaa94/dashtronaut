import 'package:dashtronaut/core/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpProviderApp(
    Widget widget, {
    List<Override> overrides = const [],
  }) async {
    return pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: AppThemes.dark,
          themeMode: ThemeMode.dark,
          home: widget,
        ),
      ),
    );
  }
}
