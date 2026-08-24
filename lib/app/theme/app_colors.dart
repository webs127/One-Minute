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
  static Color primary = HexColor.hexString("#5E7A6B");
  static Color primaryContainer = HexColor.hexString("#DDE8E1");
  static Color background = HexColor.hexString("#FAF9F6");
  static Color primaryText = HexColor.hexString("#1C1C1A");
  static Color secondaryText = HexColor.hexString("#74746F");
  static Color surfaceWhite = HexColor.hexString("#FFFFFF");
  static Color surfaceBlack = HexColor.hexString("#000000");
  static Color border = HexColor.hexString("#E8E6E1");
}