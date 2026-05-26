import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasStartedTimer = false;

  void _startTimer() {
    if (_hasStartedTimer) return;
    _hasStartedTimer = true;
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Get.offAllNamed(AppRoutes.dashboard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Image.asset(
          'assets/Screenedit.png',
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) => _startTimer());
              return child;
            }
            if (frame != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) => _startTimer());
              return child;
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}