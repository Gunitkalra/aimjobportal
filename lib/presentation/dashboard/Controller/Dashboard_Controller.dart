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


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/shared_prehelper.dart';
import '../../../routes/app_routes.dart';
import '../model/job_model/Job_Model.dart';
import '../model/job_model/job_Filter.dart';
import 'Get_Job_Controller.dart';  // ← import job controller

class DashboardController extends GetxController {
  final searchCtrl  = TextEditingController();
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
    await _jobCtrl.searchJobs(query, filter: filter.value);
  }

  // ── Called when user taps "Show Jobs" in FilterBottomSheet ───────────────
  void applyFilter(JobFilter newFilter) {
    filter.value = newFilter;

    // Only re-fetch if a search has already been triggered
    if (_jobCtrl.alljobs.isNotEmpty || _jobCtrl.isLoading.value) {
      _jobCtrl.searchJobs(searchCtrl.text.trim(), filter: newFilter);
    }
  }

  void clearFilter() {
    filter.value = JobFilter();
    if (_jobCtrl.alljobs.isNotEmpty || _jobCtrl.isLoading.value) {
      _jobCtrl.searchJobs(searchCtrl.text.trim());
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
