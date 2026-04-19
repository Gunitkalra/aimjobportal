import 'dart:convert';
import 'package:aimjobs/api/apilist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/constant_utils.dart';
import '../../../Utils/constraint.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../Login/model/RefreshToken_Model.dart';
import '../model/getprofile_Model.dart';

class GetProfileController extends GetxController {
  final isLoading = false.obs;
  final profileData = Rxn<GetProfileResponseModel>();
  final _prefs = SharedPrefHelper();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final url = Uri.parse("${ApiList.baseUrl}/v1/profile");

      String? token = await _prefs.get('accessToken');

      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'X-API-Key': XApikeys,
        },
      );

      // Handle 400 or 401 Unauthorized / Token Expired
      if (response.statusCode == 401 || response.statusCode == 400) {
        final newToken = await _refreshTokenAndSave();
        if (newToken != null && newToken.isNotEmpty) {
          response = await http.get(
            url,
            headers: {
              'Authorization': 'Bearer $newToken',
              'X-API-Key': XApikeys,
            },
          );
        } else {
          showToastFail("Session expired. Please log in again.");
          return;
        }
      }

      if (response.statusCode == 200) {
        final res = GetProfileResponseModel.fromJson(json.decode(response.body));
        if (res.success == true) {
          profileData.value = res;
        }
      } else {
        showToastFail("Failed to fetch profile");
      }
    } catch (e) {
      print("Profile Fetch Error: $e");
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