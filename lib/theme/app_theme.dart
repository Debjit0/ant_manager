
import 'package:flutter/material.dart';

import 'constants/project_colors.dart';

class AppTheme {
  Color primaryColor = cRed;
  Color secondaryColor = cYellow;
  Color tertiaryColor = cBlack;

  static const buttonTextFamily = 'Raleway';
  static const double buttonFontSizeLarge = 20;
  static const double buttonFontSizeMedium = 16;
  static const double buttonFontSizeSmall = 12;
  static const buttonFontWeight = FontWeight.w400;

  static var largeButtonTextStyle = TextStyle(
    fontFamily: buttonTextFamily,
    fontSize: buttonFontSizeLarge,
  );
  static var mediumButtonTextStyle = TextStyle(
    fontFamily: buttonTextFamily,
    fontSize: buttonFontSizeMedium,
  );
  static var smallButtonTextStyle = TextStyle(
    fontFamily: buttonTextFamily,
    fontSize: buttonFontSizeSmall,
  );
}
