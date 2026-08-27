import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class JournalTile extends StatelessWidget {
  final String day;
  final String content;
  final VoidCallback? onTap;
  const JournalTile({
    super.key,
    required this.day,
    required this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: Card.outlined(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.border),
        ),
        color: AppColors.surfaceWhite,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
