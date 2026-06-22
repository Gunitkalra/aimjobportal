import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/colors.dart';
import '../../../Utils/constant_utils.dart';
import '../../../Utils/constraint.dart';
import '../../../api/apilist.dart';
import '../../../routes/app_routes.dart';

const _kBlue          = Color(0xFF1576C2);
const _kBlueSoft      = Color(0xFFEFF6FF); // avatar bg & banner bg
const _kBorder        = Color(0xFFE2E8F0); // input / button border
const _kBgGradientTop = Color(0xFFF1F5F9); // Light soft background
const _kBgGradientBot = Color(0xFFE2E8F0);
const _kBg            = Color(0xFFF8FAFC); // input fill
const _kTextPrimary   = Color(0xFF111827);
const _kTextSecondary = Color(0xFF6B7280);

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Stages:
  // 1 - Email Entry
  // 2 - OTP Code Entry
  // 3 - New Password Entry
  int _stage = 1;
  bool _isLoading = false;

  // Controllers
  final _emailCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  
  final List<TextEditingController> _otpCtrls = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  String _enteredEmail = '';
  String _enteredOtp = '';
  
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  // Countdown timer for resending OTP
  Timer? _timer;
  int _secondsRemaining = 60;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    for (var c in _otpCtrls) {
      c.dispose();
    }
    for (var fn in _otpFocusNodes) {
      fn.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  // Stage 1 API Call: Send OTP
  Future<void> _sendOtp({bool isResend = false}) async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      showToastFail("Please enter a valid email address");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse("https://www.aimjobs.ai/api/v1/auth/email/send-otp");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "email": email,
          "purpose": "forgot-password",
        }),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        showToastSuccess(responseData['message'] ?? "OTP sent successfully!");
        _enteredEmail = email;
        _startTimer();
        if (!isResend) {
          setState(() {
            _stage = 2;
          });
        }
      } else {
        String errMsg = responseData['message'] ?? "Failed to send OTP";
        showToastFail(errMsg);
      }
    } catch (e) {
      showToastFail("Connection error.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Stage 2: Verification (transition to Stage 3)
  void _verifyCode() {
    final otp = _otpCtrls.map((c) => c.text.trim()).join();
    if (otp.length < 6) {
      showToastFail("Please enter the complete 6-digit code");
      return;
    }
    setState(() {
      _enteredOtp = otp;
      _stage = 3;
    });
  }

  // Stage 3 API Call: Reset Password
  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;
    if (_newPasswordCtrl.text.length < 8) {
      showToastFail("Password must be at least 8 characters");
      return;
    }
    if (_newPasswordCtrl.text != _confirmPasswordCtrl.text) {
      showToastFail("Passwords do not match");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse("https://www.aimjobs.ai/api/v1/auth/email/reset-password");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "email": _enteredEmail,
          "otp": _enteredOtp,
          "newPassword": _newPasswordCtrl.text,
        }),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        showToastSuccess(responseData['message'] ?? "Password reset successfully!");
        // Reset everything
        _emailCtrl.clear();
        for (var c in _otpCtrls) {
          c.clear();
        }
        _newPasswordCtrl.clear();
        _confirmPasswordCtrl.clear();
        // Go to Login Screen
        Get.offAllNamed(AppRoutes.login);
      } else {
        String errMsg = "Failed to reset password";
        if (responseData != null) {
          if (responseData['message'] != null) {
            errMsg = responseData['message'].toString();
          } else if (responseData['errors'] != null) {
            final errors = responseData['errors'] as Map<String, dynamic>;
            errMsg = errors.values.map((v) => (v as List).join(", ")).join("\n");
          } else if (responseData['title'] != null) {
            errMsg = responseData['title'].toString();
          }
        }
        showToastFail(errMsg);
      }
    } catch (e) {
      showToastFail("Connection error.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 45,
      height: 50,
      child: TextFormField(
        controller: _otpCtrls[index],
        focusNode: _otpFocusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _kTextPrimary),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _kBlue, width: 1.5),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            _otpFocusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _otpFocusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_kBgGradientTop, _kBgGradientBot],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Top Header Bar (Logo & Action Buttons) ─────────────────────
              Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.contain,
                      height: 90,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => Get.toNamed(AppRoutes.signup),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: AppColors.darkRed, width: 1.5),
                            ),
                            minimumSize: const Size(80, 30),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            elevation: 0,
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: AppColors.darkRed,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () => Get.toNamed(AppRoutes.login),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(80, 30),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // ── Form Content Inside White Card ─────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.05, vertical: 10),
                  child: Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),

                            // ── Key Icon + Header ──────────────────────────────────
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: const BoxDecoration(
                                      color: _kBlueSoft,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.vpn_key_outlined,
                                      color: _kBlue,
                                      size: 32,
                                    ),
                                  ),
                                  SizedBox(height: sh * 0.018),
                                  Text(
                                    'Reset Password',
                                    style: TextStyle(
                                      fontSize: sw * 0.058,
                                      fontWeight: FontWeight.w800,
                                      color: _kTextPrimary,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'Enter your email to receive a one-time code',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _kTextSecondary,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: sh * 0.024),

                            // ── Sign-in Banner ──────────────────────────────────────
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              decoration: BoxDecoration(
                                color: _kBlueSoft,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Remembered your password? ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _kTextSecondary,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.offNamed(AppRoutes.login),
                                    child: const Text(
                                      'Sign in here',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _kBlue,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: sh * 0.024),

                            // ── Stage 1: Email Input ───────────────────────────────
                            if (_stage == 1) ...[
                              const Text(
                                'Email address',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _kTextPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _sendOtp(),
                                style: const TextStyle(fontSize: 14, color: _kTextPrimary),
                                decoration: InputDecoration(
                                  hintText: 'piyush@yopmail.com',
                                  hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                                  filled: true,
                                  fillColor: _kBg,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  prefixIcon: const Icon(Icons.mail_outline_rounded, color: Color(0xFF94A3B8), size: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: _kBorder),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: _kBlue, width: 1.5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : () => _sendOtp(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _kBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.send_rounded, color: Colors.white, size: 18),
                                            SizedBox(width: 8),
                                            Text(
                                              'Send Reset Code',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ],

                            // ── Stage 2: OTP Input ─────────────────────────────────
                            if (_stage == 2) ...[
                              // Code Sent Banner
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: _kBlueSoft,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.mail_outline_rounded, color: _kBlue, size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(fontSize: 13, color: _kBlue),
                                          children: [
                                            const TextSpan(text: "Reset code sent to "),
                                            TextSpan(
                                              text: _enteredEmail,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Enter the 6-digit code',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _kTextPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  6,
                                  (index) => _buildOtpBox(index),
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: _verifyCode,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _kBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 18),
                                      SizedBox(width: 8),
                                      Text(
                                        'Verify Code',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  if (_secondsRemaining > 0)
                                    Text(
                                      'Resend in ${_secondsRemaining}s',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: _kTextSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  else
                                    GestureDetector(
                                      onTap: () => _sendOtp(isResend: true),
                                      child: const Text(
                                        'Resend code',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: _kBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      _timer?.cancel();
                                      setState(() {
                                        _stage = 1;
                                      });
                                    },
                                    child: const Text(
                                      'Use a different email',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: _kBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            // ── Stage 3: New Password Input ────────────────────────
                            if (_stage == 3) ...[
                              // Code Verified Banner
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDEF7EC),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.check_circle_outline_rounded, color: Color(0xFF03543F), size: 20),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Code verified. Choose a new password.",
                                        style: TextStyle(fontSize: 13, color: Color(0xFF03543F), fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // New Password
                              const Text(
                                'New password (min. 8 characters)',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _kTextPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _newPasswordCtrl,
                                obscureText: _obscureNew,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(fontSize: 14, color: _kTextPrimary),
                                decoration: InputDecoration(
                                  hintText: 'Create new password',
                                  hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                                  filled: true,
                                  fillColor: _kBg,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF94A3B8), size: 20),
                                  suffixIcon: GestureDetector(
                                    onTap: () => setState(() => _obscureNew = !_obscureNew),
                                    child: Icon(
                                      _obscureNew ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                      color: const Color(0xFF94A3B8),
                                      size: 20,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: _kBorder),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: _kBlue, width: 1.5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Confirm Password
                              const Text(
                                'Confirm new password',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _kTextPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _confirmPasswordCtrl,
                                obscureText: _obscureConfirm,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _resetPassword(),
                                style: const TextStyle(fontSize: 14, color: _kTextPrimary),
                                decoration: InputDecoration(
                                  hintText: 'Repeat new password',
                                  hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                                  filled: true,
                                  fillColor: _kBg,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF94A3B8), size: 20),
                                  suffixIcon: GestureDetector(
                                    onTap: () => setState(() => _obscureConfirm = !_obscureConfirm),
                                    child: Icon(
                                      _obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                      color: const Color(0xFF94A3B8),
                                      size: 20,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: _kBorder),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: _kBlue, width: 1.5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _resetPassword,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _kBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.verified_user_outlined, color: Colors.white, size: 18),
                                            SizedBox(width: 8),
                                            Text(
                                              'Reset Password',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}