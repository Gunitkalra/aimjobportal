import 'dart:convert';
import 'package:aimjobs/api/apilist.dart';
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
import '../../Login/model/RefreshToken_Model.dart';

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
      final url = Uri.parse("${ApiList.baseUrl}/v1/auth/complete-profile");

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

      // --- Refresh Token Interceptor ---
      if (response.statusCode == 401 || response.statusCode == 400) {
        final newToken = await _refreshTokenAndSave();
        if (newToken != null && newToken.isNotEmpty) {
          // Rebuild MultipartRequest because they cannot be reused
          var newRequest = http.MultipartRequest('POST', url);
          newRequest.headers.addAll({
            'Authorization': 'Bearer $newToken',
            'X-API-Key': XApikeys,
          });
          newRequest.fields['fullName'] = nameCtrl.text.trim();
          newRequest.fields['mobileNumber'] = phoneCtrl.text.trim();

          if (pickedFile.value?.path != null) {
            newRequest.files.add(await http.MultipartFile.fromPath(
                'cvfile',
                pickedFile.value!.path!
            ));
          }
          var newStreamedResponse = await newRequest.send();
          response = await http.Response.fromStream(newStreamedResponse);
        } else {
          Fluttertoast.showToast(msg: "Session expired. Please log in again.");
          return;
        }
      }
      // ---------------------------------

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

  Future<String?> _refreshTokenAndSave() async {
    try {
      final storedRefreshToken = await _prefs.get('refreshToken');

      if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
        return null;
      }

      final url = Uri.parse("${ApiList.baseUrl}/v1/auth/refresh");
      final body = {"refreshToken": storedRefreshToken};
      final headers = {
        'Content-Type': 'application/json',
        'X-API-Key': XApikeys,
      };

      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final refreshRes = RefreshTokenResponseModel.fromJson(json.decode(response.body));

        if (refreshRes.success == true && refreshRes.data != null) {
          final data = refreshRes.data!;

          await _prefs.save('accessToken', data.accessToken ?? "");
          await _prefs.save('refreshToken', data.refreshToken ?? "");
          await _prefs.save('tokenType', data.tokenType ?? "");
          
          if (data.user != null) {
            await _prefs.save('userId', data.user!.id ?? "");
            await _prefs.save('userEmail', data.user!.email ?? "");
            await _prefs.save('name', data.user!.name ?? "");
            await _prefs.save('isProfileComplete', data.user!.isProfileComplete ?? false);
          }

          return data.accessToken;
        }
      }
      return null;
    } catch (e) {
      print("Refresh Token Exception: $e");
      return null;
    }
  }
}