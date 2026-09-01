import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/models/journal.dart';
import 'package:oneminute/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class JournalCalendar extends StatefulWidget {
  const JournalCalendar({super.key});

  @override
  State<JournalCalendar> createState() => _JournalCalendarState();
}

class _JournalCalendarState extends State<JournalCalendar> {
  @override
  Widget build(BuildContext context) {
    return const CustomCalendar(
      dayHeight: 30,
    );
  }
}

class CustomCalendar extends StatefulWidget {
  final double? dayHeight;
  final double? padding;
  const CustomCalendar({super.key, this.dayHeight, this.padding});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;

  static const List<String> _weekdays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
      );
    });
  }

  List<DateTime> _getDaysInMonth() {
    final first = _displayedMonth;
    final daysInMonth = DateTime(first.year, first.month + 1, 0).day;
    final firstWeekday = first.weekday; // 1 = Mon ... 7 = Sun
    final leadingBlanks = firstWeekday - 1;

    final days = <DateTime>[];
    for (int i = 0; i < leadingBlanks; i++) {
      days.add(DateTime(first.year, first.month, 1 - (leadingBlanks - i)));
    }
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(first.year, first.month, i));
    }
    return days;
  }

  bool _isToday(DateTime day) {
    final now = DateTime.now();
    return day.year == now.year && day.month == now.month && day.day == now.day;
  }

  bool _isSelected(DateTime day) {
    return day.year == _selectedDate.year &&
        day.month == _selectedDate.month &&
        day.day == _selectedDate.day;
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();
    final journals = context.watch<JournalProvider>().journals;
    final entryDates = journals
        .map((j) => DateUtils.dateOnly(j.timestamp))
        .toSet();

    final entriesThisMonth = journals
        .where((j) =>
            j.timestamp.year == _displayedMonth.year &&
            j.timestamp.month == _displayedMonth.month)
        .length;

    final currentStreak = _calculateStreak(entryDates);

        final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(widget.padding ?? 16),
            child: Container(
              padding: EdgeInsets.all(widget.padding ?? 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _previousMonth,
                    icon: Icon(Icons.chevron_left, color: AppColors.primary),
                  ),
                  Text(
                    "${_monthName(_displayedMonth.month)} ${_displayedMonth.year}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  IconButton(
                    onPressed: _nextMonth,
                    icon: Icon(Icons.chevron_right, color: AppColors.primary),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _weekdays
                    .map(
                      (d) => SizedBox(
                        width: 36,
                        child: Text(
                          d,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisExtent: widget.dayHeight ?? 40,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  final inCurrentMonth = day.month == _displayedMonth.month;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = day;
                      });
                    },
                    child: SizedBox.expand(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Center(
                            child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _isSelected(day)
                                    ? AppColors.primary
                                    : _isToday(day)
                                    ? AppColors.primaryContainer
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${day.day}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: _isToday(day) ||
                                          _isSelected(day)
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  color: inCurrentMonth
                                      ? (_isSelected(day)
                                            ? AppColors.surfaceWhite
                                            : AppColors.primaryText)
                                      : AppColors.border,
                                ),
                              ),
                            ),
                          ),
                          if (entryDates.contains(DateUtils.dateOnly(day)))
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              Divider(color: AppColors.border, height: 1),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event, size: 18, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    _selectedDate.year == DateTime.now().year &&
                            _selectedDate.month == DateTime.now().month &&
                            _selectedDate.day == DateTime.now().day
                        ? "Today, ${_fullDate(_selectedDate)}"
                        : _fullDate(_selectedDate),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$entriesThisMonth",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          "Entries this month",
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.w400
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$currentStreak ${currentStreak == 1 ? 'day' : 'days'}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        "Current streak",
                        style: theme.textTheme.titleSmall?.copyWith(
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                  ),
                ),)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: widget.padding ?? 16,
            right: widget.padding ?? 16,
            bottom: widget.padding ?? 16,
          ),
          child: _buildDayPreview(journals),
        ),
      ],
    ),
  );
}

  Widget _buildDayPreview(List<Journal> journals) {
    final theme = Theme.of(context);
    Journal? entry;
    for (final j in journals) {
      if (DateUtils.isSameDay(j.timestamp, _selectedDate)) {
        entry = j;
        break;
      }
    }
    final header = "${_monthName(_selectedDate.month)} ${_selectedDate.day} Preview"
        .toUpperCase();
    return Card.outlined(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 10),
            if (entry == null)
              Text(
                "No journal entry on this day.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryText,
                ),
              )
            else
              Text(
                entry.content,
                style: theme.textTheme.titleMedium,
              ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const names = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return names[month - 1];
  }

  String _fullDate(DateTime date) {
    return "${date.day} ${_monthName(date.month)} ${date.year}";
  }

  int _calculateStreak(Set<DateTime> entryDates) {
    var streak = 0;
    var day = DateTime.now();
    while (entryDates.contains(DateUtils.dateOnly(day))) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }
}
