import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oneminute/app/router/route_constants.dart';
import 'package:oneminute/app/theme/app_colors.dart';
import 'package:oneminute/core/services/countdown_service.dart';
import 'package:oneminute/features/home/widgets/progress_indicator.dart';
import 'package:oneminute/providers/writing_provider.dart';
import 'package:provider/provider.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  late final WritingProvider _provider;
  StreamSubscription<TaskState>? _subscription;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = context.read<WritingProvider>();
    if (_provider.draftText.isNotEmpty) {
      _textController.text = _provider.draftText;
      _provider.setWordCount(_provider.draftText);
    }
    _subscription = _provider.stream?.listen((state) {
      if (state.isFinished && mounted) {
        final count = _provider.wordCount;
        _provider.clearDraft();
        context.pushNamed(RouteConstants.summary, extra: count);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.start();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _provider.saveDraft(_textController.text);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    onPressed: () {
                      context.read<WritingProvider>().pause();
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shield_outlined),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Consumer<WritingProvider>(
                builder: (context, state, __) {
                  return StreamBuilder(
                    stream: state.stream,
                    builder: (context, snapshot) {
                      final seconds =
                          snapshot.data?.secondsLeft ?? state.initialSeconds;
                      final minute = (seconds ~/ state.initialSeconds)
                          .toString()
                          .padLeft(2, '0');
                      final secs = (seconds % state.initialSeconds)
                          .toString()
                          .padLeft(2, '0');
                      final targetProgress = snapshot.data?.progress ?? 0;
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: targetProgress),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return AppProgressIndicator(
                            size: Size(200, 200),
                            fontSize: 48,
                            progress: value,
                            value: "$minute:$secs",
                            text: "Keep going...",
                          );
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 40),
              Text(
                "Tuesday, 24 August",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryText,
                ),
              ),
              SizedBox(height: 5),
              Consumer<WritingProvider>(
                builder: (context, provider, __) {
                  return Text(
                    provider.currentPrompt,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _textController,
                onChanged: (text) =>
                    context.read<WritingProvider>().updateWordCount(text),
                maxLines: 10,
                minLines: 1,
                style: TextStyle(fontWeight: FontWeight.w500),
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  fillColor: AppColors.primaryContainer.withValues(alpha: .1),
                  filled: true,
                  hintText: "Today i woke up happy...",
                  hintStyle: TextStyle(fontStyle: FontStyle.italic),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Consumer<WritingProvider>(
                builder: (context, provider, __) {
                  return Text(
                    "${provider.wordCount} ${provider.wordCount == 1 ? 'word' : 'words'}",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
