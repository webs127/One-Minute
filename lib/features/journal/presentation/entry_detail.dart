import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class EntryDetailScreen extends StatelessWidget {
  final String content;
  const EntryDetailScreen({super.key, required this.content});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            centerTitle: true,
            title: Text(
              "August 27, 2026",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(MdiIcons.delete,color: Colors.red,))
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
                    color: AppColors.surfaceWhite,
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.border),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              content,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
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
      bottomSheet: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 2)),
          color: AppColors.background,
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              spacing: 10,
              children: [
                Icon(MdiIcons.clockTimeThreeOutline, color: AppColors.primary,),
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
                  "67 Words",
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
