import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_routes.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../../Utils/constant_utils.dart'; // For XApikeys
import '../../../Utils/constraint.dart';
import '../model/Completeprofile_Model.dart';     // For showToast helpers


class CompleteProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  final isLoading = false.obs;
  final avatarPath = ''.obs;
  final resumeFileName = ''.obs;
  final resumeFileSize = ''.obs;

  // To store the actual file for uploading
  final Rxn<PlatformFile> pickedFile = Rxn<PlatformFile>();

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
    super.onClose();
  }

  Future<void> _prefillFromSession() async {
    final email = await _prefs.get('userEmail') ?? '';
    final name = await _prefs.get('name') ?? '';
    emailCtrl.text = email;
    nameCtrl.text = name;
  }

  void pickAvatar() {
    Fluttertoast.showToast(
      msg: 'Photo picker — integrate image_picker package',
      backgroundColor: const Color(0xFF7F8839),
      textColor: Colors.white,
    );
  }

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

      // Store the file object for the API call
      pickedFile.value = file;
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
    pickedFile.value = null;
  }

  void skipResume() => _navigateToDashboard();

  // ── Integrated API Logic ──────────────────────────────────────────────────
  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;

    if (pickedFile.value == null) {
      Fluttertoast.showToast(msg: "Please upload your resume to continue.");
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse("https://aurore-nonappendent-ares.ngrok-free.dev/api/v1/auth/complete-profile");

      // Get the token saved during registration/login
      final token = await _prefs.get('accessToken') ?? '';

      // Create Multipart Request
      var request = http.MultipartRequest('POST', url);

      // Add Headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'X-API-Key': XApikeys,
      });

      // Add Text Fields
      request.fields['fullName'] = nameCtrl.text.trim();
      request.fields['mobileNumber'] = phoneCtrl.text.trim();

      // Add File
      if (pickedFile.value?.path != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'cvfile',
            pickedFile.value!.path!
        ));
      }

      print("Uploading Profile to → $url");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resModel = CompleteProfileReponseModel.fromJson(json.decode(response.body));

        if (resModel.success == true && resModel.data != null) {
          final data = resModel.data!;

          // Save fresh tokens and user info from response
          await _prefs.save('accessToken', data.accessToken ?? "");
          await _prefs.save('refreshToken', data.refreshToken ?? "");
          await _prefs.save('name', data.user?.name ?? nameCtrl.text.trim());
          await _prefs.save('phone', phoneCtrl.text.trim());
          await _prefs.save('isProfileComplete', data.user?.isProfileComplete ?? true);

          Fluttertoast.showToast(msg: resModel.message ?? "Profile Updated!");
          _navigateToDashboard();
        } else {
          Fluttertoast.showToast(msg: resModel.message ?? "Failed to update profile");
        }
      } else {
        print("Error Body: ${response.body}");
        Fluttertoast.showToast(msg: "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Complete Profile Exception: $e");
      Fluttertoast.showToast(msg: "Connection error. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateToDashboard() {
    Get.offAllNamed(AppRoutes.dashboard);
  }
}