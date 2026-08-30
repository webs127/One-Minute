import 'package:flutter/material.dart';

class SettingsCardObj {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? suffix;
  final Color? color;
  final VoidCallback? onTap;

  SettingsCardObj({
    required this.title,
    this.subtitle,
    this.icon,
    this.suffix,
    this.color,
    this.onTap,
  });
}