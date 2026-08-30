import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/models/journal.dart';

class EntryDetailScreen extends StatelessWidget {
  final Journal journal;
  const EntryDetailScreen({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              journal.date,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(MdiIcons.delete, color: Colors.red),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TODAY'S MOMENT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 5),
                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              journal.content,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 2)),
          //color: AppColors.background,
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              spacing: 10,
              children: [
                Icon(MdiIcons.clockTimeThreeOutline, color: AppColors.primary),
                Text(
                  "01:00 Time spent",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Icon(MdiIcons.formatTextVariant, color: AppColors.primary),
                Text(
                  "${journal.wordcount} ${journal.wordcount == 1 ? 'Word' : 'Words'}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
