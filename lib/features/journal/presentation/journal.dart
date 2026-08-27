import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/features/journal/widgets/app_tabbar.dart';
import 'package:oneminute/features/journal/widgets/empty_journal_state.dart';
import 'package:oneminute/features/journal/widgets/journal_calendar.dart';
import 'package:oneminute/features/journal/widgets/journal_listbuilder.dart';
import 'package:oneminute/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final List<String> tabs = ["Entries", "Calendar"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 140,
            backgroundColor: AppColors.background,
            pinned: true,
            floating: true,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Jounal",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(MdiIcons.filterOutline),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                AppTabBar(tabs: tabs),
              ],
            ),
          ),
          context.watch<JournalProvider>().selected == 0
              ? context.watch<JournalProvider>().isEmpty
                    ? EmptyJournalState()
                    : JournalListBuilder()
              : JournalCalendar(),
        ],
      ),
    );
  }
}
