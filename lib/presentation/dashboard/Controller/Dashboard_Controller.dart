import 'package:get/get.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../../routes/app_routes.dart';


class DashboardController extends GetxController {
  final userName = 'there'.obs;
  final _prefs = SharedPrefHelper();

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final name = await _prefs.get('name') ?? 'there';
    userName.value = name.toString().split(' ').first;
  }

  Future<void> logout() async {
    await _prefs.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}