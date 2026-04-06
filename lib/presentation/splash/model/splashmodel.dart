class SplashModel {
  final bool isLoggedIn;
  final String? userRole;
  final bool isOnboarded;

  SplashModel({
    required this.isLoggedIn,
    this.userRole,
    required this.isOnboarded,
  });
}