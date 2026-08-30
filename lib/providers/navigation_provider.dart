import 'package:flutter/material.dart';
import 'package:oneminute/features/home/presentation/home.dart';
import 'package:oneminute/features/journal/presentation/journal.dart';
import 'package:oneminute/features/settings/presentation/settings.dart';
import 'package:oneminute/models/navigation.dart';

class NavigationViewModel with ChangeNotifier{
  final List<NavigationObj> tabs = [
    NavigationObj(label: "Home", icon: Icons.home_outlined),
    NavigationObj(label: "Journal", icon: Icons.book_outlined),
    NavigationObj(label: "Calendar", icon: Icons.calendar_today_outlined),
    NavigationObj(label: "Settings", icon: Icons.settings_outlined),
  ];

  final List<Widget> _views = [
    HomeScreen(),
    JournalScreen(),
    Center(child: Text("Calendar")),
    SettingsScreen(),
  ];

  Widget get view => _views[currentTab];

  int currentTab = 0;

  onTabChanged(int index) {
    currentTab = index;
    notifyListeners();
  }
}
