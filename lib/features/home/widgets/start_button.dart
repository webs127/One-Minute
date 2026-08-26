import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(RouteConstants.writing),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.background,
              blurRadius: 20,
              spreadRadius: 20,
            ),
          ],
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Icon(Icons.play_arrow, color: AppColors.surfaceWhite),
            Text(
              "Start Your Minute",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.surfaceWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
