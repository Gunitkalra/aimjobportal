import 'package:get/get.dart';
// import '../controller/onboarding_controller.dart';
import 'controller/onboardingController.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}