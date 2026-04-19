// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../../Utils/constant_utils.dart';
// import '../../../Utils/constraint.dart';
// import '../model/job_model/Get_Job_Model.dart';
// import '../model/job_model/Job_Model.dart';
//
// class GetAllJobsController extends GetxController {
//   var isLoading        = false.obs;  // first-page / new-search load
//   var isPaginating     = false.obs;  // subsequent page loads
//   var alljobs          = <JobModel>[].obs;
//   var currentPage      = 1.obs;
//   var totalPages       = 1.obs;
//   var totalResults     = 0.obs;
//   String _lastQuery    = '';
//
//   bool get hasMore => currentPage.value < totalPages.value;
//
//   // ── Called on fresh search ────────────────────────────────────────────────
//   Future<void> searchJobs(String q) async {
//     _lastQuery       = q;
//     currentPage.value = 1;
//     alljobs.clear();
//     await _fetchPage(q, 1, isFirstLoad: true);
//   }
//
//   // ── Called when user scrolls to bottom / taps Load More ──────────────────
//   Future<void> loadNextPage() async {
//     if (!hasMore || isPaginating.value || isLoading.value) return;
//     final nextPage = currentPage.value + 1;
//     await _fetchPage(_lastQuery, nextPage, isFirstLoad: false);
//   }
//
//   // ── Core fetch ────────────────────────────────────────────────────────────
//   Future<void> _fetchPage(String q, int page,
//       {required bool isFirstLoad}) async {
//     try {
//       if (isFirstLoad) {
//         isLoading.value = true;
//       } else {
//         isPaginating.value = true;
//       }
//
//       final url = Uri.parse(
//         "https://correct-dogs-rent-virtue.trycloudflare.com/api/jobs"
//             "?q=${Uri.encodeComponent(q)}&page=$page",
//       );
//
//       final headers = {
//         'Content-Type': 'application/json',
//         'X-API-Key': XApikeys,
//       };
//
//       print("Fetching → $url");
//       final response = await http.get(url, headers: headers);
//       print("Status: ${response.statusCode}");
//
//       if (response.statusCode == 200) {
//         final data = GetJobsResponseModel.fromJson(
//           json.decode(response.body) as Map<String, dynamic>,
//         );
//
//         // ✅ APPEND for pagination, replace for first load
//         if (isFirstLoad) {
//           alljobs.value = data.jobs;
//         } else {
//           alljobs.addAll(data.jobs);
//         }
//
//         currentPage.value  = data.currentPage;
//         totalPages.value   = data.totalPages;
//         totalResults.value = data.totalResults;
//
//         print("Page $page loaded | "
//             "jobs this page: ${data.jobs.length} | "
//             "total loaded: ${alljobs.length} | "
//             "total available: ${data.totalResults}");
//       } else if (response.statusCode == 401) {
//         showToastFail("Unauthorized. Please login again.");
//       } else if (response.statusCode == 403) {
//         showToastFail("Access denied.");
//       } else {
//         showToastFail("Failed to fetch jobs. Status: ${response.statusCode}");
//       }
//     } catch (e, stack) {
//       print("Exception: $e\n$stack");
//       showToastFail("Error: ${e.toString()}");
//     } finally {
//       isLoading.value    = false;
//       isPaginating.value = false;
//     }
//   }
// }


import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../Utils/constant_utils.dart';
import '../../../Utils/constraint.dart';
import '../../../api/apilist.dart';
import '../model/job_model/Get_Job_Model.dart';
import '../model/job_model/Job_Model.dart';
import '../model/job_model/job_Filter.dart';

class GetAllJobsController extends GetxController {
  var isLoading    = false.obs;
  var isPaginating = false.obs;
  var alljobs      = <JobModel>[].obs;
  var currentPage  = 1.obs;
  var totalPages   = 1.obs;
  var totalResults = 0.obs;

  String _lastQuery = '';
  JobFilter _lastFilter = JobFilter();

  bool get hasMore => currentPage.value < totalPages.value;

  // ── Called on fresh search or filter apply ────────────────────────────────
  Future<void> searchJobs(String q, {JobFilter? filter}) async {
    _lastQuery        = q;
    _lastFilter       = filter ?? JobFilter();
    currentPage.value = 1;
    alljobs.clear();
    await _fetchPage(q, 1, _lastFilter, isFirstLoad: true);
  }

  // ── Called when user scrolls to bottom ───────────────────────────────────
  Future<void> loadNextPage() async {
    if (!hasMore || isPaginating.value || isLoading.value) return;
    final nextPage = currentPage.value + 1;
    // reuse the same query + filter for next page
    await _fetchPage(_lastQuery, nextPage, _lastFilter, isFirstLoad: false);
  }

  // ── Core fetch ────────────────────────────────────────────────────────────
  Future<void> _fetchPage(
      String q,
      int page,
      JobFilter filter, {
        required bool isFirstLoad,
      }) async {
    try {
      if (isFirstLoad) {
        isLoading.value = true;
      } else {
        isPaginating.value = true;
      }

      // ── Build query parameters ────────────────────────────────────────────
      final params = <String, String>{};

      if (q.isNotEmpty) params['q'] = q;

      params['page'] = page.toString();

      // Job types  → "Full-time,Part-time"
      if (filter.jobTypes.isNotEmpty) {
        params['job_types'] = _mapJobTypes(filter.jobTypes).join(',');
      }

      // Work location → "On-site,Remote,Hybrid"
      if (filter.workLocations.isNotEmpty) {
        params['location_type'] = _mapWorkLocations(filter.workLocations).join(',');
      }

      // Experience → seniority_level  (only single value supported by API)
      if (filter.experiences.isNotEmpty) {
        params['seniority_level'] = _mapExperiences(filter.experiences).join(',');
      }

      // Salary (in Lakhs) — skip if 0
      if (filter.salary > 0) {
        params['salary'] = filter.salary.toInt().toString();
      }

      // Posted date → discovery_period
      if (filter.postedDates.isNotEmpty) {
        final period = _mapPostedDate(filter.postedDates.first);
        if (period != null) params['discovery_period'] = period;
      }

      final url = Uri.parse(
        "${ApiList.baseUrl1}/jobs",
      ).replace(queryParameters: params);

      final headers = {
        'Content-Type': 'application/json',
        'X-API-Key': XApikeys,
      };

      print("Fetching → $url");
      final response = await http.get(url, headers: headers);
      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = GetJobsResponseModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        if (isFirstLoad) {
          alljobs.value = data.jobs;
        } else {
          alljobs.addAll(data.jobs);
        }

        currentPage.value  = data.currentPage;
        totalPages.value   = data.totalPages;
        totalResults.value = data.totalResults;

        print("Page $page | this page: ${data.jobs.length} | total: ${alljobs.length} / ${data.totalResults}");
      } else if (response.statusCode == 401) {
        showToastFail("Unauthorized. Please login again.");
      } else if (response.statusCode == 403) {
        showToastFail("Access denied.");
      } else {
        showToastFail("Failed to fetch jobs. Status: ${response.statusCode}");
      }
    } catch (e, stack) {
      print("Exception: $e\n$stack");
      showToastFail("Error: ${e.toString()}");
    } finally {
      isLoading.value    = false;
      isPaginating.value = false;
    }
  }

  // ── Value mappers (UI label → API value) ─────────────────────────────────

  List<String> _mapJobTypes(List<String> types) {
    const map = <String, String>{
      'Full-Time'  : 'Full-time',
      'Part-Time'  : 'Part-time',
      'Contractor' : 'Contract',
      'Freelance'  : 'Freelance',
      'Intern'     : 'Internship',
      'Permanent'  : 'Permanent',
    };
    return types.map((t) => map[t] ?? t).toList();
  }

  List<String> _mapWorkLocations(List<String> locations) {
    const map = <String, String>{
      'Hybrid'  : 'Hybrid',
      'Remote'  : 'Remote',
      'On-site' : 'On-site',
    };
    return locations.map((l) => map[l] ?? l).toList();
  }

  List<String> _mapExperiences(List<String> exps) {
    const map = <String, String>{
      'Entry Level' : 'Entry-level',
      'Mid Level'   : 'Mid-level',
      'Senior'      : 'Senior',
      'Lead'        : 'Lead',
      'Director'    : 'Director',
      'Executive'   : 'Executive',
    };
    return exps.map((e) => map[e] ?? e).toList();
  }

  String? _mapPostedDate(String label) {
    const map = <String, String>{
      'Today'       : '1',
      'This week'   : '7',
      'Last 2 weeks': '14',
      'This month'  : '30',
        // omit param entirely
    };
    return map[label];
  }
}
