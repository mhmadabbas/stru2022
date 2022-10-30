//palette.dart
import 'package:flutter/material.dart';
class Palette {
  static const MaterialColor kToBlue = const MaterialColor(
    0xff002bff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff1a40ff ),//10%
      100: const Color(0xff3355ff),//20%
      200: const Color(0xff4d6bff),//30%
      300: const Color(0xff6680ff),//40%
      400: const Color(0xff8095ff),//50%
      500: const Color(0xff99aaff),//60%
      600: const Color(0xffb3bfff),//70%
      700: const Color(0xffccd5ff),//80%
      800: const Color(0xffe6eaff),//90%
      900: const Color(0xffffffff),//100%
    },
  );
}

// 50: const Color(0xff0027e6 ),//10%
// 100: const Color(0xff0022cc),//20%
// 200: const Color(0xff001eb3),//30%
// 300: const Color(0xff001a99),//40%
// 400: const Color(0xff001680),//50%
// 500: const Color(0xff001166),//60%
// 600: const Color(0xff000d4c),//70%
// 700: const Color(0xff000933),//80%
// 800: const Color(0xff000419),//90%
// 900: const Color(0xff000000),//100%