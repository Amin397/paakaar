import 'package:flutter/material.dart';

class ColorUtil {
  late final Color color;

  ColorUtil([int? colorValue]) {
    if (colorValue is int) {
      this.color = Color(colorValue);
    }
  }

  MaterialColor toMaterial() {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  factory ColorUtil.fromColor(Color color) => ColorUtil()..color = color;
}

class ColorUtils {
  static const MaterialColor yellow = MaterialColor(
    0xFFBF9B30,
    <int, Color>{
      50: Color(0xFFF7F3E6),
      100: Color(0xFFECE1C1),
      200: Color(0xFFDFCD98),
      300: Color(0xFFD2B96E),
      400: Color(0xFFC9AA4F),
      500: Color(0xFFBF9B30),
      600: Color(0xFFB9932B),
      700: Color(0xFFB18924),
      800: Color(0xFFA97F1E),
      900: Color(0xFF9B6D13),
    },
  );
  static const MaterialColor yellowAccent = MaterialColor(
    0xFFFFDA9B,
    <int, Color>{
      100: Color(0xFFFFEDCE),
      200: Color(0xFFFFDA9B),
      400: Color(0xFFFFC868),
      700: Color(0xFFFFBE4E),
    },
  );

  static const MaterialColor black = MaterialColor(
    0xFF252525,
    <int, Color>{
      50: Color(0xFFE5E5E5),
      100: Color(0xFFBEBEBE),
      200: Color(0xFF929292),
      300: Color(0xFF666666),
      400: Color(0xFF464646),
      500: Color(0xFF252525),
      600: Color(0xFF212121),
      700: Color(0xFF1B1B1B),
      800: Color(0xFF161616),
      900: Color(0xFF0D0D0D),
    },
  );
  static const MaterialColor darkBlue = MaterialColor(
    0xFF2978B5,
    <int, Color>{
      50: Color(0xFFE5EFF6),
      100: Color(0xFFBFD7E9),
      200: Color(0xFF94BCDA),
      300: Color(0xFF69A1CB),
      400: Color(0xFF498CC0),
      500: Color(0xFF2978B5),
      600: Color(0xFF2470AE),
      700: Color(0xFF1F65A5),
      800: Color(0xFF195B9D),
      900: Color(0xFF0F488D),
    },
  );

  static Color shadowColor = Colors.grey.withOpacity(0.15);
  static Color inActiveTextColor = Colors.grey.withOpacity(0.7);

  static MaterialColor mainRed = ColorUtil(0xff404040).toMaterial();
  static MaterialColor myRed = ColorUtil(0xff7E1515).toMaterial();
  static MaterialColor blue = ColorUtil(0xff3DB2FF).toMaterial();

  static const MaterialColor blackAccent = MaterialColor(
    0xFFE53C3C,
    <int, Color>{
      100: Color(0xFFEB6969),
      200: Color(0xFFE53C3C),
      400: Color(0xFFEE0000),
      700: Color(0xFFD40000),
    },
  );
  static MaterialColor red = ColorUtil(0xffCE1212).toMaterial();

  static const MaterialColor orange = MaterialColor(
    0xFFFFAA00,
    <int, Color>{
      50: Color(0xFFFFF5E0),
      100: Color(0xFFFFE6B3),
      200: Color(0xFFFFD580),
      300: Color(0xFFFFC44D),
      400: Color(0xFFFFB726),
      500: Color(0xFFFFAA00),
      600: Color(0xFFFFA300),
      700: Color(0xFFFF9900),
      800: Color(0xFFFF9000),
      900: Color(0xFFFF7F00),
    },
  );

  static Color textColor = ColorUtils.black.withOpacity(0.7);

  static Color searchBackground = Colors.grey.withOpacity(0.2);

  static Color headerCircle = Color.fromRGBO(255, 255, 255, 0.1);

  static MaterialColor green = ColorUtil(0xff00d411).toMaterial();

  static Color textFieldBackground = Colors.grey.withOpacity(0.1);
}
