import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 110,
            pinned: true,
            floating: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                      "Your Journal",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600
                      ),
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
