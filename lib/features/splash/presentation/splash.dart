import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/core/constants/image_constants.dart';
import 'package:oneminute/providers/theme_provider.dart';
import 'package:oneminute/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  start() {
    Future.delayed(Duration(seconds: 2), next);
  }

  Future<void> next() async {
    final userProvider = context.read<UserProvider>();
    await userProvider.ready;
    if (!mounted) return;
    context.go(
      userProvider.onboardingCompleted
          ? RouteConstants.navigation
          : RouteConstants.onboarding,
    );
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
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: context.watch<ThemeProvider>().isLight
                        ? AppColors.primaryContainer
                        : AppColors.darkborder,
                    blurRadius: 50,
                    spreadRadius: 40,
                  ),
                ],
              ),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(ImageConstants.icon),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "One Minute",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: context.watch<ThemeProvider>().isLight ? AppColors.surfaceBlack : AppColors.secondaryText,
              ),
            ),
            Text(
              "Your thoughts. Just one minute.",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          "Reflective Journaling",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
