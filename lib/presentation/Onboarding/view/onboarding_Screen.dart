import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/colors.dart';
import '../controller/onboardingController.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Skip button ──────────────────────────────────────────────
            Align(
              alignment: Alignment.centerRight,
              child: Obx(() => controller.isLastPage
                  ? const SizedBox(height: 48)
                  : TextButton(
                onPressed: controller.skipToLogin,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.darkRed,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
            ),

            // ── PageView ─────────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.pages.length,
                itemBuilder: (_, i) =>
                    _OnboardingPage(model: controller.pages[i], sw: sw, sh: sh),
              ),
            ),

            // ── Dot indicator ────────────────────────────────────────────
            Obx(() => _DotIndicator(
              count: controller.pages.length,
              current: controller.currentPage.value,
            )),

            SizedBox(height: sh * 0.04),

            // ── Primary button ───────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
              child: Obx(() => _PrimaryButton(
                label: controller.isLastPage ? 'Get Started' : 'Next',
                onTap: controller.nextPage,
              )),
            ),

            SizedBox(height: sh * 0.05),
          ],
        ),
      ),
    );
  }
}

// ── Single onboarding page ───────────────────────────────────────────────────

class _OnboardingPage extends StatelessWidget {
  final dynamic model; // Changed to dynamic since model class wasn't provided
  final double sw;
  final double sh;

  const _OnboardingPage({
    required this.model,
    required this.sw,
    required this.sh,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.07),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Illustration area ──────────────────────────────────────────
          Container(
            width:  sw * 0.72,
            height: sw * 0.72,
            decoration: BoxDecoration(
              color: AppColors.appBgBanner,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Padding(
                padding: EdgeInsets.all(sw * 0.08),
                child: _IllustrationPlaceholder(imagePath: model.imagePath),
              ),
            ),
          ),

          SizedBox(height: sh * 0.05),

          // ── Title ──────────────────────────────────────────────────────
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: sh * 0.018),

          // ── Subtitle ───────────────────────────────────────────────────
          Text(
            model.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Illustration placeholder (remove once real assets are added) ─────────────

class _IllustrationPlaceholder extends StatelessWidget {
  final String imagePath;
  const _IllustrationPlaceholder({required this.imagePath});

  IconData get _icon {
    if (imagePath.contains('1')) return Icons.work_outline_rounded;
    if (imagePath.contains('2')) return Icons.send_rounded;
    return Icons.verified_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.buttonPrimary.withOpacity(0.15),
            AppColors.textPrimary.withOpacity(0.08),
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          _icon,
          size: MediaQuery.of(context).size.width * 0.18,
          color: AppColors.buttonPrimary,
        ),
      ),
    );
  }
}

// ── Dot indicator ────────────────────────────────────────────────────────────

class _DotIndicator extends StatelessWidget {
  final int count;
  final int current;
  const _DotIndicator({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width:  isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.darkRed
                : AppColors.buttonPrimary.withOpacity(0.25),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// ── Primary button ───────────────────────────────────────────────────────────

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkRed,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}