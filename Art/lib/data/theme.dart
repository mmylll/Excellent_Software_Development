import 'package:flutter/material.dart';

class Theme {

  /// 登录界面，定义渐变的颜色
  static const Color loginGradientStart = Color(0xff45cbd0);
  static const Color loginGradientEnd = Color(0xff467ccc);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [loginGradientStart, loginGradientEnd],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// 登录界面，定义渐变的颜色
  static const Color mainGradientStart = Color(0xff80e8df);
  static const Color mainGradientEnd = Color(0xff405cb7);
  static const RadialGradient mainGradient = RadialGradient(
      colors: [mainGradientStart, mainGradientEnd],
      radius: 2,
  );

  //主页主题
  static ThemeData lightThemeData = ThemeData(
    primarySwatch: Colors.blueGrey,
    backgroundColor: Colors.white,
    cardColor: Colors.blueGrey[50],
    primaryTextTheme: TextTheme(
      button: TextStyle(
        color: Colors.blueGrey,
        decorationColor: Colors.blueGrey[300],
      ),
      subtitle2: TextStyle(
        color: Colors.blueGrey[900],
      ),
      subtitle1: const TextStyle(
        color: Colors.black,
      ),
      headline1: TextStyle(color: Colors.blueGrey[800]),
    ),
    bottomAppBarColor: Colors.blueGrey[900],
    iconTheme: const IconThemeData(color: Colors.blueGrey),
    brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.black
  );

  static ThemeData darkThemeData = ThemeData(
    primarySwatch: Colors.blueGrey,
    backgroundColor: Colors.blueGrey[900],
    cardColor: Colors.black,
    primaryTextTheme: TextTheme(
      button: TextStyle(
        color: Colors.blueGrey[200],
        decorationColor: Colors.blueGrey[50],
      ),
      subtitle2: const TextStyle(
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        color: Colors.blueGrey[300],
      ),
      headline1: const TextStyle(
        color: Colors.white70,
      ),
    ),
    bottomAppBarColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.blueGrey[200]),
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.black
  );
}