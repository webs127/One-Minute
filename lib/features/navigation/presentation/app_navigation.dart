import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/providers/navigation_provider.dart';
import 'package:provider/provider.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (context, state, __) {
        return Scaffold(
          body: state.view,
          bottomNavigationBar: Container(
            height: 70,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                state.tabs.length,
                (i) => Expanded(
                  child: InkWell(
                    onTap: () {
                      state.onTabChanged(i);
                    },
                    child: Column(
                      spacing: 2,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          state.tabs[i].icon,
                          color: state.currentTab == i
                              ? AppColors.primary
                              : Colors.grey,
                          size: state.currentTab == i ? 25 : null,
                        ),
                        Text(
                          state.tabs[i].label,
                          style: TextStyle(
                            fontWeight: state.currentTab == i
                                ? FontWeight.bold
                                : FontWeight.bold,
                            color: state.currentTab == i
                                ? AppColors.primary
                                : Colors.grey,
                          ),
                        ),
                        state.currentTab == i
                            ? DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: AppColors.primary,
                                ),
                                child: SizedBox(height: 4, width: 4),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
