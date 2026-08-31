import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/features/home/widgets/progress_indicator.dart';
import 'package:oneminute/features/home/widgets/start_button.dart';
import 'package:oneminute/providers/navigation_provider.dart';
import 'package:oneminute/providers/writing_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<String> _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String get _formattedDate {
    final now = DateTime.now();
    return '${_weekdays[now.weekday - 1]}, ${now.day} ${_months[now.month - 1]}';
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasEntry = context.watch<WritingProvider>().hasEntryToday;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(MdiIcons.menu)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_outlined),
                ),
              ],
            ),
            Text("$_greeting,", style: theme.textTheme.headlineLarge),
            SizedBox(height: 5),
            Text(
              "Divine",
              style: theme.textTheme.headlineLarge?.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              _formattedDate,
              style: theme.textTheme.titleMedium?.copyWith(),
            ),
            SizedBox(height: 30),
            Card.outlined(
              elevation: 0.5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TODAY'S MOMENT",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondaryText,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            border: Border.all(color: AppColors.primary),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            hasEntry ? "Done" : "New",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.surfaceBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      hasEntry
                          ? "You've captured your moment\nfor today."
                          : "You haven't captured\nyour moment today.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.surfaceBlack,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      hasEntry
                          ? "Your next minute will be available tomorrow."
                          : "Take one minute of yourself.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Stack(
                          children: [
                            AppProgressIndicator(),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Align(
                                alignment: AlignmentGeometry.bottomCenter,
                                child: StartButton(enabled: !hasEntry),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              "YOUR PROGRESS",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryText,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Card.outlined(
                    elevation: .5,
                    child: InkWell(
                      onTap: () =>
                          context.read<NavigationViewModel>().onTabChanged(2),
                          borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Icon(
                              MdiIcons.fire,
                              color: Colors.orange,
                              size: 35,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "0",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Day Streak",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card.outlined(
                    elevation: .5,
                    child: InkWell(
                      onTap: () =>
                          context.read<NavigationViewModel>().onTabChanged(1),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Icon(
                              Icons.task,
                              color: AppColors.primary.withValues(alpha: .5),
                              size: 35,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .watch<WritingProvider>()
                                      .journalLength
                                      .toString(),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Total Entries",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
