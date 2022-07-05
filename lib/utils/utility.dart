import 'package:flutter/material.dart';

double getDeviceHeight(BuildContext context) {
  double deviceHeight = MediaQuery.of(context).size.height;
  return deviceHeight;
}

double getDeviceWidth(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.width;
  return deviceWidth;
}

Color appBarColor = const Color(0xff136eb1);
Color wordColor = const Color(0xff3a6392);
Color typeColor = const Color(0xfff69440);
