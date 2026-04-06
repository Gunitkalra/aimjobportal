import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/shared_prehelper.dart';

import '../../../routes/app_routes.dart';
import '../model/onboardingmodel.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  final List<OnboardingModel> pages = const [
    OnboardingModel(
      title: 'Find Your Dream Job',
      subtitle:
      'Browse thousands of job listings from top companies across every industry — all in one place.',
      imagePath: 'assets/images/onboarding_1.png',
    ),
    OnboardingModel(
      title: 'Apply in One Tap',
      subtitle:
      'Build your profile once and apply to multiple jobs instantly with a single tap.',
      imagePath: 'assets/images/onboarding_2.png',
    ),
    OnboardingModel(
      title: 'Get Hired Faster',
      subtitle:
      'Track your applications, get notified on updates, and land your next opportunity sooner.',
      imagePath: 'assets/images/onboarding_3.png',
    ),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) => currentPage.value = index;

  bool get isLastPage => currentPage.value == pages.length - 1;

  void nextPage() {
    if (isLastPage) {
      _finishOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToLogin() => _finishOnboarding();

  Future<void> _finishOnboarding() async {
    // await SharedPrefHelper.ins.markOnboarded();
    Get.offAllNamed(AppRoutes.login);
  }
}