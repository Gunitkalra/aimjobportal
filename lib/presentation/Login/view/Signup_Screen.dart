import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../controller/Auth_Controller.dart';


class SignupScreen extends GetView<AuthController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Text(
          'Signup Screen\n— coming next',
          textAlign: TextAlign.center,
          style: TextStyle(color:AppColors.textSecondary, fontSize: 15),
        ),
      ),
    );
  }
}