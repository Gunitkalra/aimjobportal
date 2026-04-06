import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Add this package
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'; // Add this package

import '../../../Utils/shared_prehelper.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  // ── Form controllers ──────────────────────────────────────────────────────
  final emailCtrl    = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl     = TextEditingController();

  final loginFormKey  = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  // ── Social Login instances ───────────────────────────────────────────────
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ── Reactive state ────────────────────────────────────────────────────────
  final isLoading       = false.obs;
  final hidePassword    = true.obs;
  final hideConfirmPass = true.obs;

  // FIXED: Added () to create an instance
  final _prefs = SharedPrefHelper();

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    nameCtrl.dispose();
    super.onClose();
  }

  void togglePassword()        => hidePassword.toggle();
  void toggleConfirmPassword() => hideConfirmPass.toggle();

  // ── Email/Password Login ─────────────────────────────────────────────────
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      // Simulate API Call
      await Future.delayed(const Duration(seconds: 1));

      // Save session and navigate
      // await _prefs.saveSession(...);

      // Get.offAllNamed(AppRoutes.customerDashboard);
    } catch (_) {
      _showErrorToast('Login failed. Please check your credentials.');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Google Login ─────────────────────────────────────────────────────────
  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      // This triggers the official Google Login popup
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // Success! Navigate to dashboard
        // Get.offAllNamed(AppRoutes.customerDashboard);
      }
    } catch (e) {
      _showErrorToast('Google Sign-In failed');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Facebook Login ───────────────────────────────────────────────────────
  Future<void> loginWithFacebook() async {
    try {
      isLoading.value = true;
      // Logic for Facebook:
      // final result = await FacebookAuth.instance.login();
      // if (result.status == LoginStatus.success) { ... }

      // Placeholder navigation
      await Future.delayed(const Duration(seconds: 1));
      // Get.offAllNamed(AppRoutes.customerDashboard);
    } catch (e) {
      _showErrorToast('Facebook Sign-In failed');
    } finally {
      isLoading.value = false;
    }
  }

  // ── LinkedIn Login ───────────────────────────────────────────────────────
  Future<void> loginWithLinkedIn() async {
    try {
      isLoading.value = true;
      // LinkedIn usually requires a WebView or a specialized package
      await Future.delayed(const Duration(seconds: 1));
      // Get.offAllNamed(AppRoutes.customerDashboard);
    } catch (e) {
      _showErrorToast('LinkedIn Sign-In failed');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Helper: Red Toast ────────────────────────────────────────────────────
  void _showErrorToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
    );
  }

  // ── Logout ────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    // await _prefs.clearSession();
    Get.offAllNamed(AppRoutes.login);
  }

  // ── Validators ────────────────────────────────────────────────────────────
  String? emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(v.trim()))   return 'Enter a valid email address';
    return null;
  }

  String? passwordValidator(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6)           return 'Minimum 6 characters required';
    return null;
  }

  String? nameValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Full name is required';
    if (v.trim().length < 2)           return 'Name is too short';
    return null;
  }
}