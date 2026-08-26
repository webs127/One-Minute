import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/providers/onboarding_provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.size, required this.state,
  });

  final Size size;
  final OnboardingViewModel state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          foregroundDecoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .4),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                state
                    .onboarding
                    .imagePath,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 60,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state
                          .onboarding
                          .title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: AppColors.surfaceWhite,
                      ),
                    ),
                    Text(
                      state
                          .onboarding
                          .subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.surfaceWhite.withValues(alpha: .5),
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.black.withValues(alpha: .1),
                    ),
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 25,
                    color: AppColors.surfaceWhite,
                  ),
                  iconAlignment: IconAlignment.end,
                  onPressed: !state.endOfPage ? () {
                   state.nextPage();
                  } : () {
                    context.go(RouteConstants.navigation);
                  },
                  label: Text(
                    state.endOfPage ? "Get Started" : "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppColors.surfaceWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
