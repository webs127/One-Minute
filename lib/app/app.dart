import 'package:flutter/material.dart';
import 'package:oneminute/app/router/app_router.dart';
import 'package:oneminute/app/theme/app_theme.dart';
import 'package:oneminute/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingViewModel())
      ],
      child: MaterialApp.router(
        title: 'One Minute',
        routerConfig: router,
        theme: AppTheme.light(),
      ),
    );
  }
}