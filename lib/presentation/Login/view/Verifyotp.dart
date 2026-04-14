import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../controller/Auth_Controller.dart';

class VerifyOtpScreen extends GetView<AuthController> {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    // ── Extract arguments passed from Signup Screen ──────────────────
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String email = args['email'] ?? 'No Email';
    final String password = args['password'] ?? 'No Password';

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.02),

              // ── Back button ──────────────────────────────────────
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.appBg1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                ),
              ),

              SizedBox(height: sh * 0.04),

              // ── Header ───────────────────────────────────────────
              Text(
                'Verify OTP ✨',
                style: TextStyle(
                  fontSize: sw * 0.065,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the 6-digit code sent to $email',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),

              SizedBox(height: sh * 0.06),

              // ── 6 OTP Boxes Linked to Controller ─────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                      (index) => _OtpBox(
                      index: index,
                      otpController: controller.otpControllers[index]
                  ),
                ),
              ),

              SizedBox(height: sh * 0.05),

              // ── Verify Button ────────────────────────────────────
              Obx(() => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    print("Verifying OTP for Email: $email");
                    // Call the API with combined OTP, email, and password
                    controller.verifyOtpRegister(email, password);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkRed,
                    disabledBackgroundColor: AppColors.darkRed.withOpacity(0.6),
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
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    'Verify OTP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),

              SizedBox(height: sh * 0.04),

              // ── Resend Option ─────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive code? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Resending OTP to: $email");
                      controller.sendOtp(); // Calls the resend logic
                    },
                    child: const Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkRed,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable OTP Box Widget ───────────────────────────────────────────────

class _OtpBox extends StatelessWidget {
  final int index;
  final TextEditingController otpController;
  const _OtpBox({required this.index, required this.otpController});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return SizedBox(
      width: sw * 0.12,
      child: TextFormField(
        controller: otpController,
        autofocus: index == 0,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.appBg1,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.darkRed, width: 1.5),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}