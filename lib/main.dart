import 'package:aimjobs/Utils/shared_prehelper.dart';
import 'package:aimjobs/routes/app_routes.dart';
import 'package:aimjobs/theme/Apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final token = await SharedPrefHelper().get('accessToken');
  final bool isLoggedIn = token != null && token.toString().isNotEmpty;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aim Jobs',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: isLoggedIn ? AppRoutes.dashboard : AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}