import 'package:get/get.dart';


import '../presentation/Complete_Profile/Complete_profile_Binding.dart';
import '../presentation/Complete_Profile/view/Complete_profile_Screen.dart';
import '../presentation/Login/Auth_binding.dart';
import '../presentation/Login/view/Login_Screen.dart';
import '../presentation/Login/view/Signup_Screen.dart';
import '../presentation/Onboarding/onboardingBinding.dart';
import '../presentation/Onboarding/view/onboarding_Screen.dart';
import '../presentation/Side_Dashboard/view/Side_dashboard.dart';
import '../presentation/dashboard/Dashboard_Binding.dart';
import '../presentation/dashboard/view/Dashboard_Screen.dart';
import '../presentation/dashboard/view/Job_detail_screen.dart';
import '../presentation/splash/Splash_binding.dart';
import '../presentation/splash/view/Splash_Screen.dart';

class AppRoutes {
  static const String splash          = '/';
  static const String onboarding      = '/onboarding';
  static const String login           = '/login';
  static const String signup          = '/signup';
  static const String completeProfile = '/complete-profile';
  static const String dashboard       = '/dashboard';
  static const String jobDetail       = '/job-detail';
  static const sideDashboard = '/side-dashboard';
  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: completeProfile,
      page: () => const CompleteProfileScreen(),
      binding: CompleteProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: jobDetail,
      page: () => const JobDetailScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: sideDashboard,
      page: () => const SideDashboardScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}