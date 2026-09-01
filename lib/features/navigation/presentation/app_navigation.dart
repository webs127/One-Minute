import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/providers/navigation_provider.dart';
import 'package:oneminute/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (context, state, __) {
        return Scaffold(
          drawer: _AppDrawer(),
          body: state.view,
          bottomNavigationBar: Container(
            height: 70,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                state.tabs.length,
                (i) => Expanded(
                  child: InkWell(
                    onTap: () {
                      state.onTabChanged(i);
                    },
                    child: Column(
                      spacing: 2,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          state.tabs[i].icon,
                          color: state.currentTab == i
                              ? AppColors.primary
                              : Colors.grey,
                          size: state.currentTab == i ? 25 : null,
                        ),
                        Text(
                          state.tabs[i].label,
                          style: TextStyle(
                            fontWeight: state.currentTab == i
                                ? FontWeight.bold
                                : FontWeight.bold,
                            color: state.currentTab == i
                                ? AppColors.primary
                                : Colors.grey,
                          ),
                        ),
                        state.currentTab == i
                            ? DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: AppColors.primary,
                                ),
                                child: SizedBox(height: 4, width: 4),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nav = context.read<NavigationViewModel>();
    final isDark = !context.watch<ThemeProvider>().isLight;
    final surfaceColor = isDark ? AppColors.darksurfaceBlack : AppColors.background;
    final dividerColor = isDark ? AppColors.darkborder : AppColors.border;

    void goToTab(int index) {
      nav.onTabChanged(index);
      Navigator.pop(context);
    }

    Widget item({
      required IconData icon,
      required String label,
      required VoidCallback onTap,
    }) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              const SizedBox(width: 16),
              Text(
                label,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Drawer(
      backgroundColor: surfaceColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "One Minute",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            Divider(color: dividerColor, height: 1),
            item(
              icon: Icons.home_outlined,
              label: "Home",
              onTap: () => goToTab(0),
            ),
            item(
              icon: Icons.book_outlined,
              label: "Journal",
              onTap: () => goToTab(1),
            ),
            item(
              icon: Icons.settings_outlined,
              label: "Settings",
              onTap: () => goToTab(2),
            ),
            Divider(color: dividerColor, height: 1),
            item(
              icon: Icons.info_outline,
              label: "About One Minute",
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(RouteConstants.about);
              },
            ),
            item(
              icon: Icons.notifications_outlined,
              label: "Daily Reminder",
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(RouteConstants.reminder);
              },
            ),
            Divider(color: dividerColor, height: 1),
            item(
              icon: Icons.star_border,
              label: "Rate the App",
              onTap: () => Navigator.pop(context),
            ),
            item(
              icon: Icons.delete_outline,
              label: "Clear All Data",
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
