import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Utils/shared_prehelper.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  // ── Form controllers ──────────────────────────────────────────────────────
  final emailCtrl           = TextEditingController();
  final passwordCtrl        = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final nameCtrl            = TextEditingController();
  final phoneCtrl           = TextEditingController();

  final loginFormKey  = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  // ── Reactive state ────────────────────────────────────────────────────────
  final isLoading       = false.obs;
  final hidePassword    = true.obs;
  final hideConfirmPass = true.obs;
  final usePhone        = false.obs;      // signup toggle: email vs phone
  final agreedToTerms   = false.obs;

  final _prefs = SharedPrefHelper();

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    nameCtrl.dispose();
    phoneCtrl.dispose();
    super.onClose();
  }

  void togglePassword()        => hidePassword.toggle();
  void toggleConfirmPassword() => hideConfirmPass.toggle();

  // ── Session check (call from SplashController) ────────────────────────────
  Future<void> checkSession() async {
    final token = await _prefs.get('token');
    final profileCompleted = await _prefs.get('profileCompleted') ?? false;

    if (token != null && token.toString().isNotEmpty) {
      if (profileCompleted == true) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.completeProfile);
      }
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }

  // ── Login with email ──────────────────────────────────────────────────────
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      // TODO: replace with your real API call
      // final res = await ApiService.instance.login(
      //   email:    emailCtrl.text.trim(),
      //   password: passwordCtrl.text,
      // );
      // Handle response:
      //   - 200 + user exists + profile complete  → dashboard
      //   - 200 + user exists + profile incomplete → completeProfile
      //   - 404 user not found → signup page

      await Future.delayed(const Duration(seconds: 1));

      // ── SIMULATED LOGIC ──────────────────────────────────────────
      // Pretend we got a token back; check profile completion flag
      await _prefs.save('token', 'mock_token_123');
      await _prefs.save('email', emailCtrl.text.trim());

      final profileCompleted = await _prefs.get('profileCompleted') ?? false;

      if (profileCompleted == true) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        // User exists but hasn't completed profile
        Get.offAllNamed(AppRoutes.completeProfile);
      }
      // ─────────────────────────────────────────────────────────────

      // Real pattern when user not found (404):
      // Get.offAllNamed(AppRoutes.signup);

    } catch (_) {
      _toast('Login failed. Please check your credentials.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // ── Signup ────────────────────────────────────────────────────────────────
  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) return;

    if (!agreedToTerms.value) {
      _toast('Please agree to the Terms of Service to continue.', isError: true);
      return;
    }

    isLoading.value = true;
    try {
      // TODO: replace with your real signup API call
      // final res = await ApiService.instance.signup(
      //   email:    usePhone.value ? null : emailCtrl.text.trim(),
      //   phone:    usePhone.value ? phoneCtrl.text.trim() : null,
      //   password: passwordCtrl.text,
      // );
      // await _saveSession(res.data);

      await Future.delayed(const Duration(seconds: 1));

      // Save session
      await _prefs.save('token', 'mock_token_signup');
      if (usePhone.value) {
        await _prefs.save('phone', phoneCtrl.text.trim());
      } else {
        await _prefs.save('email', emailCtrl.text.trim());
      }

      // After signup → go complete profile
      Get.offAllNamed(AppRoutes.completeProfile);
    } catch (_) {
      _toast('Signup failed. Please try again.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // ── Social logins ─────────────────────────────────────────────────────────

  Future<void> loginWithGoogle() async {
    // TODO: integrate google_sign_in package
    // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    // final account = await _googleSignIn.signIn();
    // if (account == null) return;
    // Call your backend with the Google token, then navigate accordingly.

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      await _prefs.save('token', 'google_mock_token');
      await _prefs.save('email', 'user@gmail.com');

      final profileCompleted = await _prefs.get('profileCompleted') ?? false;
      if (profileCompleted == true) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.completeProfile);
      }
    } catch (_) {
      _toast('Google sign-in failed. Please try again.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithFacebook() async {
    // TODO: integrate flutter_facebook_auth package
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      await _prefs.save('token', 'facebook_mock_token');

      final profileCompleted = await _prefs.get('profileCompleted') ?? false;
      if (profileCompleted == true) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.completeProfile);
      }
    } catch (_) {
      _toast('Facebook sign-in failed. Please try again.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithLinkedIn() async {
    // TODO: integrate linkedin_login or webview-based LinkedIn OAuth
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      await _prefs.save('token', 'linkedin_mock_token');

      final profileCompleted = await _prefs.get('profileCompleted') ?? false;
      if (profileCompleted == true) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.completeProfile);
      }
    } catch (_) {
      _toast('LinkedIn sign-in failed. Please try again.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // ── Logout ────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    await _prefs.clear();
    Get.offAllNamed(AppRoutes.login);
  }

  // ── Validators ────────────────────────────────────────────────────────────
  String? emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(v.trim()))   return 'Enter a valid email address';
    return null;
  }

  String? phoneValidator(String? v) {
    if (v == null || v.isEmpty) return 'Phone number is required';
    if (v.length < 10)          return 'Enter a valid 10-digit number';
    return null;
  }

  String? passwordValidator(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6)           return 'Minimum 6 characters required';
    return null;
  }

  String? confirmPasswordValidator(String? v) {
    if (v == null || v.isEmpty)    return 'Please confirm your password';
    if (v != passwordCtrl.text)    return 'Passwords do not match';
    return null;
  }

  String? nameValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Full name is required';
    if (v.trim().length < 2)           return 'Name is too short';
    return null;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  void _toast(String msg, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: isError ? const Color(0xFFE53935) : const Color(0xFF7F8839),
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}