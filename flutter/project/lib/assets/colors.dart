import 'package:flutter/material.dart';

const Color textColor = Color(0xFFf4f0ee);
const Color backgroundColor = Color(0xFF241811);
const Color primaryColor = Color(0xFFe8c2af);
const Color primaryFgColor = Color(0xFF241811);
const Color secondaryColor = Color(0xFF6f4831);
const Color secondaryFgColor = Color(0xFFf4f0ee);
const Color accentColor = Color(0xFFC9A77C);
const Color accentFgColor = Color(0xFF241811);
const Color errorColor = Color(0xffF2B8B5);
const Color errorFgColor = Color(0xff601410);

final ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.dark,
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