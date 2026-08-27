import 'package:flutter/material.dart';
import 'package:oneminute/providers/writing_provider.dart';

class JournalProvider with ChangeNotifier{
  final WritingProvider writingProvider;

  JournalProvider({required this.writingProvider});
  int selected = 0;

  onTabChanged(int value) {
    selected = value;
    notifyListeners();
  }

  List<String> get journals => writingProvider.journals;

  bool get isEmpty => writingProvider.journals.isEmpty;
}