import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/features/journal/widgets/tabtile.dart';
import 'package:oneminute/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({super.key, required this.tabs});

  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.all(4),
      child: Row(
        spacing: 4,
        children: List.generate(
          tabs.length,
          (i) => TabTile(
            onTap: () {
              context.read<JournalProvider>().onTabChanged(i);
            },
            label: tabs[i],
            selected: context.watch<JournalProvider>().selected == i,
          ),
        ),
      ),
    );
  }
}
