import 'package:flutter/material.dart';

const kTextColor = Color(0xFF707070);
const kTextLightColor = Color(0xFF555555);
const primaryColor = Color(0xFFFFC107);
const secondaryColor = Color(0xFF242430);
const darkColor = Color(0xFF191923);
const bodyTextColor = Color(0xFF8B8B8D);
const bgColor = Color(0xFF1E1E28);
final colorPrimary = Color(0xff0070BA);
final colorPrimaryShade = Color(0xff005EA6);
final colorPrimaryDark = Color(0xff1546A0);
final colorPrimaryGradient = Color(0xff0070BA);
final colorGray = Color(0xffF5F7FA);
final colorWhite = Color(0xffFFFFFF);
final colorBlack = Color(0xff243656);
final colorOpacBlack = Color(0xff929BAB);
final colorGreen = Color(0xff37D39B);
final colorRed = Color(0xffF47090);
const maxWidth = 1440.0; // max width of our web
const defaultPadding = 20.0;
const kDefaultPadding = 20.0;
const defaultDuration = Duration(seconds: 1); // we use it on our animation

final kDefaultShadow = BoxShadow(
  offset: Offset(0, 50),
  blurRadius: 50,
  color: Color(0xFF0700B1).withOpacity(0.15),
);

final kDefaultCardShadow = BoxShadow(
  offset: Offset(0, 20),
  blurRadius: 50,
  color: Colors.black.withOpacity(0.1),
);

// TextField dedign
const kDefaultInputDecorationTheme = InputDecorationTheme(
  border: kDefaultOutlineInputBorder,
  enabledBorder: kDefaultOutlineInputBorder,
  focusedBorder: kDefaultOutlineInputBorder,
);

const kDefaultOutlineInputBorder = OutlineInputBorder(
  // Maybe flutter team need to fix it on web
  // borderRadius: BorderRadius.circular(50),
  borderSide: BorderSide(
    color: Color(0xFFCEE4FD),
  ),
);
