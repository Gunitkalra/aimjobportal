import 'dart:convert';
import 'package:aimjobs/api/apilist.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/constant_utils.dart';
import '../../../Utils/constraint.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../Login/model/RefreshToken_Model.dart';
import '../model/updateEducation_Model.dart';
import 'getProfile_Controller.dart';

class UpdateEducationController extends GetxController {
  final isLoading = false.obs;
  final _prefs = SharedPrefHelper();

  Future<void> updateEducation({
    required List<Map<String, dynamic>> educationList,
  }) async {
    try {
      isLoading.value = true;
      final url = Uri.parse("${ApiList.baseUrl}/v1/profile/education");

      String? token = await _prefs.get('accessToken');

      final bodyData = {
        "educationList": educationList,
      };

      var response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'X-API-Key': XApikeys,
          'Content-Type': 'application/json',
        },
        body: json.encode(bodyData),
      );

      // Handle 400 or 401 Unauthorized / Token Expired
      if (response.statusCode == 401 || response.statusCode == 400) {
        final newToken = await _refreshTokenAndSave();
        if (newToken != null && newToken.isNotEmpty) {
          response = await http.patch(
            url,
            headers: {
              'Authorization': 'Bearer $newToken',
              'X-API-Key': XApikeys,
              'Content-Type': 'application/json',
            },
            body: json.encode(bodyData),
          );
        } else {
          showToastFail("Session expired. Please log in again.");
          return;
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = UpdateEducationResponseModel.fromJson(json.decode(response.body));
        if (res.success == true) {
          showToastSuccess("Education updated successfully.");
          
          if (Get.isRegistered<GetProfileController>()) {
            Get.find<GetProfileController>().fetchProfile();
          }
        } else {
          showToastFail(res.message ?? "Failed to update education.");
        }
      } else if (response.statusCode == 400) {
        print("EDUCATION API 400 ERROR: ${response.body}");
        showToastFail("Validation Error: ${response.body}");
      } else {
        showToastFail("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Update Education Error: $e");
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
