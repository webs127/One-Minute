import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class StartButton extends StatelessWidget {
  final bool enabled;
  const StartButton({super.key, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled
          ? () => context.pushNamed(RouteConstants.writing)
          : null,
          borderRadius: BorderRadius.circular(100),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.watch<ThemeProvider>().isLight ? AppColors.background : AppColors.darkborder,
              blurRadius: 20,
              spreadRadius: context.watch<ThemeProvider>().isLight ? 20 : 10,
            ),
          ],
          color: enabled ? AppColors.primary : AppColors.border,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Icon(
              enabled
                  ? Icons.play_arrow
                  : Icons.check_circle_outline,
              color: AppColors.secondaryText,
            ),
            Text(
              enabled ? "Start Your Minute" : "Come Back Tomorrow",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
