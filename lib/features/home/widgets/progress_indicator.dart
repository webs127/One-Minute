import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class AppProgressIndicator extends StatelessWidget {
  final Size? size;
  final String? text;
  final String? value;
  final double? progress;
  final double? fontSize;
  const AppProgressIndicator({
    super.key,
    this.size,
    this.text,
    this.fontSize, 
    this.value,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size?.width ?? 180,
        height: size?.height ?? 180,
        child: Stack(
          children: [
            SizedBox(
              width: size?.width ?? 180,
              height: size?.height ?? 180,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primary,
                color: AppColors.primaryContainer,
                value: progress ?? .2,
                strokeWidth: 9,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value ?? "01:00",
                    style: TextStyle(
                      fontSize: fontSize ?? 42,
                      fontWeight: FontWeight.w700,
                      color: AppColors.surfaceBlack,
                    ),
                  ),
                  text == null
                      ? SizedBox()
                      : Text(
                          text!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryText,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
