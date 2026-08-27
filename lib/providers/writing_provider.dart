import 'package:flutter/widgets.dart';
import 'package:oneminute/core/services/countdown_service.dart';

class WritingProvider with ChangeNotifier {
  final List<String> journals = [];
  final CountdownService _countdownService = CountdownService();

  final List<String> prompts = [
    "What are three things you're grateful for today?",
    "Describe a moment that made you smile recently.",
    "What's one thing you'd like to let go of?",
    "If today had a theme, what would it be?",
    "Write a letter to your future self.",
    "What's a small win you had today?",
    "Describe your ideal peaceful morning.",
    "What's something you're looking forward to?",
  ];

  int _currentPromptIndex = 0;
  int _wordCount = 0;
  String _draftText = '';

  int get currentPromptIndex => _currentPromptIndex;
  String get currentPrompt => prompts[_currentPromptIndex];
  int get wordCount => _wordCount;
  String get draftText => _draftText;

  Stream<TaskState>? get stream => _countdownService.stream;
  int get initialSeconds => _countdownService.initialCount;

  WritingProvider() {
    _currentPromptIndex = DateTime.now().millisecondsSinceEpoch % prompts.length;
  }

  void updateWordCount(String text) {
    final trimmed = text.trim();
    _wordCount = trimmed.isEmpty ? 0 : trimmed.split(RegExp(r'\s+')).length;
    notifyListeners();
  }

  void setWordCount(String text) {
    final trimmed = text.trim();
    _wordCount = trimmed.isEmpty ? 0 : trimmed.split(RegExp(r'\s+')).length;
  }

  void saveDraft(String text) {
    if (!isDone) {
      _draftText = text;
    }
  }

  void clearDraft() {
    _draftText = '';
    _wordCount = 0;
    notifyListeners();
  }

  void nextPrompt() {
    _currentPromptIndex = (_currentPromptIndex + 1) % prompts.length;
    notifyListeners();
  }

  start() => _countdownService.start();
  pause() => _countdownService.pause();
  resume() => _countdownService.resume();
  dispose() => _countdownService.dispose();

  bool get isDone => _countdownService.isDone(); 
  
  addJournal(String value) {
    journals.add(value);
    notifyListeners();
  }
}
