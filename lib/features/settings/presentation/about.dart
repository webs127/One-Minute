import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/core/constants/image_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About One Minute",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ImageConstants.icon, width: 100, height: 100),
              const SizedBox(height: 16),
              Text(
                "One Minute",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "One minute is enough.",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              _Section(
                title: "One Minute is a simple journaling app built around one idea.",
                body: "You don't need an hour to reflect. You just need a minute.\n\n"
                    "Every day, you get 60 seconds to pause, write, and capture "
                    "whatever is on your mind.\n\n"
                    "No pressure to write perfectly.\n"
                    "No long prompts.\n"
                    "No expectation to fill pages.\n\n"
                    "Just one honest minute.",
              ),
              _Section(
                title: "Why One Minute?",
                body: "Life moves quickly, and it's easy to forget the small "
                    "moments that make up our days.\n\n"
                    "One Minute gives you a simple space to slow down, put your "
                    "thoughts into words, and create a record of your journey — "
                    "one minute at a time.",
              ),
              _Section(
                title: "Our Philosophy",
                body: "Keep it simple. — A journaling habit shouldn't feel like "
                    "another task on your to-do list.\n\n"
                    "Be honest. — Your entries don't need to sound good. They only "
                    "need to be yours.\n\n"
                    "Show up. — One minute today is better than an hour you never find.",
              ),
              _Section(
                title: "One Day. One Entry. One Minute.",
                body: "A small habit for a lifetime of memories.",
              ),
              const SizedBox(height: 24),
              Text(
                "Made with care for people who want to pause, reflect, and remember.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Version 1.0.0",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "© 2026 One Minute. All rights reserved.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String body;
  const _Section({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          //textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
      ],
    );
  }
}
