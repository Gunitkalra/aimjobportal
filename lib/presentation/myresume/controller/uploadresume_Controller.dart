import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/constant_utils.dart';
import '../../../Utils/constraint.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../Login/model/RefreshToken_Model.dart';
import '../model/UploadResume_Model.dart';
import 'getmyresume_Controller.dart';

class UploadResumeController extends GetxController {
  final isLoading = false.obs;
  final _prefs = SharedPrefHelper();

  Future<void> uploadResume(String filePath) async {
    try {
      isLoading.value = true;
      final url = Uri.parse("https://aurore-nonappendent-ares.ngrok-free.dev/api/v1/resume/upload");

      String? token = await _prefs.get('accessToken');

      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['X-API-Key'] = XApikeys
        ..files.add(await http.MultipartFile.fromPath('file', filePath));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Handle 400 or 401 Unauthorized / Token Expired
      if (response.statusCode == 401 || response.statusCode == 400) {
        final newToken = await _refreshTokenAndSave();
        if (newToken != null && newToken.isNotEmpty) {
          // Retry request
          var retryRequest = http.MultipartRequest('POST', url)
            ..headers['Authorization'] = 'Bearer $newToken'
            ..headers['X-API-Key'] = XApikeys
            ..files.add(await http.MultipartFile.fromPath('file', filePath));

          var retryStreamedResponse = await retryRequest.send();
          response = await http.Response.fromStream(retryStreamedResponse);
        } else {
          showToastFail("Session expired. Please log in again.");
          return;
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = UploadResumeResponseModel.fromJson(json.decode(response.body));
        if (res.success == true) {
          showToastSuccess(res.message ?? "Resume uploaded successfully");
          
          // Refresh the resume view
          if (Get.isRegistered<GetMyResumeController>()) {
            Get.find<GetMyResumeController>().fetchResume();
          }
        } else {
          showToastFail(res.message ?? "Failed to upload resume");
        }
      } else {
        final body = jsonDecode(response.body);
        showToastFail(body['message'] ?? "Failed to upload resume");
      }
    } catch (e) {
      print("Upload Resume Error: $e");
      showToastFail("Connection error.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> _refreshTokenAndSave() async {
    try {
      final storedRefreshToken = await _prefs.get('refreshToken');

      if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
        return null;
      }

      final url = Uri.parse("https://aurore-nonappendent-ares.ngrok-free.dev/api/v1/auth/refresh");
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
