
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../Utils/constant_utils.dart';
import '../../../Utils/constraint.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../../api/apilist.dart';
import '../../../routes/app_routes.dart';
import '../../dashboard/Controller/Dashboard_Controller.dart';
import '../model/Login_Model.dart';
import '../model/RefreshToken_Model.dart';
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
      final url = Uri.parse("${ApiList.baseUrl}/v1/auth/email/send-otp");
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
      final url = Uri.parse("${ApiList.baseUrl}/v1/auth/email/register");

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

  Future<String?> login() async {
    if (!loginFormKey.currentState!.validate()) return null;

    isLoading.value = true;
    try {
      final url = Uri.parse("${ApiList.baseUrl}/v1/auth/email/login");

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
          showToastSuccess(loginRes.message ?? "Login successful!");

// ── Update DashboardController state if it's already alive ─────────
          if (Get.isRegistered<DashboardController>()) {
            final dashCtrl = Get.find<DashboardController>();
            dashCtrl.isLoggedIn.value = true;
            dashCtrl.userName.value = (data.user?.name ?? '').split(' ').first;
            dashCtrl.userEmail.value = data.user?.email ?? '';
          }

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
      } else if (response.statusCode == 404) {
        try {
          final errorData = json.decode(response.body);
          final message = errorData['message'] ?? "ACCOUNT_NOT_FOUND";
          return message;
        } catch (_) {
          return "ACCOUNT_NOT_FOUND";
        }
      } else {
        showToastFail("Login failed. Status: ${response.statusCode}");
      }
      return null;
    } catch (e) {
      print("Login Error: $e");
      showToastFail("Connection error. Please check your internet.");
      return null;
    } finally {
      isLoading.value = false;
    }
  }


  ///refresh
  Future<String?> refreshAuthToken() async {
    try {
      // 1. Get current refresh token from Prefs
      final storedRefreshToken = await _prefs.get('refreshToken');

      if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
        logout(); // Force logout if no refresh token exists
        return null;
      }

      final url = Uri.parse("${ApiList.baseUrl}/v1/auth/refresh");

      final body = {
        "refreshToken": storedRefreshToken,
      };

      final headers = {
        'Content-Type': 'application/json',
        'X-API-Key': XApikeys,
      };

      print("Refreshing Token → $url");
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final refreshRes = RefreshTokenResponseModel.fromJson(json.decode(response.body));

        if (refreshRes.success == true && refreshRes.data != null) {
          final data = refreshRes.data!;

          // 2. Overwrite SharedPreferences with fresh data
          await _prefs.save('accessToken', data.accessToken ?? "");
          await _prefs.save('refreshToken', data.refreshToken ?? "");
          await _prefs.save('tokenType', data.tokenType ?? "");
          await _prefs.save('userId', data.user?.id ?? "");
          await _prefs.save('userEmail', data.user?.email ?? "");
          await _prefs.save('name', data.user?.name ?? "");
          await _prefs.save('isProfileComplete', data.user?.isProfileComplete ?? false);

          print("Token refreshed successfully!");
          return data.accessToken;
        }
      }

      // If refresh fails (e.g., refresh token expired), log the user out
      logout();
      return null;

    } catch (e) {
      print("Refresh Token Error: $e");
      return null;
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


  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    try {
      // Step 1: Trigger Google Sign-In picker
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        isLoading.value = false;
        return;
      }

      // Step 2: Get auth tokens from Google
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      print("google return this data : " +  idToken.toString()  +  " acess  : "  + accessToken.toString() );
      if (googleUser != null) {
        print(googleUser.email);          // user@gmail.com
        print(googleUser.displayName);    // Full Name
        print(googleUser.photoUrl);       // profile picture URL
        print(googleUser.id);             // Google user ID
                // Google user ID
      }

      if (idToken == null) {
        _toast('Google sign-in failed. Please try again.', isError: true);
        return;
      }

      // Step 3: Send idToken to your backend
      final url = Uri.parse("${ApiList.baseUrl}/v1/auth/token");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'X-API-Key': XApikeys,
        },
        body: json.encode({
          'provider': "google",
          'idToken': idToken,
        }),
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);

        if (res['success'] == true) {
          // Step 4: Save tokens & user info from backend response
          final String accessToken = res['data']['accessToken'] ?? '';
          final String refreshToken = res['data']['refreshToken'] ?? '';
          final bool isProfileComplete =
              res['data']['isProfileComplete'] ?? false;

          await _prefs.save('accessToken', accessToken);
          await _prefs.save('refreshToken', refreshToken);
          await _prefs.save('userEmail', googleUser.email);
          await _prefs.save('userName', googleUser.displayName ?? '');
          await _prefs.save('isProfileComplete', isProfileComplete);

          // Step 5: Navigate based on profile status
          if (isProfileComplete) {
            Get.offAllNamed(AppRoutes.dashboard);
          } else {
            Get.toNamed(AppRoutes.completeProfile);
          }
        } else {
          _toast(res['message'] ?? 'Login failed. Please try again.',
              isError: true);
        }
      } else if (response.statusCode == 401) {
        _toast('Unauthorized. Please try again.', isError: true);
      } else {
        _toast('Server error. Please try again later.', isError: true);
      }
    } on http.ClientException {
      _toast('No internet connection.', isError: true);
    } catch (e) {
      print("Google Login Error: $e");
      _toast('Google sign-in failed.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }


  // ── Add this for sign-out / session clear ──────────────────────────────────
  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();         // clears Google session
      await _prefs.clear();

      Get.offAllNamed(AppRoutes.signup);     // or your login route
    } catch (e) {
      print("Sign Out Error: $e");
    }
  }
  // Future<void> loginWithGoogle() async {
  //   isLoading.value = true;
  //   try {
  //     await Future.delayed(const Duration(milliseconds: 800));
  //     await _prefs.save('accessToken', 'google_mock_token');
  //     await _prefs.save('userEmail', 'user@gmail.com');
  //
  //     final profileCompleted = await _prefs.get('isProfileComplete') ?? false;
  //     if (profileCompleted == true) {
  //       Get.offAllNamed(AppRoutes.dashboard);
  //     } else {
  //      // Get.offAllNamed(AppRoutes.completeProfile);
  //       Get.toNamed(AppRoutes.completeProfile);
  //     }
  //   } catch (_) {
  //     _toast('Google sign-in failed.', isError: true);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

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