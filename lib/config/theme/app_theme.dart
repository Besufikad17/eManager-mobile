import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

Color _lightIconColor = getColorFromHex("#000000");
Color _lightPrimaryColor = getColorFromHex("#ffffff");
Color _lightPrimaryVariantColor = getColorFromHex("#ffffff");
Color _lightSecondaryColor = getColorFromHex("#ffffff");
Color _lightOnPrimaryColor = getColorFromHex("#000000");
Color _lightShadowColor = getColorFromHex("#000000");

Color _darkIconColor = getColorFromHex("#D4D4D4");
Color _darkPrimaryColor = getColorFromHex("#212121");
Color _darkPrimaryVariantColor = getColorFromHex("#000000");
Color _darkSecondaryColor = getColorFromHex("#3c3836s");
Color _darkOnPrimaryColor = getColorFromHex("#D4D4D4");
Color _darkShadowColor = getColorFromHex("#5A5B5A");

final TextTheme _lightTextTheme = TextTheme(
  displayLarge: _lightScreenHeading1TextStyle,
);
final TextTheme _darkTextTheme = TextTheme(
  displayLarge: _darkScreenHeading1TextStyle,
);
final TextStyle _lightScreenHeading1TextStyle = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
    color: _lightOnPrimaryColor,
);
final TextStyle _darkScreenHeading1TextStyle =
    _lightScreenHeading1TextStyle.copyWith(color: _darkOnPrimaryColor);

final lightTheme = ThemeData(
      shadowColor: _lightShadowColor,
      scaffoldBackgroundColor: _lightPrimaryVariantColor,
      appBarTheme: AppBarTheme(
        color: _lightPrimaryColor,
        iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      ),
      colorScheme: ColorScheme.light(
          primary: _lightPrimaryColor,
          secondary: _lightSecondaryColor,
          onPrimary: _lightOnPrimaryColor,
          background: _lightPrimaryColor).copyWith(brightness: Brightness.light),
      iconTheme: IconThemeData(color: _lightIconColor),
      textTheme: _lightTextTheme,
      buttonTheme: ButtonThemeData(buttonColor: _lightIconColor)
  );

  final darkTheme = ThemeData(
      brightness: Brightness.dark,
      shadowColor: _darkShadowColor,
      scaffoldBackgroundColor: _darkPrimaryVariantColor,
      appBarTheme: AppBarTheme(
        color: _darkPrimaryColor,
        iconTheme: IconThemeData(color: _darkOnPrimaryColor),
      ),
      colorScheme: ColorScheme.light(
          primary: _darkPrimaryColor,
          secondary: _darkSecondaryColor,
          onPrimary: _darkOnPrimaryColor,
          background: _darkOnPrimaryColor).copyWith(brightness: Brightness.dark),
      iconTheme: IconThemeData(color: _darkIconColor),
      textTheme: _darkTextTheme,
      buttonTheme: ButtonThemeData(buttonColor: _darkIconColor)
  );
