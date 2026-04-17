import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/constant_utils.dart';
import '../../../Utils/constraint.dart';
import '../../../Utils/shared_prehelper.dart';

import '../../Login/model/RefreshToken_Model.dart';
import '../model/AddJobs_Model.dart';

class SaveJobController extends GetxController {
  final isLoading = false.obs;
  final _prefs = SharedPrefHelper();

  Future<void> saveJob(String jobId) async {
    try {
      isLoading.value = true;

      // 1. Prepare Request Data
      final url = Uri.parse("https://aurore-nonappendent-ares.ngrok-free.dev/api/v1/saved-jobs");
      String? token = await _prefs.get('accessToken');

      final body = json.encode({"jobId": jobId});

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'X-API-Key': XApikeys,
      };

      // 2. First Attempt
      print("Attempting to save job...");
      var response = await http.post(url, headers: headers, body: body);

      // 3. Handle 401 (Unauthorized / Token Expired)
      if (response.statusCode == 401) {
        print("AccessToken expired. Attempting to refresh...");

        final String? newToken = await _refreshTokenAndSave();

        if (newToken != null && newToken.isNotEmpty) {
          print("Token refreshed. Retrying save job...");

          // Update the headers with the new token
          headers['Authorization'] = 'Bearer $newToken';

          // 4. Second Attempt (Retry)
          response = await http.post(url, headers: headers, body: body);
        } else {
          // Token refresh failed or no refresh token found
          showToastFail("Session expired. Please log in again.");
          return;
        }
      }

      // 5. Process Final Response
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = AddJobResponseModel.fromJson(json.decode(response.body));
        if (res.success == true) {
          showToastSuccess(res.message ?? "Job saved successfully");
        } else {
          showToastFail(res.message ?? "Failed to save job");
        }
      } else {
        print("Final Error Body: ${response.body}");
        showToastFail("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Save Job Exception: $e");
      showToastFail("Could not connect to server.");
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

          // Save the full response data to SharedPreferences
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