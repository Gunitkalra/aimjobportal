import 'package:get/get.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final SharedPrefHelper _prefHelper = SharedPrefHelper();

  final RxDouble logoOpacity  = 0.0.obs;
  final RxDouble logoScale    = 0.8.obs;
  final RxDouble taglineOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimations();
    _initSession();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    logoOpacity.value = 1.0;
    logoScale.value   = 1.0;
    await Future.delayed(const Duration(milliseconds: 600));
    taglineOpacity.value = 1.0;
  }

  Future<void> _initSession() async {
    // Minimum splash display time
    await Future.delayed(const Duration(milliseconds: 2800));
    await _navigate();
  }

  Future<void> _navigate() async {
    final token            = await _prefHelper.get('token');
    final isOnboarded      = await _prefHelper.get('isOnboarded') ?? false;
    final profileCompleted = await _prefHelper.get('profileCompleted') ?? false;

    // First-time user (never opened onboarding)
    if (isOnboarded != true) {
      Get.offAllNamed(AppRoutes.onboarding);
      return;
    }

    // Has session token
    if (token != null && token.toString().isNotEmpty) {
      if (profileCompleted == true) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        // Logged in but profile not done
        Get.offAllNamed(AppRoutes.completeProfile);
      }
      return;
    }

    // No session → guest mode (go to dashboard instead of login)
    Get.offAllNamed(AppRoutes.dashboard);
  }
}