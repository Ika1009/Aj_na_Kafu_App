import 'package:flutter/material.dart';

const double defaultPadding = 16.0;
const double kDefaultPadding = 20.0;

const Color textColor = Color(0xFF050316);
const Color backgroundColor = Color(0xFFfbfefc);
const Color primaryColor = Color(0xFF0c3b2e);
const Color primaryFgColor = Color(0xFFfbfefc);
const Color secondaryColor = Color(0xFF709e76);
const Color secondaryFgColor = Color(0xFF050316);
const Color accentColor = Color(0xFFffba00);
const Color accentFgColor = Color(0xFF050316);
const Color errorColor = Color(0xffF2B8B5);
const Color errorFgColor = Color(0xff601410);

final ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.light,
  background: backgroundColor,
  onBackground: textColor,
  primary: primaryColor,
  onPrimary: primaryFgColor,
  secondary: secondaryColor,
  onSecondary: secondaryFgColor,
  tertiary: accentColor,
  onTertiary: accentFgColor,
  surface: backgroundColor,
  onSurface: textColor,
  error: errorColor,
  onError: errorFgColor,
);