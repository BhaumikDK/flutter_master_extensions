import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_master_extensions/src/size_utils/size_utils.dart';

extension TxtStyle on TextStyle {
  /// The most thick - FontWeight.w900
  TextStyle get mostThick => const TextStyle(fontWeight: FontWeight.w900);
  TextStyle get w900 => const TextStyle(fontWeight: FontWeight.w900);

  /// Extra-bold - FontWeight.w800
  TextStyle get extraBold => const TextStyle(fontWeight: FontWeight.w800);
  TextStyle get w800 => const TextStyle(fontWeight: FontWeight.w800);

  /// Bold - FontWeight.bold - FontWeight.w700
  TextStyle get bold => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: FontSizes.s64,
        height: 1.17,
        color: Colors.black,
      );
  TextStyle get w700 => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: FontSizes.s64,
        height: 1.17,
        color: Colors.black,
      );

  /// Semi-bold - FontWeight.w600
  TextStyle get semiBold => const TextStyle(fontWeight: FontWeight.w600);
  TextStyle get w600 => const TextStyle(fontWeight: FontWeight.w600);

  /// Medium - FontWeight.w500
  TextStyle get medium => const TextStyle(fontWeight: FontWeight.w500);
  TextStyle get w500 => const TextStyle(fontWeight: FontWeight.w500);

  /// Regular - FontWeight.w400
  TextStyle get regular => const TextStyle(fontWeight: FontWeight.w400);
  TextStyle get w400 => const TextStyle(fontWeight: FontWeight.w400);

  /// Light - FontWeight.w300
  TextStyle get light => const TextStyle(fontWeight: FontWeight.w300);
  TextStyle get w300 => const TextStyle(fontWeight: FontWeight.w300);

  /// Extra-light - FontWeight.w200
  TextStyle get extraLight => const TextStyle(fontWeight: FontWeight.w200);
  TextStyle get w200 => const TextStyle(fontWeight: FontWeight.w200);

  /// Thin, the least thick - FontWeight.w100
  TextStyle get thin => const TextStyle(fontWeight: FontWeight.w100);
  TextStyle get w100 => const TextStyle(fontWeight: FontWeight.w100);

  /// Apply Google Font to the text style
  TextStyle googleFont(String fontName) =>
      GoogleFonts.getFont(fontName, textStyle: this);

  TextStyle googleH1(String fontName) =>
      googleFont(fontName).w700.copyWith(fontSize: FontSizes.s64);

  TextStyle googleH2(String fontName) =>
      googleFont(fontName).w700.copyWith(fontSize: FontSizes.s48);

  TextStyle googleH3(String fontName) =>
      googleFont(fontName).w700.copyWith(fontSize: FontSizes.s36);

  TextStyle googleH4(String fontName) =>
      googleFont(fontName).w700.copyWith(fontSize: FontSizes.s24);
}
