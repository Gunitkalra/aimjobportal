import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/colors.dart';
import '../controller/Splash_Controller.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    // Responsive sizes using MediaQuery
    final double logoSize = screenWidth * 0.45; // 45% of screen width
    final double taglineFontSize = screenWidth * 0.038;
    final double appNameFontSize = screenWidth * 0.068;
    final double bottomPadding = screenHeight * 0.06;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              // ── Center content: logo + name + tagline ──────────────────────
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo with fade + scale animation
                    Obx(() => AnimatedOpacity(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      opacity: controller.logoOpacity.value,
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOutBack,
                        scale: controller.logoScale.value,
                        child: _LogoWidget(size: logoSize),
                      ),
                    )),

                    SizedBox(height: screenHeight * 0.03),

                    // App name
                    Obx(() => AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOut,
                      opacity: controller.logoOpacity.value,
                      child: Text(
                        'AimJobs',
                        style: TextStyle(
                          fontSize: appNameFontSize,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    )),

                    SizedBox(height: screenHeight * 0.012),

                    // Tagline with delayed fade
                    Obx(() => AnimatedOpacity(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeIn,
                      opacity: controller.taglineOpacity.value,
                      child: Text(
                        'Your career starts here',
                        style: TextStyle(
                          fontSize: taglineFontSize,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.4,
                        ),
                      ),
                    )),
                  ],
                ),
              ),

              // ── Bottom loading indicator ───────────────────────────────────
              Positioned(
                bottom: bottomPadding,
                left: 0,
                right: 0,
                child: Obx(() => AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: controller.taglineOpacity.value,
                  child: const _LoadingDots(),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Logo widget ────────────────────────────────────────────────────────────────

class _LogoWidget extends StatelessWidget {
  final double size;

  const _LogoWidget({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.appBg1,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonPrimary.withOpacity(0.12),
            blurRadius: 30,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: EdgeInsets.all(size * 0.15),
          // ── Replace with your actual asset image ──────────────────────────
          // child: Image.asset(
          //   'assets/images/logo.png',
          //   fit: BoxFit.contain,
          // ),
          child: _PlaceholderLogo(size: size),
        ),
      ),
    );
  }
}

/// Temporary placeholder — replace with Image.asset once you add your logo
class _PlaceholderLogo extends StatelessWidget {
  final double size;

  const _PlaceholderLogo({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.buttonPrimary,
            AppColors.textPrimary,
          ],
        ),
      ),
      child: Center(
        child: Text(
          'AJ',
          style: TextStyle(
            color: AppColors.white,
            fontSize: size * 0.28,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

// ── Animated loading dots ──────────────────────────────────────────────────────

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double dotSize = MediaQuery.of(context).size.width * 0.022;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animController,
          builder: (_, __) {
            // Offset animation phase per dot
            final double phase = (_animController.value - index * 0.2).clamp(0.0, 1.0);
            final double opacity = (phase < 0.5)
                ? phase * 2
                : (1 - phase) * 2;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: dotSize * 0.5),
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: AppColors.buttonPrimary.withOpacity(opacity.clamp(0.2, 1.0)),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}