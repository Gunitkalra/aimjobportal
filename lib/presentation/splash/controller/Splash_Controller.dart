import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  // Animation state observables
  final RxDouble logoOpacity = 0.0.obs;
  final RxDouble logoScale = 0.8.obs;
  final RxDouble taglineOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimations();
    _initSession();
  }

  /// Triggers logo + tagline animations in sequence
  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    logoOpacity.value = 1.0;
    logoScale.value = 1.0;

    await Future.delayed(const Duration(milliseconds: 600));
    taglineOpacity.value = 1.0;
  }

  /// Simply waits for animations and then moves to onboarding
  Future<void> _initSession() async {
    // Wait 3 seconds so the user can see your splash screen animations
    await Future.delayed(const Duration(milliseconds: 3000));

    // Direct navigation to onboarding
    Get.offAllNamed(AppRoutes.onboarding);
  }
}