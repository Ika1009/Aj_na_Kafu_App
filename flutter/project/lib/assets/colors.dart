const textColor = Color(0xFFf4f0ee);
const backgroundColor = Color(0xFF241811);
const primaryColor = Color(0xFFe8c2af);
const primaryFgColor = Color(0xFF241811);
const secondaryColor = Color(0xFF6f4831);
const secondaryFgColor = Color(0xFFf4f0ee);
const accentColor = Color(0xFFC9A77C);
const accentFgColor = Color(0xFF241811);
  
const colorScheme = ColorScheme(
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
  error: Color(0xffF2B8B5),
  onError: Color(0xff601410),
);