import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../controller/Auth_Controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  // Define the red color to be used consistently
  static const Color brandRed = Colors.red;

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
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sh * 0.06),

                // ── Header ───────────────────────────────────────────────
                const Text(
                  'Welcome Back 👋',
                  style: TextStyle(
                    fontSize: 24, // Increased size for header
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: sh * 0.008),
                const Text(
                  'Login to continue your job search',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: sh * 0.048),

                // ── Email field ──────────────────────────────────────────
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

                SizedBox(height: sh * 0.022),

                // ── Password field ───────────────────────────────────────
                const _FieldLabel(label: 'Password'),
                SizedBox(height: sh * 0.008),
                Obx(() => TextFormField(
                  controller: controller.passwordCtrl,
                  obscureText: controller.hidePassword.value,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => controller.login(),
                  style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                  decoration: _inputDecoration(
                    hint: 'Enter your password',
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

                SizedBox(height: sh * 0.012),

                // ── Forgot password (Red Color) ──────────────────────────
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Navigate to forgot password screen
                      // Get.toNamed(AppRoutes.forgotPassword);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkRed, // Red Color
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: sh * 0.04),

                // ── Login button (Red Color) ─────────────────────────────
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkRed, // Red Color
                      disabledBackgroundColor: brandRed.withOpacity(0.6),
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
                        color: AppColors.white,
                      ),
                    )
                        : const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),

                SizedBox(height: sh * 0.04),

                // ── Divider ──────────────────────────────────────────────
                const Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.line)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR CONTINUE WITH',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.line)),
                  ],
                ),

                SizedBox(height: sh * 0.03),

                // ── Social Logins (Google, LinkedIn, Facebook) ───────────
                // inside LoginScreen Column...

// ── Social Logins (Now triggering real login pages) ───────────
                _SocialLoginButton(
                  label: 'Continue with Google',
                  icon: Icons.g_mobiledata_rounded,
                  onTap: () => controller.loginWithGoogle(), // Calls the Google Auth logic
                ),
                SizedBox(height: sh * 0.015),
                _SocialLoginButton(
                  label: 'Continue with LinkedIn',
                  icon: Icons.business_center_rounded,
                  onTap: () => controller.loginWithLinkedIn(),
                ),
                SizedBox(height: sh * 0.015),
                _SocialLoginButton(
                  label: 'Continue with Facebook',
                  icon: Icons.facebook_rounded,
                  onTap: () => controller.loginWithFacebook(),
                ),
                SizedBox(height: sh * 0.04),

                // ── Sign up link ─────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.signup),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.darkRed, // Red Color
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.03),
              ],
            ),
          ),
        ),
      ),
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
      fillColor: Colors.grey[50], // Light grey instead of black for better contrast
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        borderSide: const BorderSide(color: brandRed, width: 1.5),
      ),
    );
  }
}

// ── Social Login Button Helper ───────────────────────────────────────────────
class _SocialLoginButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SocialLoginButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 24, color: AppColors.textPrimary),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.line, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

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