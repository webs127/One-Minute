import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color hexString(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      color = "FF$color";
    }
    return Color(int.parse(color, radix: 16));
  }
}
class AppColors {
  //Light Colors
  static Color primary = HexColor.hexString("#5E7A6B");
  static Color primaryContainer = HexColor.hexString("#DDE8E1");
  static Color background = HexColor.hexString("#FAF9F6");
  static Color primaryText = HexColor.hexString("#1C1C1A");
  static Color secondaryText = HexColor.hexString("#74746F");
  static Color surfaceWhite = HexColor.hexString("#FFFFFF");
  static Color surfaceBlack = HexColor.hexString("#000000");
  static Color border = HexColor.hexString("#E8E6E1");

  //Light Colors
  static Color darkprimary = HexColor.hexString("#9BB8A7");
  static Color darkprimaryContainer = HexColor.hexString("#314239");
  static Color darkbackground = HexColor.hexString("#181A19");
  static Color darkprimaryText = HexColor.hexString("#F4F2ED");
  static Color darksecondaryText = HexColor.hexString("#B8B7B2");
  static Color darksurfaceBlack = HexColor.hexString("#232624");
  static Color darkborder = HexColor.hexString("#343835");
}