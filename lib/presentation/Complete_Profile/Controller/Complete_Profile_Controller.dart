import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../Utils/shared_prehelper.dart';

class CompleteProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final jobTitleCtrl = TextEditingController();
  final locationCtrl = TextEditingController();

  final isLoading = false.obs;
  final avatarPath = ''.obs;
  final resumeFileName = ''.obs;
  final resumeFileSize = ''.obs;

  final _prefs = SharedPrefHelper();

  @override
  void onInit() {
    super.onInit();
    _prefillFromSession();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    jobTitleCtrl.dispose();
    locationCtrl.dispose();
    super.onClose();
  }

  Future<void> _prefillFromSession() async {
    final email = await _prefs.get('email') ?? '';
    final name = await _prefs.get('name') ?? '';
    emailCtrl.text = email;
    nameCtrl.text = name;
  }

  void pickAvatar() {
    // TODO: Integrate image_picker package
    // final picker = ImagePicker();
    // final image = await picker.pickImage(source: ImageSource.gallery);
    // if (image != null) avatarPath.value = image.path;
    Fluttertoast.showToast(
      msg: 'Photo picker — integrate image_picker package',
      backgroundColor: const Color(0xFF7F8839),
      textColor: Colors.white,
    );
  }

  void pickResume() {
    // TODO: Integrate file_picker package
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['pdf', 'doc', 'docx'],
    // );
    // if (result != null && result.files.single.path != null) {
    //   resumeFileName.value = result.files.single.name;
    //   final bytes = result.files.single.size;
    //   resumeFileSize.value = '${(bytes / 1024).toStringAsFixed(1)} KB';
    // }

    // Simulated for now
    resumeFileName.value = 'My_Resume.pdf';
    resumeFileSize.value = '245 KB';
    Fluttertoast.showToast(
      msg: 'Resume selected! Integrate file_picker package for real upload.',
      backgroundColor: const Color(0xFF7F8839),
      textColor: Colors.white,
    );
  }

  void removeResume() {
    resumeFileName.value = '';
    resumeFileSize.value = '';
  }

  void skipResume() => _navigateToDashboard();

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    try {
      // TODO: Call your real profile save API here
      // await ApiService.instance.updateProfile(
      //   name: nameCtrl.text.trim(),
      //   phone: phoneCtrl.text.trim(),
      //   email: emailCtrl.text.trim(),
      //   jobTitle: jobTitleCtrl.text.trim(),
      //   location: locationCtrl.text.trim(),
      // );

      await Future.delayed(const Duration(seconds: 1));

      // Save to local prefs
      await _prefs.save('name', nameCtrl.text.trim());
      await _prefs.save('email', emailCtrl.text.trim());
      await _prefs.save('phone', phoneCtrl.text.trim());
      await _prefs.save('profileCompleted', true);

      _navigateToDashboard();
    } catch (_) {
      Fluttertoast.showToast(
        msg: 'Failed to save profile. Please try again.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateToDashboard() {
    Get.offAllNamed(AppRoutes.dashboard);
  }
}