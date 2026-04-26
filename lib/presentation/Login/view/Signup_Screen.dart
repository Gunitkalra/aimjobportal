// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../../../Utils/colors.dart';
// import '../../../Utils/constant_utils.dart';
// import '../../../routes/app_routes.dart';
// import '../controller/Auth_Controller.dart';
//
// class SignupScreen extends GetView<AuthController> {
//   const SignupScreen({super.key});
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
//             key: controller.signupFormKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: sh * 0.02),
//
//                 // ── Back button ──────────────────────────────────────
//                 GestureDetector(
//                   onTap: () => Get.back(),
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: AppColors.appBg1,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back_ios_rounded,
//                       color: AppColors.textPrimary,
//                       size: 18,
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: sh * 0.025),
//
//                 // ── Header ───────────────────────────────────────────
//                 Text(
//                   'Create Account ✨',
//                   style: TextStyle(
//                     fontSize: sw * 0.065,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Text(
//                   'Join thousands finding their dream jobs',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//
//                 SizedBox(height: sh * 0.032),
//
//                 // ── Social signup buttons ─────────────────────────────
//                 _SocialSignupButton(
//                   label: 'Sign up with Google',
//                   icon: _GoogleIcon(),
//                   backgroundColor: Colors.white,
//                   textColor: const Color(0xFF3C4043),
//                   borderColor: const Color(0xFFDADCE0),
//                   onTap: () => controller.loginWithGoogle(),
//                   // onTap: () => controller.loginWithGoogle(),
//                 ),
//
//                 SizedBox(height: sh * 0.028),
//
//                 // ── Divider ──────────────────────────────────────────
//                 Row(
//                   children: [
//                     const Expanded(child: Divider(color: AppColors.line)),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: Text(
//                         'or sign up with email',
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
//                 SizedBox(height: sh * 0.024),
//
//                 // ── Email input (Phone toggle removed) ───────────────
//                 _buildEmailField(sh),
//
//                 SizedBox(height: sh * 0.022),
//
//                 // ── Password field ───────────────────────────────────
//                 Row(
//                   children: [
//                     _FieldLabel(label: 'Password'),
//                     SizedBox(width: 5,),
//                     Text(
//                       "(min. 8 characters)",
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: AppColors.textHint,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: sh * 0.008),
//                 Obx(() => TextFormField(
//                   controller: controller.passwordCtrl,
//                   obscureText: controller.hidePassword.value,
//                   textInputAction: TextInputAction.next,
//                   style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//                   decoration: _inputDecoration(
//                     hint: 'Create a password',
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
//                 SizedBox(height: sh * 0.022),
//
//                 // ── Confirm password ─────────────────────────────────
//                 _FieldLabel(label: 'Confirm Password'),
//                 SizedBox(height: sh * 0.008),
//                 Obx(() => TextFormField(
//                   controller: controller.confirmPasswordCtrl,
//                   obscureText: controller.hideConfirmPass.value,
//                   textInputAction: TextInputAction.done,
//                   onFieldSubmitted: (_) => controller.signup(),
//                   style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//                   decoration: _inputDecoration(
//                     hint: 'Confirm your password',
//                     prefix: Icons.lock_outline_rounded,
//                     suffix: GestureDetector(
//                       onTap: controller.toggleConfirmPassword,
//                       child: Icon(
//                         controller.hideConfirmPass.value
//                             ? Icons.visibility_off_outlined
//                             : Icons.visibility_outlined,
//                         color: AppColors.textHint,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   validator: controller.confirmPasswordValidator,
//                 )),
//
//                 SizedBox(height: sh * 0.022),
//
//                 // ── Terms checkbox ───────────────────────────────────
//                 Obx(() => GestureDetector(
//                   onTap: () => controller.agreedToTerms.toggle(),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: 20,
//                         height: 20,
//                         margin: const EdgeInsets.only(top: 1),
//                         decoration: BoxDecoration(
//                           color: controller.agreedToTerms.value
//                               ? AppColors.darkRed
//                               : Colors.transparent,
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(
//                             color: controller.agreedToTerms.value
//                                 ? AppColors.darkRed
//                                 : AppColors.textHint,
//                             width: 1.5,
//                           ),
//                         ),
//                         child: controller.agreedToTerms.value
//                             ? const Icon(Icons.check,
//                             size: 13, color: Colors.white)
//                             : null,
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: RichText(
//                           text: TextSpan(
//                             style: const TextStyle(
//                               fontSize: 13,
//                               color: AppColors.textSecondary,
//                               height: 1.5,
//                             ),
//                             children: [
//                               const TextSpan(text: 'I agree to the '),
//                               const TextSpan(
//                                 text: 'Terms of Service',
//                                 style: TextStyle(
//                                   color: AppColors.darkRed,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const TextSpan(text: ' and '),
//                               const TextSpan(
//                                 text: 'Privacy Policy',
//                                 style: TextStyle(
//                                   color: AppColors.darkRed,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//
//                 SizedBox(height: sh * 0.032),
//
//                 // ── Signup button inside SignupScreen ────────────────────────────────
//                 Obx(() => SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: ElevatedButton(
//                     onPressed: controller.isLoading.value
//                         ? null
//                         : () {
//                       // Validate 8-character password and Terms checkbox first
//                       if (controller.signupFormKey.currentState!.validate()) {
//                         if (!controller.agreedToTerms.value) {
//                           showToastFail("Please agree to the Terms of Service.");
//                           return;
//                         }
//
//                         // Trigger the actual API call
//                         controller.sendOtp();
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.darkRed,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                     ),
//                     child: controller.isLoading.value
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                       'Send OTP to verify email',
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 )),
//                 SizedBox(height: sh * 0.028),
//
//                 // ── Login link ───────────────────────────────────────
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Already have an account? ',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Get.back(),
//                       child: const Text(
//                         'Login',
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
//                 SizedBox(height: sh * 0.04),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmailField(double sh) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const _FieldLabel(label: 'Email Address'),
//         SizedBox(height: sh * 0.008),
//         TextFormField(
//           controller: controller.emailCtrl,
//           keyboardType: TextInputType.emailAddress,
//           textInputAction: TextInputAction.next,
//           style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//           decoration: _inputDecoration(
//             hint: 'Enter your email',
//             prefix: Icons.email_outlined,
//           ),
//           validator: controller.emailValidator,
//         ),
//       ],
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
// // ── Social signup button ──────────────────────────────────────────────────────
//
// class _SocialSignupButton extends StatelessWidget {
//   final String label;
//   final Widget icon;
//   final Color backgroundColor;
//   final Color textColor;
//   final Color borderColor;
//   final VoidCallback onTap;
//
//   const _SocialSignupButton({
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
// // ── Google Icon ───────────────────────────────────────────────────────────────
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
//     final cx = size.width / 2;
//     final cy = size.height / 2;
//     final r = size.width / 2;
//     final sw = size.width * 0.18;
//
//     void arc(double start, double sweep, Color color) {
//       canvas.drawArc(
//         Rect.fromCircle(center: Offset(cx, cy), radius: r),
//         start, sweep, false,
//         Paint()
//           ..color = color
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = sw,
//       );
//     }
//
//     arc(-0.52, 1.57, const Color(0xFF4285F4));
//     arc(-2.09, 1.57, const Color(0xFFEA4335));
//     arc(2.62, 1.04, const Color(0xFFFBBC05));
//     arc(1.05, 1.57, const Color(0xFF34A853));
//
//     canvas.drawLine(Offset(cx, cy), Offset(cx + r * 0.95, cy),
//         Paint()..color = Colors.white..strokeWidth = sw);
//     canvas.drawLine(Offset(cx + r * 0.05, cy), Offset(cx + r * 0.95, cy),
//         Paint()..color = const Color(0xFF4285F4)..strokeWidth = sw);
//   }
//
//   @override
//   bool shouldRepaint(_) => false;
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
//     return Row(
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/constant_utils.dart';
import '../../../routes/app_routes.dart';
import '../controller/Auth_Controller.dart';

// ── Shared colour tokens (mirrors login_screen.dart) ─────────────────────────
const _kBlue       = Color(0xFF1A56DB);
const _kBlueSoft   = Color(0xFFEFF6FF);
const _kBorder     = Color(0xFFE2E8F0);
const _kBg         = Color(0xFFF8FAFC);
const _kTextPrimary   = Color(0xFF111827);
const _kTextSecondary = Color(0xFF6B7280);
const _kTextHint      = Color(0xFFADB5BD);

class SignupScreen extends GetView<AuthController> {
  const SignupScreen({super.key});

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
            key: controller.signupFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sh * 0.04),

                // ── Avatar + Header (centred) ──────────────────────────
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
                        'Join AimJobs',
                        style: TextStyle(
                          fontSize: sw * 0.058,
                          fontWeight: FontWeight.w800,
                          color: _kTextPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Create your candidate account to find\nyour dream job',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: _kTextSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: sh * 0.028),

                // ── "Already have an account" banner ──────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _kBlueSoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 13.5,
                          color: _kTextSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Text(
                          'Sign in here',
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

                SizedBox(height: sh * 0.028),

                // ── "Sign up with" label ───────────────────────────────
                const Text(
                  'Sign up with',
                  style: TextStyle(
                    fontSize: 13,
                    color: _kTextSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),

                // ── Social signup buttons ──────────────────────────────
                _SocialButton(
                  label: 'Continue with Google',
                  icon: const _GoogleIcon(),
                  onTap: () => controller.loginWithGoogle(),
                ),
                const SizedBox(height: 10),
                _SocialButton(
                  label: 'Continue with LinkedIn',
                  icon: const _LinkedInIcon(),
                  onTap: () => controller.loginWithLinkedIn(),
                ),
                const SizedBox(height: 10),
                _SocialButton(
                  label: 'Continue with Facebook',
                  icon: const _FacebookIcon(),
                  onTap: () => controller.loginWithFacebook(),
                ),

                SizedBox(height: sh * 0.026),

                // ── "or" divider ───────────────────────────────────────
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

                // ── "Or register with email" label ─────────────────────
                const Text(
                  'Or register with email',
                  style: TextStyle(
                    fontSize: 13,
                    color: _kTextSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: sh * 0.016),

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
                  children: [
                    const _FieldLabel(label: 'Password'),
                    const SizedBox(width: 5),
                    const Text(
                      '(min. 8 characters)',
                      style: TextStyle(
                        fontSize: 12,
                        color: _kTextHint,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Obx(() => TextFormField(
                  controller: controller.passwordCtrl,
                  obscureText: controller.hidePassword.value,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontSize: 14, color: _kTextPrimary),
                  decoration: _inputDecoration(
                    hint: 'Create a password',
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

                SizedBox(height: sh * 0.02),

                // ── Confirm password ───────────────────────────────────
                const _FieldLabel(label: 'Confirm password'),
                const SizedBox(height: 6),
                Obx(() => TextFormField(
                  controller: controller.confirmPasswordCtrl,
                  obscureText: controller.hideConfirmPass.value,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => controller.signup(),
                  style: const TextStyle(
                      fontSize: 14, color: _kTextPrimary),
                  decoration: _inputDecoration(
                    hint: 'Repeat your password',
                    prefix: Icons.lock_outline_rounded,
                    suffix: GestureDetector(
                      onTap: controller.toggleConfirmPassword,
                      child: Icon(
                        controller.hideConfirmPass.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: _kTextSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: controller.confirmPasswordValidator,
                )),

                SizedBox(height: sh * 0.022),

                // ── Terms checkbox (kept as requested) ────────────────
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
                                : _kTextSecondary,
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
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 13,
                              color: _kTextSecondary,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: AppColors.darkRed,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
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

                SizedBox(height: sh * 0.03),

                // ── Send OTP button ────────────────────────────────────
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                      if (controller.signupFormKey.currentState!
                          .validate()) {
                        if (!controller.agreedToTerms.value) {
                          showToastFail(
                              "Please agree to the Terms of Service.");
                          return;
                        }
                        controller.sendOtp();
                      }
                    },
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
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: controller.isLoading.value
                        ? const SizedBox.shrink()
                        : const Text(
                      'Send OTP to verify email',
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkRed,
                      disabledBackgroundColor:AppColors.darkRed,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )),

                SizedBox(height: sh * 0.024),

                // ── Bottom terms text ──────────────────────────────────
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
                            text: "By continuing, you agree to AimJobs' "),
                        const TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            // color: _kBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: '\nand '),
                        const TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
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
      hintStyle:
      const TextStyle(fontSize: 14, color: _kTextHint),
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
        borderSide:
        const BorderSide(color: Color(0xFFEF4444), width: 1.5),
      ),
    );
  }
}

// ── Unified Social Button ─────────────────────────────────────────────────────

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _SocialButton({
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

// ── Google Icon ───────────────────────────────────────────────────────────────

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 22, height: 22,
        child: CustomPaint(painter: _GoogleLogoPainter()));
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

// ── Field Label ───────────────────────────────────────────────────────────────

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