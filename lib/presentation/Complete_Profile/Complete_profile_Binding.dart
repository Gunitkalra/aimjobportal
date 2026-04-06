import 'package:get/get.dart';

import 'Controller/Complete_Profile_Controller.dart';

class CompleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileController>(() => CompleteProfileController());
  }
}