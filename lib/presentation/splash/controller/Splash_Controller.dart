import 'package:get/get.dart';
import '../../../Utils/shared_prehelper.dart';


class SplashController extends GetxController {
  final SharedPrefHelper _prefHelper = SharedPrefHelper();

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

  /// Reads session data and decides where to navigate after splash
  Future<void> _initSession() async {
    // Minimum splash display time
    await Future.delayed(const Duration(milliseconds: 2800));

    // final SplashModel session = await _checkSession();

    // _navigate(session);
  }

  // Future<SplashModel> _checkSession() async {
  //   // final isLoggedIn = await _prefHelper.isLoggedIn();
  //   // final userRole = await _prefHelper.getUserRole();
  //   // final isOnboarded = await _prefHelper.isOnboarded();
  //
  //   // return SplashModel(
  //   //   isLoggedIn: isLoggedIn,
  //   //   userRole: userRole,
  //   //   isOnboarded: isOnboarded,
  //   // );
  // }

  // void _navigate(SplashModel session) {
  //   if (!session.isOnboarded) {
  //     // First-time user → onboarding
  //     Get.offAllNamed(AppRoutes.onboarding);
  //     return;
  //   }
  //
  //   if (!session.isLoggedIn) {
  //     // Not logged in → login
  //     Get.offAllNamed(AppRoutes.login);
  //     return;
  //   }
  //
  //   // Logged in → navigate by role
  //   switch (session.userRole) {
  //     case 'franchise':
  //       Get.offAllNamed(AppRoutes.franchiseDashboard);
  //       break;
  //     case 'delivery':
  //       Get.offAllNamed(AppRoutes.deliveryDashboard);
  //       break;
  //     case 'customer':
  //     default:
  //       Get.offAllNamed(AppRoutes.customerDashboard);
  //       break;
  //   }
  // }
}