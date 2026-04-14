// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../Utils/constant_utils.dart';
// import '../../../Utils/constraint.dart';
// import '../../../Utils/shared_prehelper.dart';
// import '../../../routes/app_routes.dart';
// import '../model/sendOtpModel.dart';
// import '../model/verifyOtpModel.dart';
//
// class AuthController extends GetxController {
//   // ── Form controllers ──────────────────────────────────────────────────────
//   final emailCtrl           = TextEditingController();
//   final passwordCtrl        = TextEditingController();
//   final confirmPasswordCtrl = TextEditingController();
//   final nameCtrl            = TextEditingController();
//   final phoneCtrl           = TextEditingController();
//
//   // ── OTP Controllers for 6 Boxes ───────────────────────────────────────────
//   final otpControllers = List.generate(6, (index) => TextEditingController());
//
//   final loginFormKey  = GlobalKey<FormState>();
//   final signupFormKey = GlobalKey<FormState>();
//
//   // ── Reactive state ────────────────────────────────────────────────────────
//   final isLoading       = false.obs;
//   final hidePassword    = true.obs;
//   final hideConfirmPass = true.obs;
//   final usePhone        = false.obs;
//   final agreedToTerms   = false.obs;
//
//   final _prefs = SharedPrefHelper();
//
//   @override
//   void onClose() {
//     emailCtrl.dispose();
//     passwordCtrl.dispose();
//     confirmPasswordCtrl.dispose();
//     nameCtrl.dispose();
//     phoneCtrl.dispose();
//     for (var controller in otpControllers) {
//       controller.dispose();
//     }
//     super.onClose();
//   }
//
//   void togglePassword()        => hidePassword.toggle();
//   void toggleConfirmPassword() => hideConfirmPass.toggle();
//
//   // ── Send OTP API ──────────────────────────────────────────────────────────
//   Future<void> sendOtp() async {
//     if (emailCtrl.text.isEmpty || !GetUtils.isEmail(emailCtrl.text.trim())) {
//       showToastFail("Please enter a valid email address");
//       return;
//     }
//
//     try {
//       isLoading.value = true;
//       final url = Uri.parse("https://aurore-nonappendent-ares.ngrok-free.dev/api/v1/auth/email/send-otp");
//       final body = {"email": emailCtrl.text.trim(), "purpose": "register"};
//       final headers = {'Content-Type': 'application/json', 'X-API-Key': XApikeys};
//
//       final response = await http.post(url, headers: headers, body: json.encode(body));
//
//       if (response.statusCode == 200 || response.statusCode == 202) {
//         final data = SendOtpReponseModel.fromJson(json.decode(response.body));
//         if (data.success == true) {
//           showToastSuccess(data.message ?? "OTP sent successfully");
//           Get.toNamed(AppRoutes.verifyotp, arguments: {
//             'email': emailCtrl.text.trim(),
//             'password': passwordCtrl.text,
//           });
//         } else {
//           showToastFail(data.message ?? "Failed to send OTP");
//         }
//       } else {
//         showToastFail("Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       showToastFail("Connection error.");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // ── Verify OTP & Register API (New Integrated Method) ─────────────────────
//   Future<void> verifyOtpRegister(String email, String password) async {
//     // Combine the 6 digits from controllers
//     String otp = otpControllers.map((e) => e.text).join();
//
//     if (otp.length < 6) {
//       showToastFail("Please enter the complete 6-digit OTP");
//       return;
//     }
//
//     try {
//       isLoading.value = true;
//       final url = Uri.parse("https://aurore-nonappendent-ares.ngrok-free.dev/api/v1/auth/email/register");
//
//       final body = {
//         "email": email,
//         "password": password,
//         "otp": otp,
//       };
//
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json', 'X-API-Key': XApikeys},
//         body: json.encode(body),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final verifyRes = VerifyOtpReponseModel.fromJson(json.decode(response.body));
//
//         if (verifyRes.success == true && verifyRes.data != null) {
//           final data = verifyRes.data!;
//
//           // ── Save all data to SharedPreferences ────────────────────
//           await _prefs.save('accessToken', data.accessToken ?? "");
//           await _prefs.save('refreshToken', data.refreshToken ?? "");
//           await _prefs.save('tokenType', data.tokenType ?? "");
//           await _prefs.save('userId', data.user?.id ?? "");
//           await _prefs.save('userEmail', data.user?.email ?? "");
//           await _prefs.save('isProfileComplete', data.user?.isProfileComplete ?? false);
//
//           showToastSuccess(verifyRes.message ?? "Account verified!");
//
//           // Navigate to complete profile
//           Get.offAllNamed(AppRoutes.completeProfile);
//         } else {
//           showToastFail(verifyRes.message ?? "Verification failed");
//         }
//       } else {
//         showToastFail("Verification error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Verify Error: $e");
//       showToastFail("Connection error.");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // ── Session check ─────────────────────────────────────────────────────────
//   Future<void> checkSession() async {
//     final token = await _prefs.get('accessToken');
//     final profileCompleted = await _prefs.get('isProfileComplete') ?? false;
//
//     if (token != null && token.toString().isNotEmpty) {
//       if (profileCompleted == true) {
//         Get.offAllNamed(AppRoutes.dashboard);
//       } else {
//         Get.offAllNamed(AppRoutes.completeProfile);
//       }
//     } else {
//       Get.offAllNamed(AppRoutes.onboarding);
//     }
//   }
//
//   // ── Login with email ──────────────────────────────────────────────────────
//   Future<void> login() async {
//     if (!loginFormKey.currentState!.validate()) return;
//     isLoading.value = true;
//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       await _prefs.save('accessToken', 'mock_token_123');
//       await _prefs.save('userEmail', emailCtrl.text.trim());
//
//       final profileCompleted = await _prefs.get('isProfileComplete') ?? false;
//
//       if (profileCompleted == true) {
//         Get.offAllNamed(AppRoutes.dashboard);
//       } else {
//         Get.offAllNamed(AppRoutes.completeProfile);
//       }
//     } catch (_) {
//       _toast('Login failed. Please check your credentials.', isError: true);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // ── Signup (Placeholder/Fallback) ─────────────────────────────────────────
//   Future<void> signup() async {
//     if (!signupFormKey.currentState!.validate()) return;
//     if (!agreedToTerms.value) {
//       _toast('Please agree to the Terms of Service to continue.', isError: true);
//       return;
//     }
//     // Logic redirected to sendOtp() for email verification flow
//     sendOtp();
//   }
//
//   // ── Social logins ─────────────────────────────────────────────────────────
//   Future<void> loginWithGoogle() async {
//     isLoading.value = true;
//     try {
//       await Future.delayed(const Duration(milliseconds: 800));
//       await _prefs.save('accessToken', 'google_mock_token');
//       await _prefs.save('userEmail', 'user@gmail.com');
//
//       final profileCompleted = await _prefs.get('isProfileComplete') ?? false;
//       if (profileCompleted == true) {
//         Get.offAllNamed(AppRoutes.dashboard);
//       } else {
//         Get.offAllNamed(AppRoutes.completeProfile);
//       }
//     } catch (_) {
//       _toast('Google sign-in failed.', isError: true);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> loginWithFacebook() async {
//     isLoading.value = true;
//     try {
//       await Future.delayed(const Duration(milliseconds: 800));
//       await _prefs.save('accessToken', 'facebook_mock_token');
//       Get.offAllNamed(AppRoutes.completeProfile);
//     } catch (_) {
//       _toast('Facebook sign-in failed.', isError: true);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> loginWithLinkedIn() async {
//     isLoading.value = true;
//     try {
//       await Future.delayed(const Duration(milliseconds: 800));
//       await _prefs.save('accessToken', 'linkedin_mock_token');
//       Get.offAllNamed(AppRoutes.completeProfile);
//     } catch (_) {
//       _toast('LinkedIn sign-in failed.', isError: true);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // ── Logout ────────────────────────────────────────────────────────────────
//   Future<void> logout() async {
//     await _prefs.clear();
//     Get.offAllNamed(AppRoutes.login);
//   }
//
//   // ── Validators ────────────────────────────────────────────────────────────
//   String? emailValidator(String? v) {
//     if (v == null || v.trim().isEmpty) return 'Email is required';
//     if (!GetUtils.isEmail(v.trim()))   return 'Enter a valid email address';
//     return null;
//   }
//
//   String? phoneValidator(String? v) {
//     if (v == null || v.isEmpty) return 'Phone number is required';
//     if (v.length < 10)          return 'Enter a valid 10-digit number';
//     return null;
//   }
//
//   String? passwordValidator(String? v) {
//     if (v == null || v.isEmpty) return 'Password is required';
//     if (v.length < 8)           return 'Minimum 8 characters required';
//     return null;
//   }
//
//   String? confirmPasswordValidator(String? v) {
//     if (v == null || v.isEmpty)    return 'Please confirm your password';
//     if (v != passwordCtrl.text)    return 'Passwords do not match';
//     return null;
//   }
//
//   String? nameValidator(String? v) {
//     if (v == null || v.trim().isEmpty) return 'Full name is required';
//     if (v.trim().length < 2)           return 'Name is too short';
//     return null;
//   }
//
//   // ── Helpers ───────────────────────────────────────────────────────────────
//   void _toast(String msg, {bool isError = false}) {
//     Fluttertoast.showToast(
//       msg: msg,
//       backgroundColor: isError ? const Color(0xFFE53935) : const Color(0xFF7F8839),
//       textColor: Colors.white,
//       toastLength: Toast.LENGTH_LONG,
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../Utils/constant_utils.dart';
import '../../../Utils/constraint.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../../routes/app_routes.dart';
import '../model/Login_Model.dart';
import '../model/sendOtpModel.dart';
import '../model/verifyOtpModel.dart';

class AuthController extends GetxController {
  // ── Form controllers ──────────────────────────────────────────────────────
  final emailCtrl           = TextEditingController();
  final passwordCtrl        = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final nameCtrl            = TextEditingController();
  final phoneCtrl           = TextEditingController();

  // ── OTP Controllers for 6 Boxes ───────────────────────────────────────────
  final otpControllers = List.generate(6, (index) => TextEditingController());

  final loginFormKey  = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  // ── Reactive state ────────────────────────────────────────────────────────
  final isLoading       = false.obs;
  final hidePassword    = true.obs;
  final hideConfirmPass = true.obs;
  final usePhone        = false.obs;
  final agreedToTerms   = false.obs;

  final _prefs = SharedPrefHelper();

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    nameCtrl.dispose();
    phoneCtrl.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void togglePassword()        => hidePassword.toggle();
  void toggleConfirmPassword() => hideConfirmPass.toggle();

  // ── Send OTP API ──────────────────────────────────────────────────────────
  Future<void> sendOtp() async {
    if (emailCtrl.text.isEmpty || !GetUtils.isEmail(emailCtrl.text.trim())) {
      showToastFail("Please enter a valid email address");
      return;
    }

    try {
      isLoading.value = true;
      final url = Uri.parse("https://aurore-nonappendent-ares.ngrok-free.dev/api/v1/auth/email/send-otp");
      final body = {"email": emailCtrl.text.trim(), "purpose": "register"};
      final headers = {'Content-Type': 'application/json', 'X-API-Key': XApikeys};

      final response = await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 200 || response.statusCode == 202) {
        final data = SendOtpReponseModel.fromJson(json.decode(response.body));
        if (data.success == true) {
          showToastSuccess(data.message ?? "OTP sent successfully");
          Get.toNamed(AppRoutes.verifyotp, arguments: {
            'email': emailCtrl.text.trim(),
            'password': passwordCtrl.text,
          });
        } else {
          showToastFail(data.message ?? "Failed to send OTP");
        }
      } else {
        showToastFail("Error: ${response.statusCode}");
      }
    } catch (e) {
      showToastFail("Connection error.");
    } finally {
      isLoading.value = false;
    }
  }

  // ── Verify OTP & Register API (New Integrated Method) ─────────────────────
  Future<void> verifyOtpRegister(String email, String password) async {
    // Combine the 6 digits from controllers
    String otp = otpControllers.map((e) => e.text).join();

    if (otp.length < 6) {
      showToastFail("Please enter the complete 6-digit OTP");
      return;
    }

    try {
      isLoading.value = true;
      final url = Uri.parse("https://aurore-nonappendent-ares.ngrok-free.dev/api/v1/auth/email/register");

      final body = {
        "email": email,
        "password": password,
        "otp": otp,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'X-API-Key': XApikeys},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final verifyRes = VerifyOtpReponseModel.fromJson(json.decode(response.body));

        if (verifyRes.success == true && verifyRes.data != null) {
          final data = verifyRes.data!;

          // ── Save all data to SharedPreferences ────────────────────
          await _prefs.save('accessToken', data.accessToken ?? "");
          await _prefs.save('refreshToken', data.refreshToken ?? "");
          await _prefs.save('tokenType', data.tokenType ?? "");
          await _prefs.save('userId', data.user?.id ?? "");
          await _prefs.save('userEmail', data.user?.email ?? "");
          await _prefs.save('isProfileComplete', data.user?.isProfileComplete ?? false);

          showToastSuccess(verifyRes.message ?? "Account verified!");

          // Navigate to complete profile
          Get.offAllNamed(AppRoutes.completeProfile);
        } else {
          showToastFail(verifyRes.message ?? "Verification failed");
        }
      } else {
        showToastFail("Verification error: ${response.statusCode}");
      }
    } catch (e) {
      print("Verify Error: $e");
      showToastFail("Connection error.");
    } finally {
      isLoading.value = false;
    }
  }

  // ── Session check ─────────────────────────────────────────────────────────
  Future<void> checkSession() async {
    final token = await _prefs.get('accessToken');
    final profileCompleted = await _prefs.get('isProfileComplete') ?? false;

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

  // ── Login with email (Integrated Real API) ────────────────────────────────
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final url = Uri.parse("https://aurore-nonappendent-ares.ngrok-free.dev/api/v1/auth/email/login");

      final body = {
        "email": emailCtrl.text.trim(),
        "password": passwordCtrl.text,
      };

      final headers = {
        'Content-Type': 'application/json',
        'X-API-Key': XApikeys,
      };

      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final loginRes = LoginReponseModel.fromJson(json.decode(response.body));

        if (loginRes.success == true && loginRes.data != null) {
          final data = loginRes.data!;

          // ── Save all response data to SharedPreferences ────────────────────
          await _prefs.save('accessToken', data.accessToken ?? "");
          await _prefs.save('refreshToken', data.refreshToken ?? "");
          await _prefs.save('tokenType', data.tokenType ?? "");
          await _prefs.save('userId', data.user?.id ?? "");
          await _prefs.save('userEmail', data.user?.email ?? "");
          await _prefs.save('name', data.user?.name ?? "");
          await _prefs.save('isProfileComplete', data.user?.isProfileComplete ?? false);

          showToastSuccess(loginRes.message ?? "Login successful!");

          // ── Check navigation logic ─────────────────────────────────────────
          final bool isComplete = data.user?.isProfileComplete ?? false;

          if (isComplete) {
            Get.offAllNamed(AppRoutes.dashboard);
          } else {
            Get.offAllNamed(AppRoutes.completeProfile);
          }
        } else {
          showToastFail(loginRes.message ?? "Login failed");
        }
      } else if (response.statusCode == 401) {
        showToastFail("Invalid email or password");
      } else {
        showToastFail("Login failed. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Login Error: $e");
      showToastFail("Connection error. Please check your internet.");
    } finally {
      isLoading.value = false;
    }
  }

  // ── Signup (Placeholder/Fallback) ─────────────────────────────────────────
  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) return;
    if (!agreedToTerms.value) {
      _toast('Please agree to the Terms of Service to continue.', isError: true);
      return;
    }
    // Logic redirected to sendOtp() for email verification flow
    sendOtp();
  }

  // ── Social logins ─────────────────────────────────────────────────────────
  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      await _prefs.save('accessToken', 'google_mock_token');
      await _prefs.save('userEmail', 'user@gmail.com');

      final profileCompleted = await _prefs.get('isProfileComplete') ?? false;
      if (profileCompleted == true) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.completeProfile);
      }
    } catch (_) {
      _toast('Google sign-in failed.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithFacebook() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      await _prefs.save('accessToken', 'facebook_mock_token');
      Get.offAllNamed(AppRoutes.completeProfile);
    } catch (_) {
      _toast('Facebook sign-in failed.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithLinkedIn() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      await _prefs.save('accessToken', 'linkedin_mock_token');
      Get.offAllNamed(AppRoutes.completeProfile);
    } catch (_) {
      _toast('LinkedIn sign-in failed.', isError: true);
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
    if (v.length < 8)           return 'Minimum 8 characters required';
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