import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/constant_utils.dart';
import '../../../routes/app_routes.dart';
import '../controller/Auth_Controller.dart';

class SignupScreen extends GetView<AuthController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
          child: Form(
            key: controller.signupFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sh * 0.02),

                // ── Back button ──────────────────────────────────────
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.appBg1,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppColors.textPrimary,
                      size: 18,
                    ),
                  ),
                ),

                SizedBox(height: sh * 0.025),

                // ── Header ───────────────────────────────────────────
                Text(
                  'Create Account ✨',
                  style: TextStyle(
                    fontSize: sw * 0.065,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Join thousands finding their dream jobs',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: sh * 0.032),

                // ── Social signup buttons ─────────────────────────────
                _SocialSignupButton(
                  label: 'Sign up with Google',
                  icon: _GoogleIcon(),
                  backgroundColor: Colors.white,
                  textColor: const Color(0xFF3C4043),
                  borderColor: const Color(0xFFDADCE0),
                  onTap: () => controller.loginWithGoogle(),
                  // onTap: () => controller.loginWithGoogle(),
                ),

                SizedBox(height: sh * 0.028),

                // ── Divider ──────────────────────────────────────────
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.line)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or sign up with email',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.line)),
                  ],
                ),

                SizedBox(height: sh * 0.024),

                // ── Email input (Phone toggle removed) ───────────────
                _buildEmailField(sh),

                SizedBox(height: sh * 0.022),

                // ── Password field ───────────────────────────────────
                Row(
                  children: [
                    _FieldLabel(label: 'Password'),
                    SizedBox(width: 5,),
                    Text(
                      "(min. 8 characters)",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textHint,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.008),
                Obx(() => TextFormField(
                  controller: controller.passwordCtrl,
                  obscureText: controller.hidePassword.value,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                  decoration: _inputDecoration(
                    hint: 'Create a password',
                    prefix: Icons.lock_outline_rounded,
                    suffix: GestureDetector(
                      onTap: controller.togglePassword,
                      child: Icon(
                        controller.hidePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textHint,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: controller.passwordValidator,
                )),

                SizedBox(height: sh * 0.022),

                // ── Confirm password ─────────────────────────────────
                _FieldLabel(label: 'Confirm Password'),
                SizedBox(height: sh * 0.008),
                Obx(() => TextFormField(
                  controller: controller.confirmPasswordCtrl,
                  obscureText: controller.hideConfirmPass.value,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => controller.signup(),
                  style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                  decoration: _inputDecoration(
                    hint: 'Confirm your password',
                    prefix: Icons.lock_outline_rounded,
                    suffix: GestureDetector(
                      onTap: controller.toggleConfirmPassword,
                      child: Icon(
                        controller.hideConfirmPass.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textHint,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: controller.confirmPasswordValidator,
                )),

                SizedBox(height: sh * 0.022),

                // ── Terms checkbox ───────────────────────────────────
                Obx(() => GestureDetector(
                  onTap: () => controller.agreedToTerms.toggle(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(top: 1),
                        decoration: BoxDecoration(
                          color: controller.agreedToTerms.value
                              ? AppColors.darkRed
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: controller.agreedToTerms.value
                                ? AppColors.darkRed
                                : AppColors.textHint,
                            width: 1.5,
                          ),
                        ),
                        child: controller.agreedToTerms.value
                            ? const Icon(Icons.check,
                            size: 13, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to the '),
                              const TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: AppColors.darkRed,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              const TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppColors.darkRed,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

                SizedBox(height: sh * 0.032),

                // ── Signup button inside SignupScreen ────────────────────────────────
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                      // Validate 8-character password and Terms checkbox first
                      if (controller.signupFormKey.currentState!.validate()) {
                        if (!controller.agreedToTerms.value) {
                          showToastFail("Please agree to the Terms of Service.");
                          return;
                        }

                        // Trigger the actual API call
                        controller.sendOtp();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkRed,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Send OTP to verify email',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                )),
                SizedBox(height: sh * 0.028),

                // ── Login link ───────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.darkRed,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: sh * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel(label: 'Email Address'),
        SizedBox(height: sh * 0.008),
        TextFormField(
          controller: controller.emailCtrl,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: _inputDecoration(
            hint: 'Enter your email',
            prefix: Icons.email_outlined,
          ),
          validator: controller.emailValidator,
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefix,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: AppColors.textHint),
      filled: true,
      fillColor: AppColors.appBg1,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: Icon(prefix, color: AppColors.textHint, size: 20),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.darkRed),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.darkRed),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.darkRed, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.textRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.textRed, width: 1.5),
      ),
    );
  }
}

// ── Social signup button ──────────────────────────────────────────────────────

class _SocialSignupButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onTap;

  const _SocialSignupButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Google Icon ───────────────────────────────────────────────────────────────

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;
    final sw = size.width * 0.18;

    void arc(double start, double sweep, Color color) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        start, sweep, false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = sw,
      );
    }

    arc(-0.52, 1.57, const Color(0xFF4285F4));
    arc(-2.09, 1.57, const Color(0xFFEA4335));
    arc(2.62, 1.04, const Color(0xFFFBBC05));
    arc(1.05, 1.57, const Color(0xFF34A853));

    canvas.drawLine(Offset(cx, cy), Offset(cx + r * 0.95, cy),
        Paint()..color = Colors.white..strokeWidth = sw);
    canvas.drawLine(Offset(cx + r * 0.05, cy), Offset(cx + r * 0.95, cy),
        Paint()..color = const Color(0xFF4285F4)..strokeWidth = sw);
  }

  @override
  bool shouldRepaint(_) => false;
}

// ── Field label ───────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}