import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../controller/Auth_Controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

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
                Text(
                  'Welcome Back 👋',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: sh * 0.008),
                Text(
                  'Login to continue your job search',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: sh * 0.048),

                // ── Email field ──────────────────────────────────────────
                _FieldLabel(label: 'Email Address'),
                SizedBox(height: sh * 0.008),
                TextFormField(
                  controller:   controller.emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                  decoration: _inputDecoration(
                    hint:   'Enter your email',
                    prefix: Icons.email_outlined,
                  ),
                  validator: controller.emailValidator,
                ),

                SizedBox(height: sh * 0.022),

                // ── Password field ───────────────────────────────────────
                _FieldLabel(label: 'Password'),
                SizedBox(height: sh * 0.008),
                Obx(() => TextFormField(
                  controller:     controller.passwordCtrl,
                  obscureText:    controller.hidePassword.value,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => controller.login(),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                  decoration: _inputDecoration(
                    hint:   'Enter your password',
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

                // ── Forgot password ──────────────────────────────────────
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: navigate to forgot password screen
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.buttonPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: sh * 0.04),

                // ── Login button ─────────────────────────────────────────
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      disabledBackgroundColor:
                      AppColors.buttonPrimary.withOpacity(0.6),
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
                        : Text('Login',  style: TextStyle(
                      fontSize: 14,)),
                  ),
                )),

                SizedBox(height: sh * 0.028),

                // ── Divider ──────────────────────────────────────────────
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.line)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.line)),
                  ],
                ),

                SizedBox(height: sh * 0.028),

                // ── Google sign in (placeholder) ─────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: implement Google sign-in
                    },
                    icon: const Icon(
                      Icons.g_mobiledata_rounded,
                      size: 26,
                      color: AppColors.textPrimary,
                    ),
                    label: Text(
                      'Continue with Google',
                      style: TextStyle(
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
                ),

                SizedBox(height: sh * 0.04),

                // ── Sign up link ─────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.signup),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.buttonPrimary,
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
      hintStyle: TextStyle(fontSize: 15),
      filled: true,
      fillColor: AppColors.black,
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
        borderSide:
        const BorderSide(color: AppColors.buttonPrimary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide:  BorderSide(color: AppColors.black),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.black, width: 1.5),
      ),
    );
  }
}

// ── Small label above fields ─────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}