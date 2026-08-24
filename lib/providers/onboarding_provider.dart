import 'package:flutter/material.dart';
import 'package:oneminute/core/constants/image_constants.dart';
import 'package:oneminute/models/onboarding.dart';

class OnboardingViewModel with ChangeNotifier {
  final PageController controller = PageController();
  final List<OnboardingPageObj> _onboardings = [
    OnboardingPageObj(
      imagePath: ImageConstants.onboarding1,
      title: "Your thoughts",
      subtitle: "Just one minute.",
    ),
    OnboardingPageObj(
      imagePath: ImageConstants.onboarding2,
      title: "No pressure to write pages",
      subtitle: "Just start writing.",
    ),
    OnboardingPageObj(
      imagePath: ImageConstants.onboarding3,
      title: "One minute a day",
      subtitle: "A lifetime of memories.",
    ),
  ];
  int currentPage = 0;

  onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }

  bool get endOfPage => currentPage == length - 1;

  int get length => _onboardings.length;
  OnboardingPageObj get onboarding => _onboardings[currentPage];

  nextPage() {
    controller.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
  }
}
