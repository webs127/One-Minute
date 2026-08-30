import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/features/settings/widgets/settings_card.dart';
import 'package:oneminute/models/settings_card.dart';
import 'package:oneminute/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 44, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings",
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SettingsCard(
                title: "GENERAL",
                tiles: [
                  SettingsCardObj(
                    title: "Daily Reminder",
                    subtitle: "Get reminded to write your minute",
                    icon: Icons.notifications_outlined,
                    suffix: Switch.adaptive(value: false, onChanged: (_) {}),
                  ),
                  SettingsCardObj(
                    title: "Reminder Time",
                    onTap: () {
                      context.pushNamed(RouteConstants.reminder);
                    },
                    icon: MdiIcons.clockTimeThreeOutline,
                    suffix: FittedBox(
                      child: Row(
                        spacing: 5,
                        children: [
                          Text(
                            "9:00 PM",
                            style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 15),
                        ],
                      ),
                    ),
                  ),
                  SettingsCardObj(
                    title: "Theme",
                    icon: Icons.wb_sunny_outlined,
                    suffix: Switch.adaptive(
                      value: context.watch<ThemeProvider>().isLight,
                      onChanged: context.read<ThemeProvider>().onThemeChanged,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SettingsCard(
                title: "DATA",
                tiles: [
                  SettingsCardObj(
                    title: "Export Entries",
                    subtitle: "Download all your entries",
                    icon: Icons.file_download_outlined,
                  ),
                  SettingsCardObj(
                    title: "Clear All Data",
                    subtitle: "This action cannot be undone",
                    icon: Icons.delete_outline,
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(height: 20),
              SettingsCard(
                title: "ABOUT",
                tiles: [
                  SettingsCardObj(
                    title: "About One Minute",
                    onTap: () => context.pushNamed(RouteConstants.about),
                    icon: Icons.info_outline,
                  ),
                  SettingsCardObj(
                    title: "Rate the App",
                    icon: Icons.star_border,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
