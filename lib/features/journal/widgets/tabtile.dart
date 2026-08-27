import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class TabTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final bool selected;
  const TabTile({
    super.key,
    this.onTap,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: selected
              ? BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(24),
                )
              : null,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: selected ? AppColors.primary : AppColors.secondaryText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
