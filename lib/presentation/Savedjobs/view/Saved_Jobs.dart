// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Utils/colors.dart';
// import '../../../routes/app_routes.dart';
//
// // ── Mock saved job model ──────────────────────────────────────────────────────
//
// class _SavedJob {
//   final String id;
//   final String title;
//   final String company;
//   final String location;
//   final String jobType;
//   final String savedDate;
//   final List<String> skills;
//   final String logoText;
//
//   const _SavedJob({
//     required this.id,
//     required this.title,
//     required this.company,
//     required this.location,
//     required this.jobType,
//     required this.savedDate,
//     required this.skills,
//     required this.logoText,
//   });
// }
//
// // ── Screen ────────────────────────────────────────────────────────────────────
//
// class SavedJobsScreen extends StatefulWidget {
//   const SavedJobsScreen({super.key});
//
//   @override
//   State<SavedJobsScreen> createState() => _SavedJobsScreenState();
// }
//
// class _SavedJobsScreenState extends State<SavedJobsScreen> {
//   // Mock saved jobs — remove items on dismiss
//   final List<_SavedJob> _savedJobs = [
//     const _SavedJob(
//       id: '1',
//       title: 'Python Developer',
//       company: 'Tata Consultancy Services',
//       location: 'Mumbai',
//       jobType: 'Full Time',
//       savedDate: 'Saved Mar 30',
//       skills: ['Python', 'REST', 'Scikit-learn', 'Pandas', 'NumPy'],
//       logoText: 'T',
//     ),
//     const _SavedJob(
//       id: '2',
//       title: 'Flutter Developer',
//       company: 'Infosys',
//       location: 'Bangalore',
//       jobType: 'Full Time',
//       savedDate: 'Saved Mar 28',
//       skills: ['Flutter', 'Dart', 'GetX', 'Firebase', 'REST APIs'],
//       logoText: 'I',
//     ),
//     const _SavedJob(
//       id: '3',
//       title: 'UI/UX Designer',
//       company: 'Wipro',
//       location: 'Hyderabad',
//       jobType: 'Full Time',
//       savedDate: 'Saved Mar 25',
//       skills: ['Figma', 'Adobe XD', 'Sketch', 'Prototyping'],
//       logoText: 'W',
//     ),
//     const _SavedJob(
//       id: '4',
//       title: 'React Frontend Developer',
//       company: 'Cognizant',
//       location: 'Chennai',
//       jobType: 'Full Time',
//       savedDate: 'Saved Mar 22',
//       skills: ['React.js', 'TypeScript', 'Redux', 'HTML', 'CSS'],
//       logoText: 'C',
//     ),
//     const _SavedJob(
//       id: '5',
//       title: 'DevOps Engineer',
//       company: 'Tech Mahindra',
//       location: 'Pune',
//       jobType: 'Remote',
//       savedDate: 'Saved Mar 20',
//       skills: ['Docker', 'Kubernetes', 'Jenkins', 'AWS', 'Terraform'],
//       logoText: 'TM',
//     ),
//   ];
//
//   void _removeJob(String id) {
//     setState(() => _savedJobs.removeWhere((j) => j.id == id));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sw = MediaQuery
//         .of(context)
//         .size
//         .width;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F3F7),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         shadowColor: const Color(0xFFEEEEEE),
//         leading: GestureDetector(
//           onTap: () => Get.back(),
//           child: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: 14,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         title: const Text(
//           'Saved Jobs',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         centerTitle: false,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: OutlinedButton.icon(
//               onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(color: AppColors.darkRed, width: 1.5),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 6),
//               ),
//               icon: const Icon(Icons.search_rounded,
//                   color: AppColors.darkRed, size: 15),
//               label: const Text(
//                 'Find More Jobs',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.darkRed,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       // ── FIXED BODY ───────────────────────────────────────────────
//       body: SafeArea(
//
//         child: _savedJobs.isEmpty
//             ?  _EmptyState()
//             : ListView.builder(
//           padding: EdgeInsets.symmetric(
//               horizontal: sw * 0.04, vertical: 16),
//           itemCount: _savedJobs.length,
//           itemBuilder: (_, i) =>
//               _SavedJobCard(
//                 job: _savedJobs[i],
//                 onRemove: () => _removeJob(_savedJobs[i].id),
//                 onApply: () {
//                   // TODO: navigate to job detail
//                 },
//               ),
//         ),
//       ),
//     );
//   }
// }
//
// // ── Top bar ───────────────────────────────────────────────────────────────────
//
// class _TopBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final sw = MediaQuery.of(context).size.width;
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.symmetric(
//           horizontal: sw * 0.05, vertical: 12),
//       child: Row(
//         children: [
//           // Logo
//           Image.asset(
//             'assets/logo.png',
//             height: 60,
//             width: 100,
//             fit: BoxFit.contain,
//             errorBuilder: (_, __, ___) => RichText(
//               text: const TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'AIMJ',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'OBS',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                       color: AppColors.buttonPrimary,
//                     ),
//                   ),
//                   TextSpan(
//                     text: '.AI',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const Spacer(),
//           // Avatar
//           Container(
//             width: 40,
//             height: 40,
//             decoration: const BoxDecoration(
//               color: AppColors.darkRed,
//               shape: BoxShape.circle,
//             ),
//             child: const Center(
//               child: Text(
//                 'T',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Saved job card ────────────────────────────────────────────────────────────
//
// class _SavedJobCard extends StatelessWidget {
//   final _SavedJob job;
//   final VoidCallback onRemove;
//   final VoidCallback onApply;
//
//   const _SavedJobCard({
//     required this.job,
//     required this.onRemove,
//     required this.onApply,
//   });
//
//   // Show only first 4 skills + "+N more"
//   List<Widget> _buildSkillChips() {
//     const maxVisible = 4;
//     final visible = job.skills.take(maxVisible).toList();
//     final extra = job.skills.length - maxVisible;
//
//     final chips = visible
//         .map((s) => _SkillChip(label: s))
//         .toList();
//
//     if (extra > 0) {
//       chips.add(_SkillChip(label: '+$extra', isMore: true));
//     }
//
//     return chips;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Card body ──────────────────────────────────────────
//           Padding(
//             padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title + company row
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Logo box
//                     Container(
//                       width: 46,
//                       height: 46,
//                       decoration: BoxDecoration(
//                         color: AppColors.darkRed,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Text(
//                           job.logoText,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w800,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             job.title,
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             job.company,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: AppColors.textSecondary,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // Info row: location + job type + saved date
//                 Wrap(
//                   spacing: 16,
//                   runSpacing: 4,
//                   children: [
//                     _InfoItem(
//                         icon: Icons.location_on_outlined,
//                         label: job.location),
//                     _InfoItem(
//                         icon: Icons.calendar_today_outlined,
//                         label: job.jobType),
//                     _InfoItem(
//                         icon: Icons.access_time_rounded,
//                         label: job.savedDate),
//                   ],
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // Skills
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 6,
//                   children: _buildSkillChips(),
//                 ),
//               ],
//             ),
//           ),
//
//           // ── Divider ───────────────────────────────────────────
//           const Divider(height: 1, color: Color(0xFFEEEEEE)),
//
//           // ── Action buttons ────────────────────────────────────
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 14, vertical: 10),
//             child: Row(
//               children: [
//                 // Apply Now
//                 Expanded(
//                   child: SizedBox(
//                     height: 42,
//                     child: ElevatedButton.icon(
//                       onPressed: onApply,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.darkRed,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       icon: const Icon(
//                           Icons.open_in_new_rounded,
//                           color: Colors.white,
//                           size: 16),
//                       label: const Text(
//                         'Apply Now',
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 // Remove
//                 Expanded(
//                   child: SizedBox(
//                     height: 42,
//                     child: OutlinedButton.icon(
//                       onPressed: onRemove,
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(
//                             color: Color(0xFFDDDDDD)),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       icon: const Icon(
//                           Icons.delete_outline_rounded,
//                           color: AppColors.textSecondary,
//                           size: 16),
//                       label: const Text(
//                         'Remove',
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Skill chip ────────────────────────────────────────────────────────────────
//
// class _SkillChip extends StatelessWidget {
//   final String label;
//   final bool isMore;
//
//   const _SkillChip({required this.label, this.isMore = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: isMore
//             ? AppColors.darkRed.withOpacity(0.08)
//             : const Color(0xFFF0F0F0),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isMore
//               ? AppColors.darkRed.withOpacity(0.2)
//               : const Color(0xFFDDDDDD),
//         ),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 11,
//           fontWeight: FontWeight.w500,
//           color: isMore ? AppColors.darkRed : AppColors.textSecondary,
//         ),
//       ),
//     );
//   }
// }
//
// // ── Info item ─────────────────────────────────────────────────────────────────
//
// class _InfoItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//
//   const _InfoItem({required this.icon, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 13, color: AppColors.textMuted),
//         const SizedBox(width: 4),
//         Text(
//           label,
//           style: const TextStyle(
//               fontSize: 12, color: AppColors.textSecondary),
//         ),
//       ],
//     );
//   }
// }
//
// // ── Empty state ───────────────────────────────────────────────────────────────
//
// class _EmptyState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final sw = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
//       child: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.only(top: 16),
//         padding: const EdgeInsets.symmetric(
//             vertical: 48, horizontal: 24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Bookmark icon
//             Icon(
//               Icons.bookmark_border_rounded,
//               size: 64,
//               color: Colors.grey.shade300,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'No Saved Jobs Yet',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "You haven't saved any jobs yet. Browse our job listings and save the ones that interest you to apply later.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: AppColors.textSecondary,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: 200,
//               height: 46,
//               child: ElevatedButton(
//                 onPressed: () =>
//                     Get.offAllNamed(AppRoutes.dashboard),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.darkRed,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Start Exploring',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../controller/DeleteSavedJobs_Controller.dart';
import '../controller/getallsavedjobs_controller.dart';
import '../model/GetAllSavedJobs_Model.dart';

class SavedJobsScreen extends GetView<SavedJobsController> {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(SavedJobsController());
    final deleteController = Get.put(DeleteSavedJobsController());
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: const Color(0xFFEEEEEE),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 14,
            color: AppColors.textPrimary,
          ),
        ),
        title: const Text(
          'Saved Jobs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton.icon(
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.darkRed, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              icon: const Icon(Icons.search_rounded, color: AppColors.darkRed, size: 15),
              label: const Text(
                'Find More Jobs',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkRed,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.darkRed),
            );
          }

          if (controller.savedJobsList.isEmpty) {
            return _EmptyState();
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: 16),
            itemCount: controller.savedJobsList.length,
            itemBuilder: (_, i) {
              final job = controller.savedJobsList[i];
              return _SavedJobCard(
                job: job,
                onRemove: () {
                  deleteController.deleteJob(job.jobId ?? "");
                },
                onApply: () async {
                  final Uri url = Uri.parse(job.jobUrl ?? "");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
              );
            },
          );
        }),
      ),
    );
  }
}

// ── Saved job card ────────────────────────────────────────────────────────────

class _SavedJobCard extends StatelessWidget {
  final Datum job;
  final VoidCallback onRemove;
  final VoidCallback onApply;

  const _SavedJobCard({
    required this.job,
    required this.onRemove,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SavedJobsController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.darkRed,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          (job.companyName ?? "C").substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.jobTitle ?? "Job Title",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            job.companyName ?? "Company",
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 4,
                  children: [
                    _InfoItem(
                        icon: Icons.location_on_outlined,
                        label: job.locations.isEmpty ? "N/A" : job.locations.first),
                    _InfoItem(
                        icon: Icons.calendar_today_outlined,
                        label: job.salaryPeriod ?? "Full Time"),
                    _InfoItem(
                        icon: Icons.access_time_rounded,
                        label: controller.formatDate(job.savedAt)),
                  ],
                ),
                const SizedBox(height: 10),
                // Show all skills from API
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: job.requiredSkills
                      .map((s) => _SkillChip(label: s))
                      .toList(),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: ElevatedButton.icon(
                      onPressed: onApply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkRed,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.open_in_new_rounded,
                          color: Colors.white, size: 16),
                      label: const Text(
                        'Apply Now',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: OutlinedButton.icon(
                      onPressed: onRemove,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFDDDDDD)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.delete_outline_rounded,
                          color: AppColors.textSecondary, size: 16),
                      label: const Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reused Helpers ────────────────────────────────────────────────────────────

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lightRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.lightRed.withOpacity(0.4), width: 0.5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.darkRed,
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.textMuted),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bookmark_border_rounded, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 20),
            const Text(
              'No Saved Jobs Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "You haven't saved any jobs yet. Browse our job listings and save the ones that interest you to apply later.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              height: 46,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkRed,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Start Exploring',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}