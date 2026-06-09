// import 'dart:io';
//
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../Utils/colors.dart';
// import '../../../routes/app_routes.dart';
// import '../Controller/Dashboard_Controller.dart';
// import '../model/job_model/Job_Model.dart';
//
// // ── Universal URL opener ───────────────────────────────────────────
//
// class JobDetailScreen extends StatelessWidget {
//   const JobDetailScreen({super.key});
//
//   Color get _logoColor {
//     final job = Get.arguments as JobModel;
//     const colors = [
//       Color(0xFFB33A3A),
//       Color(0xFF1A73E8),
//       Color(0xFF34A853),
//       Color(0xFFF4A742),
//       Color(0xFF7B1FA2),
//       Color(0xFF00ACC1),
//     ];
//     return colors[job.company.length % colors.length];
//   }
//   Future<void> openUrl(String urlString) async {
//     if (Platform.isAndroid) {
//       try {
//         final intent = AndroidIntent(
//           action: 'action_view',
//           data: urlString,
//           flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//         );
//         await intent.launch();
//       } catch (e) {
//         print("Android Intent Error: $e");
//         Get.snackbar(
//           "Error",
//           "Could not open link.",
//           snackPosition: SnackPosition.bottom,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } else {
//       // iOS — url_launcher works fine here
//       final uri = Uri.parse(urlString);
//       try {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } catch (e) {
//         print("iOS Launch Error: $e");
//         Get.snackbar(
//           "Error",
//           "Could not open link.",
//           snackPosition: SnackPosition.bottom,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     final job = Get.arguments as JobModel;
//     final sw = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // ── Updated: Standard AppBar with Centered Title ────────────────
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: const Icon(
//               Icons.arrow_back_ios_new_rounded, // Consistent with previous page
//               color: AppColors.textPrimary,
//               size: 20
//           ),
//         ),
//         title: const Text(
//           'Job Detail',
//           style: TextStyle(
//             fontSize: 18,
//             color: AppColors.textPrimary, // Changed to Primary for consistency
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // ── Scrollable content ────────────────────────────────────
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 10), // Adjusted for new AppBar
//
//                     // ── Company header ─────────────────────────────────
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 52,
//                           height: 52,
//                           decoration: BoxDecoration(
//                             color: AppColors.darkRed,
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: Center(
//                             child: Text(
//                               job.logoText,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 14),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 job.title,
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               const SizedBox(height: 3),
//                               Text(
//                                 job.company,
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: AppColors.textSecondary,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 14),
//
//                     // ── Experience + Location ──────────────────────────
//                     Row(
//                       children: [
//                         const Icon(Icons.card_travel_sharp,
//                             size: 15, color: AppColors.darkRed),
//                         const SizedBox(width: 4),
//                         Text(
//                           job.experience,
//                           style: const TextStyle(
//                             fontSize: 13,
//                             color: AppColors.black,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         const Icon(Icons.location_on,
//                             size: 15, color: AppColors.darkRed),
//                         const SizedBox(width: 4),
//                         Text(
//                           job.location,
//                           style: const TextStyle(
//                             fontSize: 13,
//                             color: AppColors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 12),
//
//                     // ── Job type badge ─────────────────────────────────
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 5),
//                       decoration: BoxDecoration(
//                         color: AppColors.appBg1,
//                         borderRadius: BorderRadius.circular(6),
//
//                       ),
//                       child: Text(
//                         job.jobTypes.join(","),
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.black,
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     // ── Tags ───────────────────────────────────────────
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: job.indsector
//                           .map((tag) => _DetailTag(label: tag))
//                           .toList(),
//                     ),
//
//                     const SizedBox(height: 24),
//                     _Divider(),
//
//                     // ── Key Skills ─────────────────────────────────────
//                     const SizedBox(height: 20),
//                     const _SectionTitle(title: 'Key Skills'),
//                     const SizedBox(height: 14),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: job.requiredSkills
//                           .map((s) => _SkillChip(label: s))
//                           .toList(),
//                     ),
//
//                     const SizedBox(height: 24),
//                     _Divider(),
//
//                     // ── Job Description ────────────────────────────────
//                     const SizedBox(height: 20),
//                     const _SectionTitle(title: 'Job Description'),
//                     const SizedBox(height: 12),
//                     Text(
//                       job.description,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: AppColors.black,
//                         height: 1.7,
//                       ),
//                     ),
//
//                     const SizedBox(height: 24),
//                     _Divider(),
//
//                     // ── Education ──────────────────────────────────────
//                     const SizedBox(height: 20),
//                     const _SectionTitle(title: 'Education Requirements'),
//                     const SizedBox(height: 12),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('• ',
//                             style: TextStyle(
//                                 color: AppColors.black, fontSize: 14)),
//                         Expanded(
//                           child: Text(
//                             job.requiredEducation.join('\n'),
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: AppColors.black,
//                               height: 1.5,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     // ── Salary info ────────────────────────────────────
//                     const SizedBox(height: 24),
//                     _Divider(),
//                     const SizedBox(height: 20),
//                     // const _SectionTitle(title: 'Salary'),
//                     // const SizedBox(height: 10),
//                     // Row(
//                     //   children: [
//                     //     Container(
//                     //       padding: const EdgeInsets.symmetric(
//                     //           horizontal: 14, vertical: 8),
//                     //       decoration: BoxDecoration(
//                     //         color: AppColors.buttonPrimary.withOpacity(0.08),
//                     //         borderRadius: BorderRadius.circular(8),
//                     //       ),
//                     //       child: Row(
//                     //         children: [
//                     //           const Icon(Icons.currency_rupee_rounded,
//                     //               size: 15,
//                     //               color: AppColors.buttonPrimary),
//                     //           Text(
//                     //             job.salary,
//                     //             style: const TextStyle(
//                     //               fontSize: 15,
//                     //               fontWeight: FontWeight.w600,
//                     //               color: AppColors.buttonPrimary,
//                     //             ),
//                     //           ),
//                     //         ],
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//
//                     // const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ),
//
//             // ── Bottom action bar ─────────────────────────────────────
//             Container(
//               padding: EdgeInsets.fromLTRB(
//                   20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border(
//                   top: BorderSide(color: AppColors.line, width: 1),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   // Save Job
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       onPressed: () {
//                         final dashCtrl = Get.find<DashboardController>();
//                         if (!dashCtrl.isLoggedIn.value) {
//                           Get.toNamed(AppRoutes.login);
//                           return;
//                         }
//                       },
//                       icon: const Icon(Icons.bookmark_border_rounded,
//                           color: AppColors.darkRed,
//                           size: 24),
//                       label: const Text('Save Job'),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: AppColors.darkRed,
//                         side: const BorderSide(color: AppColors.darkRed, width: 1.5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         textStyle: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   // Apply
//                   Expanded(
//
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         final dashCtrl = Get.find<DashboardController>();
//
//                         if (!dashCtrl.isLoggedIn.value) {
//                           Get.toNamed(AppRoutes.login);
//                           return;
//                         }
//
//                         print("Opening URL: ${job.jobUrl}");
//                         await openUrl(job.jobUrl);  // ✅ clean single call
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.darkRed,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       child: const Text(
//                         'Apply',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ── Helpers ───────────────────────────────────────────────────────────────────
//
// class _Divider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) =>
//       const Divider(height: 1, color: AppColors.line);
// }
//
// class _SectionTitle extends StatelessWidget {
//   final String title;
//   const _SectionTitle({required this.title});
//
//   @override
//   Widget build(BuildContext context) => Text(
//     title,
//     style: const TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.w700,
//       color: Colors.black,
//     ),
//   );
// }
//
// class _SkillChip extends StatelessWidget {
//   final String label;
//   const _SkillChip({required this.label});
//
//   @override
//   Widget build(BuildContext context) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     decoration: BoxDecoration(
//       color: AppColors.lightRed.withOpacity(0.1),
//       borderRadius: BorderRadius.circular(6),
//     ),
//     child: Text(
//       label,
//       style: const TextStyle(
//         fontSize: 12,
//         color: AppColors.darkRed,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//   );
// }
//
// class _DetailTag extends StatelessWidget {
//   final String label;
//   const _DetailTag({required this.label});
//
//   @override
//   Widget build(BuildContext context) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     decoration: BoxDecoration(
//       color: AppColors.lightRed.withOpacity(0.1),
//       borderRadius: BorderRadius.circular(6),
//       // border: Border.all(color: const Color(0xFF90CAF9)),
//     ),
//     child: Text(
//       label,
//       style: const TextStyle(
//         fontSize: 12,
//         color: Color(0xFF1565C0),
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//   );
// }
import 'dart:io';
import 'dart:convert'; // Added for JSON
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../../Savedjobs/controller/SaveJob_Controller.dart';
import '../Controller/Dashboard_Controller.dart';
import '../model/job_model/Job_Model.dart';
import 'package:aimjobs/api/apilist.dart';
import 'package:aimjobs/Utils/shared_prehelper.dart';
import 'package:aimjobs/Utils/constraint.dart';
import 'package:aimjobs/Utils/constant_utils.dart';
import 'package:aimjobs/presentation/Login/model/RefreshToken_Model.dart';
import 'package:aimjobs/presentation/Savedjobs/controller/getallsavedjobs_controller.dart';
import 'package:aimjobs/presentation/Savedjobs/controller/DeleteSavedJobs_Controller.dart';

final RxBool _saveButtonLoading = false.obs;

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  Future<String?> _refreshTokenAndSave(SharedPrefHelper prefs) async {
    try {
      final storedRefreshToken = await prefs.get('refreshToken');

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

          await prefs.save('accessToken', data.accessToken ?? "");
          await prefs.save('refreshToken', data.refreshToken ?? "");
          await prefs.save('tokenType', data.tokenType ?? "");
          
          if (data.user != null) {
            await prefs.save('userId', data.user!.id ?? "");
            await prefs.save('userEmail', data.user!.email ?? "");
            await prefs.save('name', data.user!.name ?? "");
            await prefs.save('isProfileComplete', data.user!.isProfileComplete ?? false);
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

  Future<void> _toggleSaveJob(BuildContext context, String jobId, SavedJobsController savedJobsCtrl) async {
    final _prefs = SharedPrefHelper();
    final isSaved = savedJobsCtrl.savedJobsList.any((j) => j.jobId == jobId);
    
    _saveButtonLoading.value = true;
    try {
      String? token = await _prefs.get('accessToken');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'X-API-Key': XApikeys,
      };

      if (isSaved) {
        // Unsave / Delete
        final url = Uri.parse("${ApiList.baseUrl}/v1/saved-jobs/$jobId");
        final response = await http.delete(url, headers: headers);
        
        var resCode = response.statusCode;
        var resBody = response.body;
        if (resCode == 401 || resCode == 400) {
          final String? newToken = await _refreshTokenAndSave(_prefs);
          if (newToken != null && newToken.isNotEmpty) {
            headers['Authorization'] = 'Bearer $newToken';
            final retryResponse = await http.delete(url, headers: headers);
            resCode = retryResponse.statusCode;
            resBody = retryResponse.body;
          }
        }

        if (resCode == 200 || resCode == 201) {
          showToastSuccess("Job removed successfully");
          await savedJobsCtrl.fetchSavedJobs();
        } else {
          try {
            final body = json.decode(resBody);
            showToastFail(body['message'] ?? "Failed to remove job");
          } catch (_) {
            showToastFail("Failed to remove job: $resCode");
          }
        }
      } else {
        // Save job
        final url = Uri.parse("${ApiList.baseUrl}/v1/saved-jobs");
        final body = json.encode({"jobId": jobId});
        final response = await http.post(url, headers: headers, body: body);

        var resCode = response.statusCode;
        var resBody = response.body;
        if (resCode == 401 || resCode == 400) {
          final String? newToken = await _refreshTokenAndSave(_prefs);
          if (newToken != null && newToken.isNotEmpty) {
            headers['Authorization'] = 'Bearer $newToken';
            final retryResponse = await http.post(url, headers: headers, body: body);
            resCode = retryResponse.statusCode;
            resBody = retryResponse.body;
          }
        }

        if (resCode == 200 || resCode == 201) {
          Get.rawSnackbar(
            messageText: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Job saved successfully",
                    style: TextStyle(
                      color: Color(0xFF1E3A8A),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.closeCurrentSnackbar(),
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFF1E3A8A),
                    size: 18,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFEFF6FF),
            borderColor: const Color(0xFF3B82F6),
            borderWidth: 1,
            borderRadius: 12,
            margin: const EdgeInsets.all(16),
            snackPosition: SnackPosition.top,
            duration: const Duration(seconds: 4),
          );
          await savedJobsCtrl.fetchSavedJobs();
        } else if (resCode == 409) {
          String errorMsg = "Conflict: Job is already saved.";
          try {
            final body = json.decode(resBody);
            if (body != null && body['message'] != null) {
              errorMsg = body['message'].toString();
            }
          } catch (_) {}
          
          Get.rawSnackbar(
            messageText: Row(
              children: [
                Expanded(
                  child: Text(
                    errorMsg,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.closeCurrentSnackbar(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFFEF2F2),
            borderColor: Colors.red,
            borderWidth: 1,
            borderRadius: 12,
            margin: const EdgeInsets.all(16),
            snackPosition: SnackPosition.top,
            duration: const Duration(seconds: 4),
          );
        } else {
          try {
            final body = json.decode(resBody);
            showToastFail(body['message'] ?? "Failed to save job");
          } catch (_) {
            showToastFail("Failed to save job: $resCode");
          }
        }
      }
    } catch (e) {
      print("Toggle Save Job Exception: $e");
      showToastFail("Could not connect to server.");
    } finally {
      _saveButtonLoading.value = false;
    }
  }

  Future<String> _fetchFullDescription(String jobId, String fallback) async {
    try {
      final response = await http.get(
        Uri.parse("https://www.aimjobs.ai/Home/GetJobDetails?id=$jobId"),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['description'] != null) {
          return data['description'] as String;
        }
      }
    } catch (e) {
      print("Error fetching full description: $e");
    }
    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    final job = Get.arguments as JobModel;
    final sw = MediaQuery.of(context).size.width;

    // Initialize the controllers
    final savedJobsCtrl = Get.isRegistered<SavedJobsController>()
        ? Get.find<SavedJobsController>()
        : Get.put(SavedJobsController());
    final deleteCtrl = Get.put(DeleteSavedJobsController());

    return Scaffold(
      backgroundColor: AppColors.appBg1,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary,
              size: 20
          ),
        ),
        title: const Text(
          'Job Detail',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card 1: Above portion containing all job details & full description
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: AppColors.darkRed,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Text(
                                    job.logoText,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      job.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      job.company,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              const Icon(Icons.card_travel_sharp, size: 15, color: AppColors.darkRed),
                              const SizedBox(width: 4),
                              Text(job.experience, style: const TextStyle(fontSize: 13, color: AppColors.black)),
                              const SizedBox(width: 16),
                              const Icon(Icons.location_on, size: 15, color: AppColors.darkRed),
                              const SizedBox(width: 4),
                              Text(job.location, style: const TextStyle(fontSize: 13, color: AppColors.black)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(color: AppColors.appBg1, borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              job.jobTypes.join(","),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.black),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: job.indsector.map((tag) => _DetailTag(label: tag)).toList(),
                          ),
                          const SizedBox(height: 24),
                          _Divider(),
                          const SizedBox(height: 20),
                          const _SectionTitle(title: 'Key Skills'),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: job.requiredSkills.map((s) => _SkillChip(label: s)).toList(),
                          ),
                          const SizedBox(height: 24),
                          _Divider(),
                          const SizedBox(height: 20),
                          const _SectionTitle(title: 'Job Description'),
                          const SizedBox(height: 12),
                          FutureBuilder<String>(
                            future: _fetchFullDescription(job.id, job.description),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.darkRed),
                                    ),
                                  ),
                                );
                              }
                              final desc = snapshot.data ?? job.description;
                              return Text(
                                desc,
                                style: const TextStyle(fontSize: 14, color: AppColors.black, height: 1.7),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Card 2: Education Requirements
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const _SectionTitle(title: 'Education Requirements'),
                          // const SizedBox(height: 12),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     const Text('• ', style: TextStyle(color: AppColors.black, fontSize: 14)),
                          //     Expanded(
                          //       child: Text(
                          //         job.requiredEducation.join('\n'),
                          //         style: const TextStyle(fontSize: 14, color: AppColors.black, height: 1.5),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const _SectionTitle(title: 'Education Requirements'),
                          const SizedBox(height: 12),
                          ...job.requiredEducation.map((edu) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ', style: TextStyle(color: AppColors.black, fontSize: 14)),
                                Expanded(
                                  child: Text(
                                    edu,
                                    style: const TextStyle(fontSize: 14, color: AppColors.black, height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom action bar ─────────────────────────────────────
            Container(
              padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.line, width: 1)),
              ),
              child: Row(
                children: [
                  // ── Save Job Button (Integrated) ────────────────────
                  Expanded(
                    child: Obx(() {
                      final isSaved = savedJobsCtrl.savedJobsList.any((j) => j.jobId == job.id);
                      final isLoading = _saveButtonLoading.value;

                      if (isSaved) {
                        return ElevatedButton.icon(
                          onPressed: isLoading ? null : () {
                            final dashCtrl = Get.find<DashboardController>();
                            if (!dashCtrl.isLoggedIn.value) {
                              Get.toNamed(AppRoutes.login);
                              return;
                            }
                            _toggleSaveJob(context, job.id, savedJobsCtrl);
                          },
                          icon: isLoading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(
                                  Icons.bookmark_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                          label: const Text('Saved'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkRed,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      } else {
                        return OutlinedButton.icon(
                          onPressed: isLoading ? null : () {
                            final dashCtrl = Get.find<DashboardController>();
                            if (!dashCtrl.isLoggedIn.value) {
                              Get.toNamed(AppRoutes.login);
                              return;
                            }
                            _toggleSaveJob(context, job.id, savedJobsCtrl);
                          },
                          icon: isLoading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.darkRed,
                                  ),
                                )
                              : const Icon(
                                  Icons.bookmark_border_rounded,
                                  color: AppColors.darkRed,
                                  size: 24,
                                ),
                          label: const Text('Save Job'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.darkRed,
                            side: const BorderSide(color: AppColors.darkRed, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                  const SizedBox(width: 12),
                  // Apply
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final dashCtrl = Get.find<DashboardController>();
                        if (!dashCtrl.isLoggedIn.value) {
                          Get.toNamed(AppRoutes.login);
                          return;
                        }
                        await openUrl(job.jobUrl);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkRed,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ... (Your openUrl and Helper classes remain the same below)
  Future<void> openUrl(String urlString) async {
    if (Platform.isAndroid) {
      try {
        final intent = AndroidIntent(
          action: 'action_view',
          data: urlString,
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
      } catch (e) {
        Get.snackbar("Error", "Could not open link.", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      final uri = Uri.parse(urlString);
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        Get.snackbar("Error", "Could not open link.", backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
}

// ── Reused Helpers ──
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Divider(height: 1, color: AppColors.line);
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) => Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black));
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: AppColors.lightRed.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
    child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.darkRed, fontWeight: FontWeight.w500)),
  );
}

class _DetailTag extends StatelessWidget {
  final String label;
  const _DetailTag({required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: AppColors.lightRed.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
    child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF1565C0), fontWeight: FontWeight.w500)),
  );
}