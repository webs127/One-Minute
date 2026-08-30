import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/models/settings_card.dart';

class CustomListTile extends StatelessWidget {
  final SettingsCardObj settingsCardObj;
  const CustomListTile({super.key, required this.settingsCardObj});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: settingsCardObj.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                settingsCardObj.icon == null ? SizedBox() : Icon(settingsCardObj.icon, color: settingsCardObj.color),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      settingsCardObj.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    settingsCardObj.subtitle == null
                        ? SizedBox()
                        : Text(
                            settingsCardObj.subtitle!,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 14,
                        color: settingsCardObj.color == null
                                  ? AppColors.secondaryText
                                  : settingsCardObj.color!,
                              fontWeight: FontWeight.w600,
                      ),
                          ),
                  ],
                ),
              ],
            ),
            settingsCardObj.suffix == null
                ? Icon(Icons.arrow_forward_ios, size: 15)
                : settingsCardObj.suffix!,
          ],
        ),
      ),
    );
  }
}
