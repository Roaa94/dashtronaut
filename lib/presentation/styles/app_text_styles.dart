import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const String primaryFontFamily = 'PaytoneOne';

  static const String secondaryFontFamily = 'Montserrat';

  static const TextStyle tile = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle title = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 25,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 20,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 18,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle body = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 16,
  );

  static const TextStyle bodyBold = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bodySm = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 14,
  );

  static const TextStyle bodyXs = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 12,
  );

  static const TextStyle bodyXxs = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 10,
  );

  static const TextStyle button = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16,
    height: 1,
  );

  static const TextStyle buttonSm = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    height: 1,
  );
}
