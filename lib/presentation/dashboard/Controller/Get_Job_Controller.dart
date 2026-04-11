import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Utils/constraint.dart';
import '../model/job_model/Get_Job_Model.dart';

class GetJobController extends GetxController {
  var isLoading = false.obs;
  var allJobs = <Job>[].obs;
  var errorMessage = ''.obs;
  var totalResults = 0.obs;
  var totalPages = 0.obs;
  var currentPage = 1.obs;

  /// Fetch jobs from API
  /// @param query - Search keyword (e.g. "software")
  /// @param location - Location keyword (e.g. "Delhi")
  /// @param page  - Page number (default 1)
  Future<void> getJobs({String query = '', String location = '', int page = 1}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String urlStr = 'https://aurore-nonappendent-ares.ngrok-free.dev/api/jobs'
          '?q=${Uri.encodeComponent(query)}&page=$page';
          
      if (location.isNotEmpty) {
        urlStr += '&location=${Uri.encodeComponent(location)}';
      }

      final url = Uri.parse(urlStr);

      print('🔍 Fetching jobs: $url');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'x-api-key': XApikeys,
        },
      );

      print('📊 Status code: ${response.statusCode}');
      print('📄 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseModel = GetJobsResponseModel.fromJson(json);

        allJobs.value = responseModel.jobs;
        totalResults.value = responseModel.totalResults;
        totalPages.value = responseModel.totalPages;
        currentPage.value = responseModel.currentPage;

        print('✅ Total results: ${totalResults.value}');
        print('✅ Total pages: ${totalPages.value}');
        print('✅ Current page: ${currentPage.value}');
        print('✅ Jobs fetched: ${allJobs.length}');

        for (int i = 0; i < allJobs.length; i++) {
          final job = allJobs[i];
          print('──────────────── Job ${i + 1} ────────────────');
          print('🆔 ID            : ${job.id}');
          print('📌 Title         : ${job.jobTitle}');
          print('🏢 Company       : ${job.companyName}');
          print('🌐 Company URL   : ${job.companyUrl}');
          print('🔗 Job URL       : ${job.jobUrl}');
          print('📍 Locations     : ${job.locationNames}');
          print('📅 Posted Date   : ${job.postedDate}');
          print('💼 Job Types     : ${job.jobTypes}');
          print('🏠 Location Type : ${job.locationType}');
          print('🏭 Company Type  : ${job.companyType}');
          print('🏭 Industry      : ${job.industrySectors}');
          print('📆 Closing Date  : ${job.closingDate}');
          print('🛠  Skills        : ${job.requiredSkills}');
          print('📊 Seniority     : ${job.seniorityLevel}');
          print('⚙️  Job Function  : ${job.jobFunction}');
          print('📈 Experience    : ${job.minRequiredExperience} - ${job.maxRequiredExperience} yrs');
          print('🎓 Education     : ${job.requiredEducation}');
          print('🌍 Languages     : ${job.languages}');
          print('💰 Salary        : ${job.minSalary} - ${job.maxSalary} ${job.salaryCurrency ?? ''} ${job.salaryPeriod ?? ''}');
          print('📝 Highlight     : ${job.highlight}');
          print('📍 Location      : ${job.location}');
          print('⏱  Employment    : ${job.employmentType}');
        }
      } else if (response.statusCode == 401) {
        errorMessage.value = 'Unauthorized. Please login again.';
        print('❌ 401 Unauthorized');
      } else if (response.statusCode == 403) {
        errorMessage.value = 'Forbidden. Insufficient permissions.';
        print('❌ 403 Forbidden');
      } else {
        errorMessage.value = 'Error: ${response.statusCode}';
        print('❌ Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stack) {
      errorMessage.value = 'Exception: ${e.toString()}';
      print('💥 Exception: $e');
      print('📋 Stack: $stack');
    } finally {
      isLoading.value = false;
    }
  }
}

