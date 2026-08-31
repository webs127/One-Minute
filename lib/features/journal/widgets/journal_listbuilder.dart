import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/features/journal/widgets/journal_tile.dart';
import 'package:oneminute/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class JournalListBuilder extends StatelessWidget {
  const JournalListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: context.watch<JournalProvider>().journals.length,
      itemBuilder: (context, i) {
        final journal = context.read<JournalProvider>().journals[i];
        final now = DateTime.now();
        return JournalTile(
          day: journal.timestamp.year == now.year &&
                  journal.timestamp.month == now.month &&
                  journal.timestamp.day == now.day
              ? "Today"
              : journal.date,
          onTap: () {
            context.pushNamed(RouteConstants.entryDetail, extra: journal);
          },
          content: journal.content,
        );
      },
    );
  }
}