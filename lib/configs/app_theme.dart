import 'package:frontend/configs/app_helper.dart';
import 'package:flutter/material.dart';

Color themeColors = const Color(0xff1798F7);
Color themeLightColors = const Color(0xff43ACF7);
Color themeDarkColors = const Color(0xFF0268B0);

List<Color> gradientTheme = [themeDarkColors, themeColors];

const mBackgroundColor = Color(0xFFFAFAFA);
const mFillColor = Color(0xFFFFFFFF);

ThemeData theme() {
  return ThemeData(
    primarySwatch: buildMaterialColor(themeColors),
    primaryColor: themeColors,
    primaryColorDark: themeDarkColors,
    primaryColorLight: themeLightColors,
    fontFamily: 'Andika',
  );
}
