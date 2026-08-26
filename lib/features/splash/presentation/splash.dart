import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/core/constants/image_constants.dart';

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
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150, width: 150, child: Image.asset(
              ImageConstants.icon),),
            Text(
              "One Minute",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
