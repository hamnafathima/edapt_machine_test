import 'package:flutter/material.dart';
import 'color_class.dart';

const String primaryFontName = 'Inter';

class TextstyleClass {
  static TextStyle white26_400 = const TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w400,
      fontSize: 26,
      color: Colors.black);
  static TextStyle grey16_400 = const TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: ColorClass.lightGrey);
  static TextStyle black20_600 = const TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Colors.black);
  static TextStyle dark16_600 = const TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: ColorClass.darkGrey);
  static TextStyle white22_800 = const TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w800,
      fontSize: 22,
      color: Colors.white);
}
