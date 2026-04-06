import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Utils/shared_prehelper.dart';
import '../../../routes/app_routes.dart';


class AuthController extends GetxController {
  // ── Form controllers ──────────────────────────────────────────────────────
  final emailCtrl    = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl     = TextEditingController();

  final loginFormKey  = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  // ── Reactive state ────────────────────────────────────────────────────────
  final isLoading       = false.obs;
  final hidePassword    = true.obs;
  final hideConfirmPass = true.obs;

  final _prefs = SharedPrefHelper;

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    nameCtrl.dispose();
    super.onClose();
  }

  void togglePassword()        => hidePassword.toggle();
  void toggleConfirmPassword() => hideConfirmPass.toggle();

  // ── Login ─────────────────────────────────────────────────────────────────
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      // ── TODO: replace with your real API call ──────────────────────────
      // final res = await ApiService.instance.login(
      //   email:    emailCtrl.text.trim(),
      //   password: passwordCtrl.text,
      // );
      // final model = AuthModel.fromJson(res.data);
      // await _prefs.saveSession(
      //   token:  model.token,
      //   userId: model.userId,
      //   name:   model.name,
      //   email:  model.email,
      // );
      // ─────────────────────────────────────────────────────────────────

      // Simulated delay — remove after API is wired
      await Future.delayed(const Duration(seconds: 1));
      // await _prefs.saveSession(
      //   token:  'mock_token_123',
      //   userId: '1',
      //   name:   emailCtrl.text.split('@').first,
      //   email:  emailCtrl.text.trim(),
      // );

      // Get.offAllNamed(AppRoutes.home);
    } catch (_) {
      Fluttertoast.showToast(
        msg:             'Login failed. Please check your credentials.',
        backgroundColor: const Color(0xFFE53935),
        textColor:       const Color(0xFFFFFFFF),
      );
    } finally {
      isLoading.value = false;
    }
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