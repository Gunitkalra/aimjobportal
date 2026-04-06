import 'package:get/get.dart';

import '../presentation/splash/Splash_binding.dart';
import '../presentation/splash/view/Splash_Screen.dart';



class AppRoutes {
//   // Route constants
  static const String splash = '/';
//   static const String initial = '/';
//   static const String productDetail = '/product-detail-screen';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
//     GetPage(
//       name: initial,
//       page: () => const SplashScreen(),
//       transition: Transition.fade,
//     ),
//     GetPage(
//       name: productDetail,
//       page: () => const ProductDetailScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: splash,
//       page: () => const SplashScreen(),
//       transition: Transition.fade,
//     ),
//     GetPage(
//       name: customerDashboard,
//       page: () => const CustomerDashboard(),
//       transition: Transition.fadeIn,
//     ),
//     GetPage(
//       name: login,
//       page: () => const LoginScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: signup,
//       page: () => const SignupScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: onboardingFlow,
//       page: () => const OnboardingFlow(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: otpVerification,
//       page: () => const OTPVerificationScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: profileScreen,
//       page: () => const ProfileScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: editProfileScreen,
//       page: () => const EditProfileScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: subscrptionplanscreen,
//       page: () =>  SubscriptionPlansPage(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: subscriptionHistoryScreen,
//       page: () => const SubscriptionHistoryScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: aboutUsScreen,
//       page: () => const AboutUsScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: favoritesScreen,
//       page: () => const FavoritesScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: notificationsScreen,
//       page: () => const NotificationsScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: cartScreen,
//       page: () =>  CartScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: ordersScreen,
//       page: () => const OrdersScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: outletselection,
//       page: () => const OutletLocationScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: galleryScreen,
//       page: () => const GalleryScreen(),
//       transition: Transition.rightToLeft,
//     ),
//
//     GetPage(
//       name: franchiseOnboarding,
//       page: () => const FranchiseOnboardingScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: franchiseDashboard,
//       page: () => const FranchiseDashboard(),
//       transition: Transition.fadeIn,
//     ),
// //////////
//     GetPage(
//       name: allCustomersScreen,
//       page: () => const AllCustomersScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: allDeliveryBoysScreen,
//       page: () => const AllDeliveryBoysScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     // New franchise product management screens
//     GetPage(
//       name: allProductsScreen,
//       page: () =>  AllProductsScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: franchiseProductDetailScreen,
//       page: () => const FranchiseProductDetailScreen(),
//       transition: Transition.rightToLeft,
//     ),
//
// // NEW: Franchise notifications and reports
//     GetPage(
//       name: franchiseNotificationsScreen,
//       page: () => const FranchiseNotificationsScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: franchiseReportsScreen,
//       page: () => const FranchiseReportsScreen(),
//       transition: Transition.rightToLeft,
//     ),
//
//     GetPage(
//       name: franchiseOrdersScreen,
//       page: () => const FranchiseOrdersScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: franchiseOrderDetailScreen,
//       page: () => const FranchiseOrderDetailScreen(),
//       transition: Transition.rightToLeft,
//     ),
//
//     GetPage(
//       name: franchiseProfileScreen,
//       page: () => const FranchiseProfileScreen(),
//       transition: Transition.rightToLeft,
//     ),
//
//     GetPage(
//       name: franchiseReceivedPaintingsScreen,
//       page: () => const FranchiseReceivedPaintingsScreen(),
//       transition: Transition.rightToLeft,
//     ),
//
// // Delivery Boy routes
//     GetPage(
//       name: deliveryBoyOnboarding,
//       page: () => const DeliveryBoyOnboardingScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: deliveryBoyDashboard,
//       page: () => const DeliveryBoyDashboard(),
//       transition: Transition.fadeIn,
//     ),
//     GetPage(
//       name: deliveryProfileScreen,
//       page: () => const DeliveryProfileScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: deliveryBoyOrders,
//       page: () => const DeliveryBoyOrdersScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: deliveryBoyOrderDetail,
//       page: () => const DeliveryBoyOrderDetailScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: deliveryBoynotification,
//       page: () => const DeliveryBoyNotificationScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: deliveryBoyDeliveredOrdersScreen,
//       page: () => const DeliveryBoyDeliveredOrdersScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: deliveryBoyDeliveredOrderDetailsScreen,
//       page: () => const DeliveryBoyDeliveredOrderDetailsScreen(),
//       transition: Transition.rightToLeft,
//     ),
//
//     GetPage(
//       name: deliveryBoyReturnedOrders,
//       page: () => const DeliveryBoyReturnedOrdersScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: deliveryBoyReturnedOrderDetails,
//       page: () => const DeliveryBoyReturnedOrderDetailsScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: deliveryBoyOtpVerification,
//       page: () => const DeliveryBoyOtpVerificationScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: franchiseRecivedProductDetailScreen,
//       page: () => const FranchiseRecivedProductDetailScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: ReportDetail,
//       page: () => const FranchiseReportDetailScreen(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: managecustomersubscription,
//       page: () => const ManageCustomerSubscription(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: managecustomerprofile,
//       page: () => const ManageCustomerProfile(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: activityadmindamagrpaintingreport,
//       page: () => const ActivityAdminDamagePaintingReport(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: activityadmindamagrpaintingwisereport,
//       page: () => const ActivityAdminDamagePaintingwiseReport(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: Supportrequest,
//       page: () => const SupportRequestsScreen(),
//       transition: Transition.rightToLeft,
//     ),
  ];

}




