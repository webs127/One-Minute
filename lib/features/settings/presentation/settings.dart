import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/core/services/export_service.dart';
import 'package:oneminute/core/services/notification_service.dart';
import 'package:oneminute/features/settings/widgets/settings_card.dart';
import 'package:oneminute/models/settings_card.dart';
import 'package:oneminute/providers/reminder_provider.dart';
import 'package:oneminute/providers/theme_provider.dart';
import 'package:oneminute/providers/user_provider.dart';
import 'package:oneminute/providers/writing_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _editName() async {
    final newName = await showDialog<String>(
      context: context,
      builder: (context) =>
          _NameDialog(initialName: context.read<UserProvider>().name),
    );
    if (newName != null && mounted) {
      context.read<UserProvider>().setName(newName);
    }
  }

  Future<void> _confirmClearAll() async {
    final theme = Theme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.watch<ThemeProvider>().isLight
            ? AppColors.background
            : AppColors.darkbackground,
        title: Text(
          "Clear all data?",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        content: Text(
          "All journal entries will be permanently deleted. This cannot be undone.",
          style: theme.textTheme.titleSmall,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel", style: TextStyle(color: AppColors.primary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      context.read<WritingProvider>().clearAll();
    }
  }

  Future<void> _exportEntries() async {
    final journals = context.read<WritingProvider>().journals;
    if (journals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primary,
          content: Text(
            "No entries to export yet.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      );
      return;
    }
    await ExportService.instance.export(journals, context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsCard(
                title: "GENERAL",
                tiles: [
                  SettingsCardObj(
                    title: "Name",
                    subtitle: "How you're greeted on Home",
                    onTap: _editName,
                    icon: Icons.person_outline,
                    suffix: FittedBox(
                      child: Row(
                        spacing: 5,
                        children: [
                          Text(
                            context.watch<UserProvider>().name,
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
                    title: "Daily Reminder",
                    subtitle: "Get reminded to write your minute",
                    icon: Icons.notifications_outlined,
                    suffix: Switch.adaptive(
                      value: context.watch<ReminderProvider>().isEnabled,
                      onChanged: (v) =>
                          context.read<ReminderProvider>().setEnabled(v),
                    ),
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
                            context.watch<ReminderProvider>().time.format(
                              context,
                            ),
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
                    onTap: _exportEntries,
                    subtitle: "Download all your entries",
                    icon: Icons.file_download_outlined,
                  ),
                  SettingsCardObj(
                    title: "Clear All Data",
                    onTap: _confirmClearAll,
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

class _NameDialog extends StatefulWidget {
  const _NameDialog({required this.initialName});

  final String initialName;

  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialName,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.watch<ThemeProvider>().isLight
          ? AppColors.background
          : AppColors.darkbackground,
      title: Text(
        "Edit Name",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: context.read<ThemeProvider>().isLight
              ? AppColors.surfaceBlack
              : AppColors.surfaceWhite,
        ),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        style: TextStyle(
          color: context.read<ThemeProvider>().isLight
              ? AppColors.surfaceBlack
              : AppColors.surfaceWhite,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.read<ThemeProvider>().isLight
                  ? AppColors.primary
                  : AppColors.darkprimary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.read<ThemeProvider>().isLight
                  ? AppColors.primary
                  : AppColors.darkprimary,
            ),
          ),
          hintText: "Enter your name",
          hintStyle: TextStyle(
            color: context.read<ThemeProvider>().isLight
                ? AppColors.surfaceBlack
                : AppColors.surfaceWhite,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: AppColors.primary)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: Text("Save", style: TextStyle(color: AppColors.primary)),
        ),
      ],
    );
  }
}
