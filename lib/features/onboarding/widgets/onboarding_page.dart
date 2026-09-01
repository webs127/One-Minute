import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/providers/onboarding_provider.dart';
import 'package:oneminute/providers/user_provider.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
    required this.size, required this.state,
  });

  final Size size;
  final OnboardingViewModel state;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final TextEditingController _nameController = TextEditingController();

  OnboardingViewModel get state => widget.state;
  Size get size => widget.size;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (state.endOfPage) {
      final userProvider = context.read<UserProvider>();
      await userProvider.setName(_nameController.text);
      await userProvider.completeOnboarding();
      if (mounted) {
        context.go(RouteConstants.navigation);
      }
    } else {
      state.nextPage();
    }
  }  @override
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
                    if (state.endOfPage) ...[
                      SizedBox(height: 20),
                      SizedBox(
                        width: size.width - 32,
                        child: TextField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "What's your name?",
                            hintStyle: TextStyle(
                              color: Colors.white.withValues(alpha: .6),
                            ),
                            filled: true,
                            fillColor: Colors.black.withValues(alpha: .2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                  onPressed: _continue,
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
