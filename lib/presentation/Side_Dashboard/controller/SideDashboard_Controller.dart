import 'dart:convert';
import 'package:aimjobs/api/apilist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../Utils/constant_utils.dart'; // Ensure XApikeys is here
import '../../../Utils/constraint.dart';     // Ensure showToastFail is here
import '../../../Utils/shared_prehelper.dart';
import '../../Login/model/RefreshToken_Model.dart';
import '../model/getdashboard_Model.dart';


class SideDashboardController extends GetxController {
  // ── Reactive State ────────────────────────────────────────────────────────
  final isLoading = false.obs;
  final userName = ''.obs;

  // Rxn allows the data to be null initially
  final dashboardData = Rxn<GetDashboardResponseModel>();

  final _prefs = SharedPrefHelper();

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  // ── Fetch Dashboard API ───────────────────────────────────────────────────
  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;

      final url = Uri.parse("${ApiList.baseUrl}/v1/dashboard");

      // Get the stored access token
      String? token = await _prefs.get('accessToken');

      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'X-API-Key': XApikeys,
        },
      );

      // ── Handle Token Expiry (400 or 401) ──
      if (response.statusCode == 401 || response.statusCode == 400) {
        print("Dashboard AccessToken expired. Refreshing...");
        final newToken = await _refreshTokenAndSave();

        if (newToken != null && newToken.isNotEmpty) {
          // Retry the request once with the new token
          response = await http.get(
            url,
            headers: {
              'Authorization': 'Bearer $newToken',
              'X-API-Key': XApikeys,
            },
          );
        } else {
          return;
        }
      }

      // ── Process Response ──
      if (response.statusCode == 200) {
        final res = GetDashboardResponseModel.fromJson(json.decode(response.body));

        if (res.success == true) {
          dashboardData.value = res;

          // Update local username reactively
          userName.value = res.data?.fullName ?? "there";

          // Optionally update local cache if name changed on server
          if (res.data?.fullName != null) {
            await _prefs.save('name', res.data!.fullName!);
          }
        } else {
          showToastFail(res.message ?? "Failed to load dashboard");
        }
      } else {
        print("Dashboard API Error: ${response.statusCode} - ${response.body}");
        showToastFail("Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("SideDashboard Exception: $e");
      showToastFail("Connection error. Please check your internet.");
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method for Pull-to-Refresh
  Future<void> refreshDashboard() async {
    await fetchDashboardData();
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