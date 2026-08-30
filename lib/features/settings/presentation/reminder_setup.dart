import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/features/settings/widgets/settings_card.dart';
import 'package:oneminute/models/settings_card.dart';

class ReminderSetup extends StatefulWidget {
  const ReminderSetup({super.key});

  @override
  State<ReminderSetup> createState() => _ReminderSetupState();
}

class _ReminderSetupState extends State<ReminderSetup> {
  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }

  TimeOfDay _now = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Choose your moment",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    "Pick a time when you'd like to pause and capture your thoughts.",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 32),
                  Card.outlined(
                    elevation: 1,
                    child: InkWell(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: _now,
                        );

                        if (picked != null) {
                          setState(() {
                            _now = picked;
                          });

                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(
                          child: Column(
                            spacing: 10,
                            children: [
                              Text(
                                _now.format(context),
                                style: theme.textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                "$_greeting reflection".toUpperCase(),
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SettingsCard(
                    tiles: [
                      SettingsCardObj(
                        onTap: () {},
                        title: "Repeat",
                        suffix: Row(
                          spacing: 5,
                          children: [
                            Text(
                              "Every day",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 18,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                      SettingsCardObj(
                        onTap: () {},
                        title: "Daily Notification",
                        suffix: Switch.adaptive(
                          value: false,
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MaterialButton(
          shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(100),
          ),
          color: AppColors.primary,
          onPressed: () {},
          padding: EdgeInsets.all(16),
          child: Text(
            "Save Reminder",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.surfaceWhite,
            ),
          ),
        ),
      ),
    );
  }
}
