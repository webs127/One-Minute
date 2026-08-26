import 'package:flutter/material.dart';
import 'package:oneminute/features/home/presentation/home.dart';

class NavigationViewModel with ChangeNotifier{
  final List<NavigationObj> tabs = [
    NavigationObj(label: "Home", icon: Icons.home_outlined),
    NavigationObj(label: "Journal", icon: Icons.book_outlined),
    NavigationObj(label: "Calendar", icon: Icons.calendar_today_outlined),
    NavigationObj(label: "Settings", icon: Icons.settings_outlined),
  ];

  final List<Widget> _views = [
    HomeScreen(),
    Center(child: Text("Journal")),
    Center(child: Text("Calendar")),
    Center(child: Text("Settings")),
  ];

  Widget get view => _views[currentTab];

  int currentTab = 0;

  onTabChanged(int index) {
    currentTab = index;
    notifyListeners();
  }
}

class NavigationObj {
  final String label;
  final IconData icon;

  NavigationObj({required this.label, required this.icon});
}