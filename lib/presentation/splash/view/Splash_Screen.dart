// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../routes/app_routes.dart';
// import '../../../Utils/shared_prehelper.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool _hasStartedTimer = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   void _startTimer() {
//     if (_hasStartedTimer) return;
//     _hasStartedTimer = true;
//     Future.delayed(const Duration(seconds: 3), () async {
//       if (mounted) {
//         final prefHelper = SharedPrefHelper();
//         final token = await prefHelper.get('accessToken');
//         final profileCompleted = await prefHelper.get('isProfileComplete') ?? false;
//
//         if (token != null && token.toString().isNotEmpty) {
//           if (profileCompleted == true) {
//             Get.offAllNamed(AppRoutes.dashboard);
//           } else {
//            // Get.offAllNamed(AppRoutes.completeProfile);
//             Get.offAllNamed(AppRoutes.login);
//           }
//           return;
//         }
//
//         Get.offAllNamed(AppRoutes.dashboard);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9FBFF),
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 15),
//                       // Top Pill
//                       Center(child: _buildTopPill()),
//                       const SizedBox(height: 25),
//                       // Logo Section
//                       _buildLogoSection(),
//                       const SizedBox(height: 25),
//                       // Cards Section
//                       _buildCardsSection(),
//                       const SizedBox(height: 25),
//                       // CV Section
//                       _buildCvSection(),
//                       const SizedBox(height: 25),
//                       // Footer Info Section
//                       _buildFooterSection(),
//                       const SizedBox(height: 25),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // Wave Clipper at the very bottom
//             _buildBottomBanner(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTopPill() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blue.withOpacity(0.06),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//         border: Border.all(color: Colors.blue.withOpacity(0.08)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFEAF2FF),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.notifications_active_outlined,
//                   color: Color(0xFF1B73E8),
//                   size: 20,
//                 ),
//               ),
//               Positioned(
//                 right: 2,
//                 top: 2,
//                 child: Container(
//                   width: 8,
//                   height: 8,
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Text(
//                 "New Jobs Daily",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14,
//                   color: Color(0xFF0D2C54),
//                 ),
//               ),
//               Text(
//                 "10,000+ New Opportunities",
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Color(0xFF57636F),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLogoSection() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "AIM J",
//               style: TextStyle(
//                 fontSize: 34,
//                 fontWeight: FontWeight.w900,
//                 color: Color(0xFF0A2B5C),
//                 letterSpacing: -1.0,
//               ),
//             ),
//             Container(
//               width: 28,
//               height: 28,
//               margin: const EdgeInsets.symmetric(horizontal: 1),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: const Color(0xFF0A2B5C), width: 5),
//               ),
//               child: Center(
//                 child: SizedBox(
//                   width: 11,
//                   height: 15,
//                   child: CustomPaint(
//                     painter: TiePainter(color: const Color(0xFF1B73E8)),
//                   ),
//                 ),
//               ),
//             ),
//             const Text(
//               "BS",
//               style: TextStyle(
//                 fontSize: 34,
//                 fontWeight: FontWeight.w900,
//                 color: Color(0xFF0A2B5C),
//                 letterSpacing: -1.0,
//               ),
//             ),
//             const Text(
//               ".AI",
//               style: TextStyle(
//                 fontSize: 34,
//                 fontWeight: FontWeight.w900,
//                 color: Color(0xFF1B73E8),
//                 letterSpacing: -1.0,
//               ),
//             ),
//           ],
//         ),
//         Container(
//           width: 45,
//           height: 3.5,
//           margin: const EdgeInsets.only(top: 8, bottom: 12),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1B73E8),
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         RichText(
//           textAlign: TextAlign.center,
//           text: const TextSpan(
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF0D2C54),
//             ),
//             children: [
//               TextSpan(text: "All India Jobs. "),
//               TextSpan(
//                 text: "One Platform.",
//                 style: TextStyle(color: Color(0xFF1B73E8)),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCardsSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: _buildInfoCard(
//             icon: Icons.business_center_outlined,
//             title: "Top Companies\nHiring",
//             badge: "500+ Companies",
//             isHighlighted: false,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: _buildInfoCard(
//             icon: Icons.apartment_outlined,
//             title: "Latest Job\nUpdates",
//             badge: "Daily Updated",
//             isHighlighted: true,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: _buildInfoCard(
//             icon: Icons.person_outline_rounded,
//             title: "Jobs for Every\nExperience",
//             badge: "Fresher to Expert",
//             isHighlighted: false,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoCard({
//     required IconData icon,
//     required String title,
//     required String badge,
//     required bool isHighlighted,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 6, vertical: isHighlighted ? 22 : 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: isHighlighted ? const Color(0xFF1B73E8).withOpacity(0.3) : Colors.blue.withOpacity(0.08),
//           width: isHighlighted ? 1.5 : 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blue.withOpacity(isHighlighted ? 0.08 : 0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: const Color(0xFFEAF2FF),
//               shape: BoxShape.circle,
//               border: Border.all(color: const Color(0xFF1B73E8).withOpacity(0.1)),
//             ),
//             child: Icon(icon, color: const Color(0xFF1B73E8), size: 24),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF0D2C54),
//               height: 1.3,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             width: 25,
//             height: 1.5,
//             color: Colors.blue.withOpacity(0.15),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             badge,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1B73E8),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCvSection() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blue.withOpacity(0.04),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//         border: Border.all(color: Colors.blue.withOpacity(0.06)),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.chevron_left_rounded,
//                 color: Color(0xFF1B73E8),
//                 size: 20,
//               ),
//               const SizedBox(width: 4),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEAF2FF),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.description_outlined,
//                   color: Color(0xFF1B73E8),
//                   size: 28,
//                 ),
//               ),
//               const SizedBox(width: 4),
//               const Icon(
//                 Icons.chevron_right_rounded,
//                 color: Color(0xFF1B73E8),
//                 size: 20,
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             "Upload Your CV",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF0D2C54),
//             ),
//           ),
//           const SizedBox(height: 4),
//           const Text(
//             "Let top companies find you",
//             style: TextStyle(
//               fontSize: 13,
//               color: Color(0xFF57636F),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton.icon(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF1B73E8),
//               foregroundColor: Colors.white,
//               minimumSize: const Size(double.infinity, 48),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 0,
//             ),
//             icon: const Icon(Icons.upload_rounded, size: 20),
//             label: const Text(
//               "Upload CV",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFooterSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Expanded(
//           child: _buildFooterItem(
//             icon: Icons.notifications_none_rounded,
//             title: "Job Alerts",
//             subtitle: "Stay Updated",
//           ),
//         ),
//         _buildVerticalDivider(),
//         Expanded(
//           child: _buildFooterItem(
//             icon: Icons.send_outlined,
//             title: "Instant Apply",
//             subtitle: "One Click Apply",
//           ),
//         ),
//         _buildVerticalDivider(),
//         Expanded(
//           child: _buildFooterItem(
//             icon: Icons.verified_user_outlined,
//             title: "100% Trusted",
//             subtitle: "Verified Jobs",
//           ),
//         ),
//         _buildVerticalDivider(),
//         Expanded(
//           child: _buildFooterItem(
//             icon: Icons.trending_up_rounded,
//             title: "Build Your",
//             subtitle: "Better Career",
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFooterItem({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(
//             color: Color(0xFFEAF2FF),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: const Color(0xFF1B73E8), size: 20),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           title,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF0D2C54),
//           ),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           subtitle,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 8,
//             color: Color(0xFF57636F),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildVerticalDivider() {
//     return Container(
//       height: 35,
//       width: 1,
//       color: Colors.blue.withOpacity(0.12),
//     );
//   }
//
//   Widget _buildBottomBanner() {
//     return ClipPath(
//       clipper: WaveClipper(),
//       child: Container(
//         width: double.infinity,
//         height: 75,
//         color: const Color(0xFF1B73E8),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Icon(
//                   Icons.verified_outlined,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   "Trusted by Millions of Job Seekers Across India",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TiePainter extends CustomPainter {
//   final Color color;
//   TiePainter({required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     final path = Path();
//     double knotWidth = size.width * 0.4;
//     double knotHeight = size.height * 0.25;
//     double centerX = size.width / 2;
//
//     path.moveTo(centerX - knotWidth / 2, 0);
//     path.lineTo(centerX + knotWidth / 2, 0);
//     path.lineTo(centerX + knotWidth * 0.3, knotHeight);
//     path.lineTo(centerX - knotWidth * 0.3, knotHeight);
//     path.close();
//
//     double tailWidth = size.width * 0.55;
//     path.moveTo(centerX - knotWidth * 0.3, knotHeight);
//     path.lineTo(centerX + knotWidth * 0.3, knotHeight);
//     path.lineTo(centerX + tailWidth / 2, size.height * 0.85);
//     path.lineTo(centerX, size.height);
//     path.lineTo(centerX - tailWidth / 2, size.height * 0.85);
//     path.close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, 30);
//     var firstControlPoint = Offset(size.width / 4, 10);
//     var firstEndPoint = Offset(size.width / 2, 20);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//         firstEndPoint.dx, firstEndPoint.dy);
//
//     var secondControlPoint = Offset(size.width - (size.width / 4), 30);
//     var secondEndPoint = Offset(size.width, 10);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);
//
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../Utils/shared_prehelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasStartedTimer = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    if (_hasStartedTimer) return;
    _hasStartedTimer = true;
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        final prefHelper = SharedPrefHelper();
        final token = await prefHelper.get('accessToken');
        final profileCompleted = await prefHelper.get('isProfileComplete') ?? false;

        if (token != null && token.toString().isNotEmpty) {
          if (profileCompleted == true) {
            Get.offAllNamed(AppRoutes.dashboard);
          } else {
            Get.offAllNamed(AppRoutes.login);
          }
          return;
        }

        Get.offAllNamed(AppRoutes.dashboard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        // 1. Sets the entire screen background to #EEF1FC so the GIF blends in perfectly
        backgroundColor: const Color(0xFFEEF1FC),
        body: SizedBox.expand(
          child: Stack(
            alignment: Alignment.center, // Centers both the image and the text
            children: [

              // 2. The GIF Layer (Centered with side padding)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0), // Adjust this for more/less side space
                child: Image.asset(
                  'assets/splashgif.gif',
                  fit: BoxFit.contain, // Prevents stretching
                ),
              ),

              // 3. The Text Layer (Centered right on top of the GIF)
              // const Text(
              //   'Your App Name',
              //   style: TextStyle(
              //     fontSize: 28,
              //     fontWeight: FontWeight.bold,
              //     color: Color(0xFF1A1A1A), // Dark text that looks good on light blue
              //   ),
              // ),

            ],
          ),
        ),
      );
    //   Scaffold(
    //   body: SizedBox.expand(
    //     child: Image.asset(
    //       'assets/splashgif.gif', // 👈 your image path here
    //       fit: BoxFit.contain,
    //     ),
    //   ),
    // );
  }
}