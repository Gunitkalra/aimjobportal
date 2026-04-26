// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Utils/colors.dart';
// import '../../../routes/app_routes.dart';
// import '../controller/Auth_Controller.dart';
//
// class LoginScreen extends GetView<AuthController> {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final sw = MediaQuery.of(context).size.width;
//     final sh = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
//           child: Form(
//             key: controller.loginFormKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: sh * 0.05),
//
//                 // ── Logo + Header ──────────────────────────────────────
//                 Center(
//                   child: Column(
//                     children: [
//                        Image.asset(
//                         'assets/logo.png',
//                         fit: BoxFit.cover,
//                          height: 50,
//                          width: 200,
//                       ),
//                       // SizedBox(height: sh * 0.022),
//                       Text(
//                         'Welcome Back 👋',
//                         style: TextStyle(
//                           fontSize: sw * 0.055,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       Text(
//                         'Login to continue your job search',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: sh * 0.04),
//
//                 // ── Social Login Buttons ─────────────────────────────
//                 _SocialLoginButton(
//                   label: 'Continue with Google',
//                   icon: _GoogleIcon(),
//                   backgroundColor: Colors.white,
//                   textColor: const Color(0xFF3C4043),
//                   borderColor: const Color(0xFFDADCE0),
//                   onTap: () => controller.loginWithGoogle(),
//                 ),
//                 SizedBox(height: 12),
//                 // _SocialLoginButton(
//                 //   label: 'Continue with Facebook',
//                 //   icon: const _FacebookIcon(),
//                 //   backgroundColor: const Color(0xFF1877F2),
//                 //   textColor: Colors.white,
//                 //   borderColor: Colors.transparent,
//                 //   onTap: () => controller.loginWithFacebook(),
//                 // ),
//                 // SizedBox(height: 12),
//                 // _SocialLoginButton(
//                 //   label: 'Continue with LinkedIn',
//                 //   icon: const _LinkedInIcon(),
//                 //   backgroundColor: const Color(0xFF0A66C2),
//                 //   textColor: Colors.white,
//                 //   borderColor: Colors.transparent,
//                 //   onTap: () => controller.loginWithLinkedIn(),
//                 // ),
//                 //
//                 // SizedBox(height: sh * 0.028),
//
//                 // ── Divider ──────────────────────────────────────────
//                 Row(
//                   children: [
//                     const Expanded(child: Divider(color: AppColors.line)),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: Text(
//                         'or login with email',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: AppColors.textMuted,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     const Expanded(child: Divider(color: AppColors.line)),
//                   ],
//                 ),
//
//                 SizedBox(height: sh * 0.028),
//
//                 // ── Email field ──────────────────────────────────────
//                 _FieldLabel(label: 'Email Address'),
//                 SizedBox(height: sh * 0.008),
//                 TextFormField(
//                   controller: controller.emailCtrl,
//                   keyboardType: TextInputType.emailAddress,
//                   textInputAction: TextInputAction.next,
//                   style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//                   decoration: _inputDecoration(
//                     hint: 'Enter your email',
//                     prefix: Icons.email_outlined,
//                   ),
//                   validator: controller.emailValidator,
//                 ),
//
//                 SizedBox(height: sh * 0.022),
//
//                 // ── Password field ───────────────────────────────────
//                 _FieldLabel(label: 'Password'),
//                 SizedBox(height: sh * 0.008),
//                 Obx(() => TextFormField(
//                   controller: controller.passwordCtrl,
//                   obscureText: controller.hidePassword.value,
//                   textInputAction: TextInputAction.done,
//                   onFieldSubmitted: (_) => controller.login(),
//                   style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//                   decoration: _inputDecoration(
//                     hint: 'Enter your password',
//                     prefix: Icons.lock_outline_rounded,
//                     suffix: GestureDetector(
//                       onTap: controller.togglePassword,
//                       child: Icon(
//                         controller.hidePassword.value
//                             ? Icons.visibility_off_outlined
//                             : Icons.visibility_outlined,
//                         color: AppColors.textHint,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   validator: controller.passwordValidator,
//                 )),
//
//                 SizedBox(height: sh * 0.012),
//
//                 // ── Forgot password ──────────────────────────────────
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
//                     style: TextButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       minimumSize: const Size(0, 0),
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     ),
//                     child: Text(
//                       'Forgot Password?',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: AppColors.darkRed,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: sh * 0.032),
//
//                 // ── Login button ─────────────────────────────────────
//                 Obx(() => SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: ElevatedButton(
//                     onPressed:
//                     controller.isLoading.value ? null : controller.login,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.darkRed,
//                       disabledBackgroundColor:
//                       AppColors.darkRed.withOpacity(0.6),
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                     ),
//                     child: controller.isLoading.value
//                         ? const SizedBox(
//                       width: 22,
//                       height: 22,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2.5,
//                         color: AppColors.white,
//                       ),
//                     )
//                         : const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 )),
//
//                 SizedBox(height: sh * 0.032),
//
//                 // ── Sign up link ─────────────────────────────────────
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don't have an account? ",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Get.toNamed(AppRoutes.signup),
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.darkRed,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: sh * 0.03),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration({
//     required String hint,
//     required IconData prefix,
//     Widget? suffix,
//   }) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(fontSize: 14, color: AppColors.textHint),
//       filled: true,
//       fillColor: AppColors.appBg1,
//       contentPadding:
//       const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       prefixIcon: Icon(prefix, color: AppColors.textHint, size: 20),
//       suffixIcon: suffix,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.darkRed),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.darkRed),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.darkRed, width: 1.5),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.textRed),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.textRed, width: 1.5),
//       ),
//     );
//   }
// }
//
// // ── Social login button ───────────────────────────────────────────────────────
//
// class _SocialLoginButton extends StatelessWidget {
//   final String label;
//   final Widget icon;
//   final Color backgroundColor;
//   final Color textColor;
//   final Color borderColor;
//   final VoidCallback onTap;
//
//   const _SocialLoginButton({
//     required this.label,
//     required this.icon,
//     required this.backgroundColor,
//     required this.textColor,
//     required this.borderColor,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 52,
//       child: Material(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(14),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(14),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(color: borderColor, width: 1.5),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 icon,
//                 const SizedBox(width: 10),
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: textColor,
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
// // ── Google Icon (colored) ─────────────────────────────────────────────────────
//
// class _GoogleIcon extends StatelessWidget {
//   const _GoogleIcon();
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 22,
//       height: 22,
//       child: CustomPaint(painter: _GoogleLogoPainter()),
//     );
//   }
// }
//
// class _GoogleLogoPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double cx = size.width / 2;
//     final double cy = size.height / 2;
//     final double r = size.width / 2;
//
//     // Blue arc (right top)
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(cx, cy), radius: r),
//       -0.52,
//       1.57,
//       false,
//       Paint()
//         ..color = const Color(0xFF4285F4)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = size.width * 0.18,
//     );
//     // Red arc (left top)
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(cx, cy), radius: r),
//       -2.09,
//       1.57,
//       false,
//       Paint()
//         ..color = const Color(0xFFEA4335)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = size.width * 0.18,
//     );
//     // Yellow arc (left bottom)
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(cx, cy), radius: r),
//       2.62,
//       1.04,
//       false,
//       Paint()
//         ..color = const Color(0xFFFBBC05)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = size.width * 0.18,
//     );
//     // Green arc (right bottom)
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(cx, cy), radius: r),
//       1.05,
//       1.57,
//       false,
//       Paint()
//         ..color = const Color(0xFF34A853)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = size.width * 0.18,
//     );
//     // White horizontal bar (G cutout)
//     final barPaint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = size.width * 0.18;
//     canvas.drawLine(
//       Offset(cx, cy),
//       Offset(cx + r * 0.95, cy),
//       barPaint,
//     );
//     // Blue bar refill
//     final bluePaint = Paint()
//       ..color = const Color(0xFF4285F4)
//       ..strokeWidth = size.width * 0.18;
//     canvas.drawLine(
//       Offset(cx + r * 0.05, cy),
//       Offset(cx + r * 0.95, cy),
//       bluePaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(_) => false;
// }
//
// // ── Facebook Icon ─────────────────────────────────────────────────────────────
//
// class _FacebookIcon extends StatelessWidget {
//   const _FacebookIcon();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 22,
//       height: 22,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//       ),
//       child: const Center(
//         child: Text(
//           'f',
//           style: TextStyle(
//             color: Color(0xFF1877F2),
//             fontSize: 15,
//             fontWeight: FontWeight.w900,
//             height: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ── LinkedIn Icon ─────────────────────────────────────────────────────────────
//
// class _LinkedInIcon extends StatelessWidget {
//   const _LinkedInIcon();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 22,
//       height: 22,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: const Center(
//         child: Text(
//           'in',
//           style: TextStyle(
//             color: Color(0xFF0A66C2),
//             fontSize: 11,
//             fontWeight: FontWeight.w900,
//             height: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ── Field label ───────────────────────────────────────────────────────────────
//
// class _FieldLabel extends StatelessWidget {
//   final String label;
//   const _FieldLabel({required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label,
//       style: const TextStyle(
//         fontSize: 14,
//         color: AppColors.textPrimary,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../controller/Auth_Controller.dart';

// ── Primary blue accent used throughout this screen ───────────────────────────
const _kBlue = Color(0xFF1A56DB);
const _kBlueSoft = Color(0xFFEFF6FF); // avatar bg & banner bg
const _kBorder = Color(0xFFE2E8F0); // input / button border
const _kBg = Color(0xFFF8FAFC); // input fill
const _kTextPrimary = Color(0xFF111827);
const _kTextSecondary = Color(0xFF6B7280);

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sh * 0.05),

                // ── Avatar + Header ────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      // Circular avatar icon
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: _kBlueSoft,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.darkRed,
                          size: 32,
                        ),
                      ),
                      SizedBox(height: sh * 0.018),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: sw * 0.058,
                          fontWeight: FontWeight.w800,
                          color: _kTextPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Sign in to your AimJobs account',
                        style: TextStyle(
                          fontSize: 14,
                          color: _kTextSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: sh * 0.03),

                // ── Sign-up banner ─────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _kBlueSoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 13.5,
                          color: _kTextSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signup),
                        child: const Text(
                          'Sign up here',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: AppColors.darkRed,
                            fontWeight: FontWeight.w700,
                            // decoration: TextDecoration.underline,
                            decorationColor: _kBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: sh * 0.03),

                // ── "Sign in with" label ───────────────────────────────
                const Text(
                  'Sign in with',
                  style: TextStyle(
                    fontSize: 13,
                    color: _kTextSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 10),

                // ── Social Buttons ─────────────────────────────────────
                _SocialLoginButton(
                  label: 'Continue with Google',
                  icon: const _GoogleIcon(),
                  onTap: () => controller.loginWithGoogle(),
                ),
                const SizedBox(height: 10),
                _SocialLoginButton(
                  label: 'Continue with LinkedIn',
                  icon: const _LinkedInIcon(),
                  onTap: () => controller.loginWithLinkedIn(),
                ),
                const SizedBox(height: 10),
                _SocialLoginButton(
                  label: 'Continue with Facebook',
                  icon: const _FacebookIcon(),
                  onTap: () => controller.loginWithFacebook(),
                ),

                SizedBox(height: sh * 0.026),

                // ── "or" Divider ───────────────────────────────────────
                const Row(
                  children: [
                    Expanded(child: Divider(color: _kBorder, thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: 13,
                          color: _kTextSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: _kBorder, thickness: 1)),
                  ],
                ),

                SizedBox(height: sh * 0.022),

                // ── "Sign in with email" label ─────────────────────────
                const Text(
                  'Sign in with email',
                  style: TextStyle(
                    fontSize: 13,
                    color: _kTextSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: sh * 0.018),

                // ── Email field ────────────────────────────────────────
                const _FieldLabel(label: 'Email address'),
                const SizedBox(height: 6),
                TextFormField(
                  controller: controller.emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontSize: 14, color: _kTextPrimary),
                  decoration: _inputDecoration(
                    hint: 'you@example.com',
                    prefix: Icons.mail_outline_rounded,
                  ),
                  validator: controller.emailValidator,
                ),

                SizedBox(height: sh * 0.02),

                // ── Password field ─────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _FieldLabel(label: 'Password'),
                    TextButton(
                      onPressed: () =>
                          Get.toNamed(AppRoutes.forgotPassword),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.darkRed,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Obx(() => TextFormField(
                  controller: controller.passwordCtrl,
                  obscureText: controller.hidePassword.value,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => controller.login(),
                  style: const TextStyle(
                      fontSize: 14, color: _kTextPrimary),
                  decoration: _inputDecoration(
                    hint: 'Enter your password',
                    prefix: Icons.lock_outline_rounded,
                    suffix: GestureDetector(
                      onTap: controller.togglePassword,
                      child: Icon(
                        controller.hidePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: _kTextSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: controller.passwordValidator,
                )),

                SizedBox(height: sh * 0.032),

                // ── Sign in button ─────────────────────────────────────
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.login,
                    icon: controller.isLoading.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                        : const Icon(
                      Icons.login_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: controller.isLoading.value
                        ? const SizedBox.shrink()
                        : const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkRed,
                      disabledBackgroundColor:
                      AppColors.darkRed,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )),

                SizedBox(height: sh * 0.028),

                // ── Terms text ─────────────────────────────────────────
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 12,
                        color: _kTextSecondary,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                            text: 'By continuing, you agree to AimJobs\' '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: const TextStyle(
                            // color: _kBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: '\nand '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            // color: _kBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: sh * 0.04),
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
      hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFADB5BD)),
      filled: true,
      fillColor: _kBg,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      prefixIcon: Icon(prefix, color: _kTextSecondary, size: 20),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _kBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _kBlue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
      ),
    );
  }
}

// ── Unified Social Login Button ───────────────────────────────────────────────
// All three social buttons share the same look: white bg, light border.

class _SocialLoginButton extends StatelessWidget {
  final String label;
  final Widget icon;
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
      height: 50,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kBorder, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: _kTextPrimary,
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

// ── Google Icon (colored circles) ────────────────────────────────────────────

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
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = size.width / 2;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -0.52, 1.57, false,
      Paint()
        ..color = const Color(0xFF4285F4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -2.09, 1.57, false,
      Paint()
        ..color = const Color(0xFFEA4335)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      2.62, 1.04, false,
      Paint()
        ..color = const Color(0xFFFBBC05)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      1.05, 1.57, false,
      Paint()
        ..color = const Color(0xFF34A853)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18,
    );
    canvas.drawLine(Offset(cx, cy), Offset(cx + r * 0.95, cy),
        Paint()..color = Colors.white..strokeWidth = size.width * 0.18);
    canvas.drawLine(Offset(cx + r * 0.05, cy), Offset(cx + r * 0.95, cy),
        Paint()..color = const Color(0xFF4285F4)..strokeWidth = size.width * 0.18);
  }

  @override
  bool shouldRepaint(_) => false;
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
        color: const Color(0xFF0A66C2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text(
          'in',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ),
    );
  }
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
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'f',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
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
        color: _kTextPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}