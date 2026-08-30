import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/router/transitions.dart';
import 'package:oneminute/models/journal.dart';
import 'package:oneminute/features/home/presentation/home.dart';
import 'package:oneminute/features/home/presentation/summary.dart';
import 'package:oneminute/features/home/presentation/writing.dart';
import 'package:oneminute/features/journal/presentation/entry_detail.dart';
import 'package:oneminute/features/journal/presentation/journal.dart';
import 'package:oneminute/features/navigation/presentation/app_navigation.dart';
import 'package:oneminute/features/onboarding/presentation/onboarding.dart';
import 'package:oneminute/features/settings/presentation/about.dart';
import 'package:oneminute/features/settings/presentation/reminder_setup.dart';
import 'package:oneminute/features/settings/presentation/settings.dart';
import 'package:oneminute/features/splash/presentation/splash.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: RouteConstants.splash,
      name: 'Splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: RouteConstants.onboarding,
      name: 'Onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: RouteConstants.home,
      name: 'Home',
      routes: [
        GoRoute(
          path: RouteConstants.writing,
          name: "/home/writing",
          builder: (context, state) => WritingScreen(),
        ),
      ],
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: RouteConstants.navigation,
      name: 'navigation',
      builder: (context, state) => AppNavigationBar(),
    ),
    GoRoute(
      path: RouteConstants.summary,
      name: '/home/summary',
      builder: (context, state) => SummaryScreen(wordCount: state.extra as int),
    ),
    GoRoute(
      path: RouteConstants.journal,
      name: 'Journal',
      routes: [
        GoRoute(
          path: RouteConstants.entryDetail,
          name: "/journal/entryDetail",
          builder: (context, state) =>
              EntryDetailScreen(journal: state.extra as Journal),
        ),
      ],
      builder: (context, state) => JournalScreen(),
    ),
    GoRoute(
      path: RouteConstants.settings,
      name: 'Settings',
      builder: (context, state) => SettingsScreen(),
      routes: [
        GoRoute(
          path: RouteConstants.about,
          name: '/settings/about',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: AppTransitions.slideUp,
            child: AboutScreen(),
          ),
        ),
        GoRoute(
          path: RouteConstants.reminder,
          name: '/settings/reminder',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: AppTransitions.slideUp,
            child: ReminderSetup(),
          ),
        ),
      ],
    ),
  ],
);

// class ScaffoldWithNavBar extends StatelessWidget {
//   final StatefulNavigationShell navigationShell;
//   const ScaffoldWithNavBar({super.key, required this.navigationShell});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: navigationShell,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: navigationShell.currentIndex,
//         onTap: _onTap,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(MdiIcons.homeOutline),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(MdiIcons.bookOpenBlankVariant),
//             label: "Bible",
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "Search"),
//           BottomNavigationBarItem(
//             icon: Icon(MdiIcons.bookmarkOutline),
//             label: "Saved",
//           ),
//         ],
//       ),
//     );
//   }

//   void _onTap(int index) {
//     // Close any open popup menus before switching branches to avoid
//     // "Looking up a deactivated widget's ancestor is unsafe" errors.
//     try {
//       _bibleNavigatorKey.currentState?.popUntil((route) {
//         final rt = route.runtimeType.toString();
//         // Pop any internal PopupMenuRoute entries.
//         if (rt.contains('PopupMenuRoute')) {
//           return false; // keep popping
//         }
//         return true; // stop popping
//       });
//     } catch (_) {
//       // ignore any errors while attempting to close transient routes
//     }

//     navigationShell.goBranch(
//       index,
//       initialLocation: index == navigationShell.currentIndex,
//     );
//   }
// }
