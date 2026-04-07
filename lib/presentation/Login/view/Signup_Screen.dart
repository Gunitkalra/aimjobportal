import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
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
                ),
                SizedBox(height: 12),
                _SocialSignupButton(
                  label: 'Sign up with Facebook',
                  icon: const _FacebookIcon(),
                  backgroundColor: const Color(0xFF1877F2),
                  textColor: Colors.white,
                  borderColor: Colors.transparent,
                  onTap: () => controller.loginWithFacebook(),
                ),
                SizedBox(height: 12),
                _SocialSignupButton(
                  label: 'Sign up with LinkedIn',
                  icon: const _LinkedInIcon(),
                  backgroundColor: const Color(0xFF0A66C2),
                  textColor: Colors.white,
                  borderColor: Colors.transparent,
                  onTap: () => controller.loginWithLinkedIn(),
                ),

                SizedBox(height: sh * 0.028),

                // ── Divider ──────────────────────────────────────────
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.line)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or sign up with',
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

                // ── Email / Phone toggle ──────────────────────────────
                Obx(() => Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.appBg1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _ToggleTab(
                        label: 'Email',
                        isActive: !controller.usePhone.value,
                        onTap: () => controller.usePhone.value = false,
                      ),
                      _ToggleTab(
                        label: 'Phone Number',
                        isActive: controller.usePhone.value,
                        onTap: () => controller.usePhone.value = true,
                      ),
                    ],
                  ),
                )),

                SizedBox(height: sh * 0.022),

                // ── Email or Phone input ──────────────────────────────
                Obx(() => controller.usePhone.value
                    ? _buildPhoneField(sh)
                    : _buildEmailField(sh)),

                SizedBox(height: sh * 0.022),

                // ── Password field ───────────────────────────────────
                _FieldLabel(label: 'Password'),
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
                              TextSpan(
                                text: 'Terms of Service',
                                style: const TextStyle(
                                  color: AppColors.darkRed,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: const TextStyle(
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

                // ── Signup button ────────────────────────────────────
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed:
                    controller.isLoading.value ? null : controller.signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkRed,
                      disabledBackgroundColor:
                      AppColors.darkRed.withOpacity(0.6),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
        _FieldLabel(label: 'Email Address'),
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

  Widget _buildPhoneField(double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: 'Phone Number'),
        SizedBox(height: sh * 0.008),
        TextFormField(
          controller: controller.phoneCtrl,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 10,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: _inputDecoration(
            hint: 'Enter 10-digit phone number',
            prefix: Icons.phone_outlined,
          ).copyWith(counterText: ''),
          validator: controller.phoneValidator,
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
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.buttonPrimary, width: 1.5),
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

// ── Toggle tab ────────────────────────────────────────────────────────────────

class _ToggleTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ToggleTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isActive ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isActive
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? AppColors.textPrimary
                    : AppColors.textMuted,
              ),
            ),
          ),
        ),
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

// ── Facebook Icon ─────────────────────────────────────────────────────────────

class _FacebookIcon extends StatelessWidget {
  const _FacebookIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'f',
          style: TextStyle(
            color: Color(0xFF1877F2),
            fontSize: 15,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ),
    );
  }
}

// ── LinkedIn Icon ─────────────────────────────────────────────────────────────

class _LinkedInIcon extends StatelessWidget {
  const _LinkedInIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text(
          'in',
          style: TextStyle(
            color: Color(0xFF0A66C2),
            fontSize: 11,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ),
    );
  }
}

// ── Field label ───────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}