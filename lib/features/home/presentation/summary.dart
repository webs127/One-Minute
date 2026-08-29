import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class SummaryScreen extends StatefulWidget {
  final int wordCount;
  const SummaryScreen({super.key, required this.wordCount});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: AppColors.primaryContainer,
                  child: Icon(
                    MdiIcons.checkboxMarkedCircleOutline,
                    color: AppColors.primary,
                    size: 40,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "That's your minute!",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Your minute has been saved\nfor today.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                  ),
                ),
                SizedBox(height: 30),
                Card.outlined(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SummaryCardTile(
                          icon: MdiIcons.clockTimeThreeOutline,
                          title: "01:00",
                          subtitle: "Time Spent",
                        ),
                        Container(
                          width: 02,
                          height: 50,
                          color: AppColors.border,
                        ),
                        SummaryCardTile(
                          icon: MdiIcons.leadPencil,
                          title: "${widget.wordCount}",
                          subtitle: "Words",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                MaterialButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(16),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  color: AppColors.primary,
                  minWidth: size.width,
                  child: Text(
                    "Read Today's Entry",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.surfaceWhite,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  onPressed: () {
                    context.go(RouteConstants.navigation);
                  },
                  padding: EdgeInsets.all(16),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  minWidth: size.width,
                  child: Text(
                    "Back to Home",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SummaryCardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const SummaryCardTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: 10,
      children: [
        Icon(icon, color: AppColors.primary.withValues(alpha: .5), size: 35),
        Column(
          spacing: 3,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
