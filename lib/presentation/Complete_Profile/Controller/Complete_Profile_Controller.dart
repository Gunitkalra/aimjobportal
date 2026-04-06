import 'package:file_picker/file_picker.dart';
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

// Replace the entire pickResume() method with this:
  Future<void> pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      if (file.size > 5 * 1024 * 1024) {
        Fluttertoast.showToast(
          msg: 'File too large. Max size is 5MB.',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      resumeFileName.value = file.name;

      final bytes = file.size;
      if (bytes < 1024 * 1024) {
        resumeFileSize.value = '${(bytes / 1024).toStringAsFixed(1)} KB';
      } else {
        resumeFileSize.value = '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      }
    }
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