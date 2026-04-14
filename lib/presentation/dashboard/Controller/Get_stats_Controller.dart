import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../Utils/constant_utils.dart'; // Ensure XApikeys is here
import '../../../Utils/constraint.dart';
import '../model/getstats/getstatsModel.dart';     // Ensure showToastFail is here
// Import your model file path here
// import '../model/stats_model.dart';

class GetStatsController extends GetxController {
  // ── Reactive State ────────────────────────────────────────────────────────
  var isLoading = false.obs;

  // Rxn allows the model to be null initially
  var statsData = Rxn<GetStatsResponseModel>();

  @override
  void onInit() {
    super.onInit();
    fetchStats(); // Auto-fetch when controller is initialized
  }

  // ── Core Fetch ────────────────────────────────────────────────────────────
  Future<void> fetchStats() async {
    try {
      isLoading.value = true;

      final url = Uri.parse("https://correct-dogs-rent-virtue.trycloudflare.com/api/stats");

      final headers = {
        'Content-Type': 'application/json',
        'X-API-Key': XApikeys, // Using your constant
      };

      print("Fetching Stats → $url");
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);

        // Map the JSON to your GetStatsResponseModel
        statsData.value = GetStatsResponseModel.fromJson(decodedData);

        print("Stats fetched successfully");
      } else if (response.statusCode == 401) {
        showToastFail("Unauthorized. Please check your API key.");
      } else if (response.statusCode == 403) {
        showToastFail("Access denied to statistics.");
      } else {
        showToastFail("Server Error: ${response.statusCode}");
      }
    } catch (e, stack) {
      print("Exception in GetStatsController: $e\n$stack");
      showToastFail("Failed to load stats. Check your connection.");
    } finally {
      isLoading.value = false;
    }
  }

  // ── Helper Getters for UI ─────────────────────────────────────────────────
  // These make it easier to bind data to charts or cards
  int get totalJobs => statsData.value?.totalJobsCount ?? 0;

  List<MapEntry<String, int>> get topSkillsList {
    return statsData.value?.topSkills.entries.toList() ?? [];
  }
}