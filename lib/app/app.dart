import 'package:flutter/material.dart';
import 'package:oneminute/app/router/app_router.dart';
import 'package:oneminute/providers/journal_provider.dart';
import 'package:oneminute/providers/navigation_provider.dart';
import 'package:oneminute/providers/onboarding_provider.dart';
import 'package:oneminute/providers/theme_provider.dart';
import 'package:oneminute/providers/writing_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
        ChangeNotifierProvider(create: (_) => WritingProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        //Provider(create: (_) => WritingProvider()),
        ChangeNotifierProxyProvider<WritingProvider, JournalProvider>(
          create: (context) =>
              JournalProvider(writingProvider: context.read<WritingProvider>()),
          update: (_, writingProvider, _) =>
              JournalProvider(writingProvider: writingProvider),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'One Minute',
            routerConfig: router,
            theme: context.watch<ThemeProvider>().theme,
            themeAnimationDuration: Durations.extralong1,
            themeAnimationCurve: Curves.easeInOut,
          );
        }
      ),
    );
  }
}
