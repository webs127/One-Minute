import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class EmptyJournalState extends StatelessWidget {
  const EmptyJournalState({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            children: [
              SizedBox(height: 100),
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primaryContainer,
                child: Icon(MdiIcons.book, size: 30, color: AppColors.primary),
              ),
              SizedBox(height: 20),
              Text(
                "Your story starts with one minute",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              Text(
                "Your jounal entries will appear here after you capture your first moment.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  context.pushNamed(RouteConstants.writing);
                },
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 42),
                shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24),
                ),
                color: AppColors.primary,
                child: Text(
                  "Write Today's Entry",
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.surfaceWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
