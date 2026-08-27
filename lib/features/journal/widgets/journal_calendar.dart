import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';

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
    return SliverToBoxAdapter(
      child: Padding(
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
                    child: Container(
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
                          fontWeight: _isToday(day) || _isSelected(day)
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
}
