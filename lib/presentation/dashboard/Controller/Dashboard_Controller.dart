//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Utils/shared_prehelper.dart';
// import '../../../routes/app_routes.dart';
// import '../model/job_model/Job_Model.dart';
// import '../model/job_model/job_Filter.dart';
//
//
// class DashboardController extends GetxController {
//   final searchCtrl = TextEditingController();
//   final userName = 'there'.obs;
//   final isLoggedIn = false.obs;
//   final isLoading = false.obs;
//   final _prefs = SharedPrefHelper();
//
//   // All jobs (from API later)
//   // final allJobs = <JobModel>[].obs;
//   // Filtered + searched result
//   // final displayedJobs = <JobModel>[].obs;
//
//   final searchQuery = ''.obs;
//   final filter = JobFilter().obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadUser();
//     _loadJobs();
//     searchCtrl.addListener(() {
//       searchQuery.value = searchCtrl.text;
//       // _applyFilters();
//     });
//   }
//
//   @override
//   void onClose() {
//     searchCtrl.dispose();
//     super.onClose();
//   }
//
//   Future<void> _loadUser() async {
//
//     final token = await _prefs.get('token');
//     if (token != null && token.toString().isNotEmpty) {
//       final profileCompleted = await _prefs.get('profileCompleted') ?? false;
//       if (profileCompleted != true) {
//         Get.offAllNamed(AppRoutes.completeProfile);
//         return;
//       }
//       isLoggedIn.value = true;
//       final name = await _prefs.get('name') ?? 'there';
//       userName.value = name.toString().split(' ').first;
//     } else {
//       isLoggedIn.value = false;
//       userName.value = 'Guest';
//     }
//   }
//
//   Future<void> _loadJobs() async {
//     isLoading.value = true;
//     await Future.delayed(const Duration(milliseconds: 600));
//     // TODO: Replace with real API call
//     // allJobs.assignAll(_mockJobs);
//     // displayedJobs.assignAll(_mockJobs);
//     isLoading.value = false;
//   }
//
//   // void _applyFilters() {
//   //   final query = searchQuery.value.toLowerCase().trim();
//   //   final f = filter.value;
//   //
//   //   List<JobModel> result = allJobs.where((job) {
//   //     // Search
//   //     final matchesSearch = query.isEmpty ||
//   //         job.title.toLowerCase().contains(query) ||
//   //         job.company.toLowerCase().contains(query) ||
//   //         job.location.toLowerCase().contains(query) ||
//   //         job.skills.any((s) => s.toLowerCase().contains(query));
//   //
//   //     // Job type
//   //     final matchesJobType =
//   //         f.jobTypes.isEmpty || f.jobTypes.contains(job.jobType);
//   //
//   //     // Work location
//   //     final matchesWorkLocation =
//   //         f.workLocations.isEmpty || f.workLocations.contains(job.workLocation);
//   //
//   //     // Experience level
//   //     final matchesExp =
//   //         f.experiences.isEmpty || f.experiences.contains(job.level);
//   //
//   //     // Salary filter (show jobs >= selected salary)
//   //     final matchesSalary = f.salary == 0 || _parseSalary(job.salary) >= f.salary;
//   //
//   //     return matchesSearch &&
//   //         matchesJobType &&
//   //         matchesWorkLocation &&
//   //         matchesExp &&
//   //         matchesSalary;
//   //   }).toList();
//   //
//   //   displayedJobs.assignAll(result);
//   // }
//
//   double _parseSalary(String salaryStr) {
//     // "12 - 20 Lakhs" → returns 12.0
//     final parts = salaryStr.split(' ');
//     if (parts.isNotEmpty) {
//       return double.tryParse(parts.first) ?? 0;
//     }
//     return 0;
//   }
//
//   void applyFilter(JobFilter newFilter) {
//     filter.value = newFilter;
//     // _applyFilters();
//   }
//
//   void clearFilter() {
//     filter.value = JobFilter();
//     // _applyFilters();
//   }
//
//   void navigateToJobDetail( job) {
//     Get.toNamed(AppRoutes.jobDetail, arguments: job);
//   }
//
//   Future<void> logout() async {
//     await _prefs.clear();
//     Get.offAllNamed(AppRoutes.login);
//   }
//
//   int get activeFilterCount => filter.value.activeCount;
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/constant_utils.dart';
import '../../../Utils/constraint.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../../api/apilist.dart';
import '../../../routes/app_routes.dart';
import '../../Login/model/RefreshToken_Model.dart';
import '../model/job_model/Job_Model.dart';
import '../model/job_model/job_Filter.dart';
import 'Get_Job_Controller.dart';  // ← import job controller
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  final searchCtrl  = TextEditingController();
  final locationCtrl = TextEditingController();
  final userName    = 'there'.obs;
  final userEmail    = ''.obs;
  final isLoggedIn  = false.obs;
  final isLoading   = false.obs;
  final _prefs      = SharedPrefHelper();
  final searchQuery = ''.obs;
  final filter      = JobFilter().obs;

  // ── Grab the already-registered job controller ────────────────────────────
  late final GetAllJobsController _jobCtrl;

  @override
  void onInit() {
    super.onInit();
    _jobCtrl = Get.find<GetAllJobsController>();
    loadUser();
    searchCtrl.addListener(() {
      searchQuery.value = searchCtrl.text;
    });
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    locationCtrl.dispose();
    super.onClose();
  }

  // Future<void> _loadUser() async {
  //   final token = await _prefs.get('token');
  //   if (token != null && token.toString().isNotEmpty) {
  //     final profileCompleted = await _prefs.get('profileCompleted') ?? false;
  //     if (profileCompleted != true) {
  //       Get.offAllNamed(AppRoutes.completeProfile);
  //       return;
  //     }
  //     isLoggedIn.value = true;
  //     final name = await _prefs.get('name') ?? 'there';
  //     userName.value = name.toString().split(' ').first;
  //   } else {
  //     isLoggedIn.value = false;
  //     userName.value   = 'Guest';
  //   }
  // }



  // In your controller - add this method

  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;
      final url = Uri.parse("${ApiList.baseUrl}/v1/profile");

      String? token = await _prefs.get('accessToken');

      var response = await http.delete(
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
          response = await http.delete(
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
        final res = json.decode(response.body);
        if (res['success'] == true) {
          // Clear session/tokens
          await _prefs.clear();

          // or clear all: await _prefs.clear();

          showToastSuccess("Account deleted successfully.");

          // Navigate to Sign Up and remove all previous routes
          Get.offAllNamed('/signup'); // adjust route name as per your app
        } else {
          showToastFail(res['message'] ?? "Failed to delete account.");
        }
      } else {
        showToastFail("Failed to delete account. Please try again.");
      }
    } catch (e) {
      print("Delete Account Error: $e");
      showToastFail("Connection error. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> loadUser() async {
    final token = await _prefs.get('accessToken');          // ✅ was 'token'
    if (token != null && token.toString().isNotEmpty) {
      final profileCompleted = await _prefs.get('isProfileComplete') ?? false; // ✅ was 'profileCompleted'
      if (profileCompleted != true) {
        Get.offAllNamed(AppRoutes.completeProfile);
        return;
      }
      isLoggedIn.value = true;
      final name = await _prefs.get('name') ?? 'there';
      final email = await _prefs.get('userEmail') ?? 'there';
      userName.value = name.toString().split(' ').first;
      userEmail.value= email.toString();
    } else {
      isLoggedIn.value = false;
      userName.value   = 'Guest';
    }
  }
  // ── Called by DashboardScreen._search() ──────────────────────────────────
  // Passes the current active filter along with the query.
  Future<void> triggerSearch(String query) async {
    await _jobCtrl.searchJobs(query, location: locationCtrl.text.trim(), filter: filter.value);
  }

  // ── Called when user taps "Show Jobs" in FilterBottomSheet ───────────────
  void applyFilter(JobFilter newFilter) {
    filter.value = newFilter;

    // Only re-fetch if a search has already been triggered
    if (_jobCtrl.alljobs.isNotEmpty || _jobCtrl.isLoading.value) {
      _jobCtrl.searchJobs(searchCtrl.text.trim(), location: locationCtrl.text.trim(), filter: newFilter);
    }
  }

  void clearFilter() {
    filter.value = JobFilter();
    if (_jobCtrl.alljobs.isNotEmpty || _jobCtrl.isLoading.value) {
      _jobCtrl.searchJobs(searchCtrl.text.trim(), location: locationCtrl.text.trim());
    }
  }

  void navigateToJobDetail(dynamic job) {
    Get.toNamed(AppRoutes.jobDetail, arguments: job);
  }

  Future<void> logout() async {
    await _prefs.clear();
    Get.offAllNamed(AppRoutes.login);
  }

  int get activeFilterCount => filter.value.activeCount;
}


Future<String?> _refreshTokenAndSave() async {
  final _prefs = SharedPrefHelper();
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
