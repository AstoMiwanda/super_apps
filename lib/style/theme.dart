import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color transparent = Color(0x00000000);
//  OPACITY 50% white : 0x80FFFFFF
//  100% — FF
//  95% — F2
//  90% — E6
//  85% — D9
//  80% — CC
//  75% — BF
//  70% — B3
//  65% — A6
//  60% — 99
//  55% — 8C
//  50% — 80
//  45% — 73
//  40% — 66
//  35% — 59
//  30% — 4D
//  25% — 40
//  20% — 33
//  15% — 26
//  10% — 1A
//  5% — 0D
//  0% — 00

  static const Color gradientAwal = const Color(0xFFfbab66);
  static const Color gradientAkhir = const Color(0xFFfbab66);
  static const Color backgroundLogin = const Color(0xFF089fbd);
  static const Color bacgroundButton = const Color(0xFFf45e46);
  static const Color colorTextWhite = const Color(0xFFffffff);
  static const Color backgroundAbsen = const Color(0xFF0993b8);
  static const Color colorOnLocation = const Color(0xFF5dd72e);
  static const Color colorNotOnLocation = const Color(0xFFEF5350);
  static const Color backgroundHumanCapital = const Color(0xFF0993b8);

  static const Color iconMainMenu = const Color(0xFF0894b5);
  static const Color colorCircle = const Color(0x805dd72e);

  static const Color textBlackDetailCuti = const Color(0xFF3B3B3B);
  static const Color textGrayDetailCuti = const Color(0xFF757575);

  static const opactiColor = const Colors(
  );

  static const linearGradient = const LinearGradient(
      colors: const [gradientAwal, gradientAkhir],
      begin: Alignment.topCenter,
      stops: const [0.0, 0.1],
      end: Alignment.bottomCenter);
}
