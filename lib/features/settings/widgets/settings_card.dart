import 'package:flutter/material.dart';
import 'package:oneminute/features/settings/widgets/custom_listtile.dart';
import 'package:oneminute/models/settings_card.dart';

class SettingsCard extends StatelessWidget {
  final String? title;
  final List<SettingsCardObj> tiles;
  const SettingsCard({super.key,  this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null ? SizedBox() : Text(
          title!,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Card.outlined(
          child: Column(
            children: List.generate(
              tiles.length,
              (i) => CustomListTile(settingsCardObj: tiles[i]),
            ),
          ),
        ),
      ],
    );
  }
}


