import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/features/onboarding/widgets/onboarding_page.dart';
import 'package:oneminute/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<OnboardingViewModel>(
          builder: (context, state, __) {
            return PageView.builder(
              controller: state.controller,
              itemCount: state.length,
              onPageChanged: state.onPageChanged,
              itemBuilder: (context, i) =>
                  OnboardingPage(size: size, state: state),
            );
          },
        ),
      ),
    );
  }
}
