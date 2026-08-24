import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  start() {
    Future.delayed(Duration(seconds: 2), next);
  }

  next() {
    context.go(RouteConstants.onboarding);
  }
  @override
  void initState() {
    super.initState();
    start();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text(
          "One Minute",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
