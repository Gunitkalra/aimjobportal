// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Utils/colors.dart';
// import '../Controller/Dashboard_Controller.dart';
//
// // ── Mock job model ────────────────────────────────────────────────────────────
//
// class _JobModel {
//   final String title;
//   final String company;
//   final String experience;
//   final String location;
//   final String description;
//   final List<String> tags;
//   final String postedBy;
//   final String postedOn;
//
//   const _JobModel({
//     required this.title,
//     required this.company,
//     required this.experience,
//     required this.location,
//     required this.description,
//     required this.tags,
//     required this.postedBy,
//     required this.postedOn,
//   });
// }
//
// final _mockJobs = [
//   _JobModel(
//     title: 'Testing (Domain_Docsis)',
//     company: 'Tata Consultancy Services',
//     experience: '6-9 Yrs',
//     location: 'Chennai',
//     description:
//     'Strong knowledge of software testing methodologies. Familiarity with DOCSIS domain and related protocols. Analytical and problem-solving skills. Experience wit...',
//     tags: ['Senior', 'Technology', 'On-site', 'IT Services'],
//     postedBy: 'Tata Consultancy Services',
//     postedOn: '06 Mar 2026',
//   ),
//   _JobModel(
//     title: 'Net Developer',
//     company: 'Tata Consultancy Services',
//     experience: '3-10 Yrs',
//     location: 'Chennai',
//     description:
//     '3 - 10 years of experience in VB.net, C#.net and MS SQL Server. Designs and develops need-based software programs. Documents testing, error...',
//     tags: ['Mid-level', 'Technology', 'On-site', 'IT Services'],
//     postedBy: 'Tata Consultancy Services',
//     postedOn: '04 Mar 2026',
//   ),
//   _JobModel(
//     title: 'Python Developer',
//     company: 'Tata Consultancy Services',
//     experience: '3-10 Yrs',
//     location: 'Chennai',
//     description:
//     'Strong server-side Engineering: Python, REST APIs, asynchronous and functional programming. Experience with Python libraries for AI/ML, NLP & AP...',
//     tags: ['Mid-level', 'IT Infrastructure Services', 'On-site', 'IT Services'],
//     postedBy: 'Tata Consultancy Services',
//     postedOn: '06 Mar 2026',
//   ),
//   _JobModel(
//     title: 'Software Developer',
//     company: 'Tata Consultancy Services',
//     experience: '3-10 Yrs',
//     location: 'Mumbai',
//     description:
//     'Must Have: Proficient in Core Java, Spring Boot. Hands on experience in Microservices. Good to have: Hands on distributed version control repository...',
//     tags: ['Mid-level', 'IT Infrastructure Services', 'On-site'],
//     postedBy: 'Tata Consultancy Services',
//     postedOn: '06 Mar 2026',
//   ),
//   _JobModel(
//     title: 'Servicenow Irm Developer',
//     company: 'Tata Consultancy Services',
//     experience: '3-10 Yrs',
//     location: 'Bengaluru',
//     description:
//     'Job Role: Servicenow IRM Developer Location: Pan India Experience: 4+ Years Job Description: 08+ years of strong experience in software development...',
//     tags: ['Mid-level', 'Technology', 'On-site', 'IT Services'],
//     postedBy: 'Tata Consultancy Services',
//     postedOn: '06 Mar 2026',
//   ),
//   _JobModel(
//     title: 'End User Support - L1',
//     company: 'Tata Consultancy Services',
//     experience: '3-5 Yrs',
//     location: 'Ahmedabad',
//     description:
//     'Location - Dholera. Required Technical Skill Set: Strong knowledge of Windows and macOS operating systems. Basic understanding of Linux environment...',
//     tags: ['Mid-level', 'Consultancy', 'On-site', 'IT Services'],
//     postedBy: 'Tata Consultancy Services',
//     postedOn: '06 Mar 2026',
//   ),
//   _JobModel(
//     title: 'Automation Tester',
//     company: 'Tata Consultancy Services',
//     experience: '3-10 Yrs',
//     location: 'Pune',
//     description:
//     'More than 6 years of IT experience of which at least 1 year as a team leader and managing automation testing team. Sound understanding of software...',
//     tags: ['Mid-level', 'Business Process Services', 'On-site'],
//     postedBy: 'Tata Consultancy Services',
//     postedOn: '06 Mar 2026',
//   ),
// ];
//
// // ── Dashboard Screen ──────────────────────────────────────────────────────────
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   // ✅ Key declared here — never recreated on rebuild
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _skillsCtrl = TextEditingController();
//   final _locationCtrl = TextEditingController();
//
//   bool _hasSearched = false;
//   List<_JobModel> _results = [];
//
//   late final DashboardController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = Get.find<DashboardController>();
//   }
//
//   @override
//   void dispose() {
//     _skillsCtrl.dispose();
//     _locationCtrl.dispose();
//     super.dispose();
//   }
//
//   void _search() {
//     FocusScope.of(context).unfocus();
//     setState(() {
//       _hasSearched = true;
//       _results = _mockJobs;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sw = MediaQuery.of(context).size.width;
//     final sh = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: AppColors.appBg1,
//       drawer: _SideDrawer(controller: controller),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // ── Top bar ────────────────────────────────────────────
//             Container(
//               color: AppColors.white,
//               padding: EdgeInsets.symmetric(
//                   horizontal: sw * 0.05, vertical: 14),
//               child: Row(
//                 children: [
//                   RichText(
//                     text: const TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'AIMJ',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w800,
//                             color: AppColors.textPrimary,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'OBS',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w800,
//                             color: AppColors.buttonPrimary,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         TextSpan(
//                           text: '.AI',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w800,
//                             color: AppColors.textPrimary,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Spacer(),
//                   Obx(() {
//                     final c = Get.find<DashboardController>();
//                     final initial = c.userName.value.isNotEmpty
//                         ? c.userName.value[0].toUpperCase()
//                         : 'U';
//                     return GestureDetector(
//                       onTap: () => _scaffoldKey.currentState?.openDrawer(),
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: const BoxDecoration(
//                           color: AppColors.darkRed,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Text(
//                             initial,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ],
//               ),
//             ),
//
//             // ── Body ──────────────────────────────────────────────
//             Expanded(
//               child: SingleChildScrollView(
//                 keyboardDismissBehavior:
//                 ScrollViewKeyboardDismissBehavior.onDrag,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ── Search section ───────────────────────────
//                     Container(
//                       width: double.infinity,
//                       color: AppColors.white,
//                       padding: EdgeInsets.fromLTRB(
//                           sw * 0.05,
//                           _hasSearched ? sh * 0.02 : sh * 0.03,
//                           sw * 0.05,
//                           _hasSearched ? sh * 0.02 : sh * 0.035),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (!_hasSearched) ...[
//                             RichText(
//                               text: const TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: 'Get Your ',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w800,
//                                       color: AppColors.textPrimary,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: 'Dream Career Job',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w800,
//                                       color: AppColors.buttonPrimary,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: ' Now',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w800,
//                                       color: AppColors.textPrimary,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             const Text(
//                               'Multilevel Jobs for You to Explore',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: AppColors.textSecondary,
//                               ),
//                             ),
//                             SizedBox(height: sh * 0.025),
//                           ],
//
//                           // Search card
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.07),
//                                   blurRadius: 20,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             padding: const EdgeInsets.all(16),
//                             child: Column(
//                               children: [
//                                 TextField(
//                                   controller: _skillsCtrl,
//                                   textInputAction: TextInputAction.next,
//                                   style: const TextStyle(
//                                       fontSize: 14,
//                                       color: AppColors.textPrimary),
//                                   decoration: InputDecoration(
//                                     hintText:
//                                     'Skills, Designations, Companies',
//                                     hintStyle: const TextStyle(
//                                         fontSize: 14,
//                                         color: AppColors.textHint),
//                                     border: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColors.border),
//                                     ),
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColors.border),
//                                     ),
//                                     focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColors.buttonPrimary),
//                                     ),
//                                     contentPadding:
//                                     const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 TextField(
//                                   controller: _locationCtrl,
//                                   textInputAction: TextInputAction.search,
//                                   onSubmitted: (_) => _search(),
//                                   style: const TextStyle(
//                                       fontSize: 14,
//                                       color: AppColors.textPrimary),
//                                   decoration: const InputDecoration(
//                                     hintText: 'Location',
//                                     hintStyle: TextStyle(
//                                         fontSize: 14,
//                                         color: AppColors.textHint),
//                                     border: InputBorder.none,
//                                     contentPadding: EdgeInsets.symmetric(
//                                         vertical: 10),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   height: 48,
//                                   child: DecoratedBox(
//                                     decoration: BoxDecoration(
//                                       gradient: const LinearGradient(
//                                         colors: [
//                                           Color(0xFFE8453C),
//                                           Color(0xFFD63384),
//                                         ],
//                                       ),
//                                       borderRadius:
//                                       BorderRadius.circular(10),
//                                     ),
//                                     child: ElevatedButton(
//                                       onPressed: _search,
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.transparent,
//                                         shadowColor: Colors.transparent,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                           BorderRadius.circular(10),
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         'Search Job',
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // ── Results / Stats ──────────────────────────
//                     if (!_hasSearched)
//                       Center(
//                         child: Container(
//                           width: double.infinity,
//                           color: AppColors.appBg1,
//                           padding:
//                           EdgeInsets.symmetric(vertical: sh * 0.04),
//                           child: Column(
//                             children: [
//                               _StatItem(
//                                 value: '4+',
//                                 label: 'Companies',
//                                 valueColor: AppColors.buttonPrimary,
//                               ),
//                               SizedBox(height: sh * 0.04),
//                               _StatItem(
//                                 value: '5340+',
//                                 label: 'Jobs',
//                                 valueColor: AppColors.darkRed,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     else ...[
//                       // Results header
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(
//                             sw * 0.05, 18, sw * 0.05, 4),
//                         child: Row(
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   const TextSpan(
//                                     text: 'We found ',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w700,
//                                       color: AppColors.textPrimary,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: '${_results.length}',
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w800,
//                                       color: AppColors.darkRed,
//                                     ),
//                                   ),
//                                   const TextSpan(
//                                     text: ' Matches\nfor you.',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w700,
//                                       color: AppColors.textPrimary,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Spacer(),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 8),
//                               decoration: BoxDecoration(
//                                 color: AppColors.white,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                     color: AppColors.border),
//                               ),
//                               child: Row(
//                                 children: const [
//                                   Icon(Icons.tune_rounded,
//                                       size: 16,
//                                       color: AppColors.textPrimary),
//                                   SizedBox(width: 6),
//                                   Text(
//                                     'Filters',
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.textPrimary,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       const SizedBox(height: 12),
//
//                       // Job cards
//                       ListView.separated(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: sw * 0.04),
//                         itemCount: _results.length,
//                         separatorBuilder: (_, __) =>
//                         const SizedBox(height: 12),
//                         itemBuilder: (_, i) =>
//                             _JobCard(job: _results[i]),
//                       ),
//
//                       const SizedBox(height: 24),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ── Job Card ──────────────────────────────────────────────────────────────────
//
// class _JobCard extends StatelessWidget {
//   final _JobModel job;
//   const _JobCard({required this.job});
//
//   @override
//   Widget build(BuildContext context) {
//     final initial = job.company.isNotEmpty
//         ? job.company[0].toUpperCase()
//         : 'C';
//
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.border, width: 1),
//       ),
//       padding: const EdgeInsets.all(14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Header row ─────────────────────────────────────────
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 42,
//                 height: 42,
//                 decoration: BoxDecoration(
//                   color: AppColors.darkRed,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Text(
//                     initial,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       job.title,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       job.company,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 10),
//
//           // ── Experience & Location ──────────────────────────────
//           Row(
//             children: [
//               const Icon(Icons.access_time_rounded,
//                   size: 13, color: AppColors.textMuted),
//               const SizedBox(width: 4),
//               Text(
//                 job.experience,
//                 style: const TextStyle(
//                     fontSize: 12, color: AppColors.textMuted),
//               ),
//               const SizedBox(width: 14),
//               const Icon(Icons.location_on_outlined,
//                   size: 13, color: AppColors.textMuted),
//               const SizedBox(width: 4),
//               Text(
//                 job.location,
//                 style: const TextStyle(
//                     fontSize: 12, color: AppColors.textMuted),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 8),
//
//           // ── Description ────────────────────────────────────────
//           Text(
//             job.description,
//             style: const TextStyle(
//               fontSize: 12,
//               color: AppColors.textSecondary,
//               height: 1.5,
//             ),
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//           ),
//
//           const SizedBox(height: 10),
//
//           // ── Tags ───────────────────────────────────────────────
//           Wrap(
//             spacing: 6,
//             runSpacing: 6,
//             children: job.tags
//                 .map((tag) => Container(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: AppColors.appBg1,
//                 borderRadius: BorderRadius.circular(6),
//                 border:
//                 Border.all(color: AppColors.border, width: 1),
//               ),
//               child: Text(
//                 tag,
//                 style: const TextStyle(
//                   fontSize: 11,
//                   color: AppColors.textSecondary,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ))
//                 .toList(),
//           ),
//
//           const SizedBox(height: 10),
//           const Divider(height: 1, color: AppColors.border),
//           const SizedBox(height: 8),
//
//           // ── Footer ────────────────────────────────────────────
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   'Posted By: ${job.postedBy}',
//                   style: const TextStyle(
//                       fontSize: 10, color: AppColors.textMuted),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Text(
//                 'Posted on: ${job.postedOn}',
//                 style: const TextStyle(
//                     fontSize: 10, color: AppColors.textMuted),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Stat item ─────────────────────────────────────────────────────────────────
//
// class _StatItem extends StatelessWidget {
//   final String value;
//   final String label;
//   final Color valueColor;
//
//   const _StatItem({
//     required this.value,
//     required this.label,
//     required this.valueColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 36,
//             fontWeight: FontWeight.w800,
//             color: valueColor,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//             color: AppColors.textPrimary,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ── Side Drawer ───────────────────────────────────────────────────────────────
//
// class _SideDrawer extends StatelessWidget {
//   final DashboardController controller;
//   const _SideDrawer({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: AppColors.white,
//       child: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 20, vertical: 18),
//               child: Row(
//                 children: [
//                   Obx(() {
//                     final initial = controller.userName.value.isNotEmpty
//                         ? controller.userName.value[0].toUpperCase()
//                         : 'U';
//                     return Container(
//                       width: 46,
//                       height: 46,
//                       decoration: const BoxDecoration(
//                         color: AppColors.darkRed,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Text(
//                           initial,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Obx(() => Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           controller.userName.value,
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.textPrimary,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           controller.userName.value,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: AppColors.textSecondary,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     )),
//                   ),
//                   GestureDetector(
//                     onTap: () => Get.back(),
//                     child: const Icon(Icons.close,
//                         color: AppColors.textSecondary, size: 22),
//                   ),
//                 ],
//               ),
//             ),
//
//             const Divider(height: 1, color: AppColors.border),
//
//             _DrawerItem(
//                 icon: Icons.speed_outlined,
//                 label: 'Dashboard',
//                 onTap: () => Get.back()),
//             _DrawerItem(
//               icon: Icons.person_outline_rounded,
//               label: 'Profile',
//               onTap: () => Get.back(),
//             ),
//             _DrawerItem(
//               icon: Icons.bookmark_outline_rounded,
//               label: 'Saved Jobs',
//               onTap: () => Get.back(),
//             ),
//             _DrawerItem(
//               icon: Icons.description_outlined,
//               label: 'My Resume',
//               onTap: () => Get.back(),
//             ),
//             _DrawerItem(
//               icon: Icons.search_rounded,
//               label: 'Search',
//               onTap: () => Get.back(),
//             ),
//
//             const Divider(height: 1, color: AppColors.border),
//
//             _DrawerItem(
//               icon: Icons.logout_rounded,
//               label: 'Logout',
//               labelColor: AppColors.textRed,
//               iconColor: AppColors.textRed,
//               onTap: controller.logout,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ── Drawer item ───────────────────────────────────────────────────────────────
//
// class _DrawerItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final Color iconColor;
//   final Color labelColor;
//
//   const _DrawerItem({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     this.iconColor = AppColors.textPrimary,
//     this.labelColor = AppColors.textPrimary,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Row(
//           children: [
//             Icon(icon, size: 22, color: iconColor),
//             const SizedBox(width: 16),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//                 color: labelColor,
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
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../Controller/Dashboard_Controller.dart';
import 'widget/filter_sheet.dart';
import 'widget/job_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _locationCtrl = TextEditingController(); // ✅ only location is local

  bool _hasSearched = false;

  late final DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<DashboardController>();

    // ✅ ADD THIS — reset to home screen when search is cleared
    controller.searchCtrl.addListener(() {
      if (controller.searchCtrl.text.isEmpty && _hasSearched) {
        setState(() => _hasSearched = false);
      }
    });
  }
  @override
  void dispose() {
    _locationCtrl.dispose();
    super.dispose();
  }

  void _search() {
    FocusScope.of(context).unfocus();

    // ✅ ADD THIS — if nothing typed, go back to home
    if (controller.searchCtrl.text.trim().isEmpty &&
        _locationCtrl.text.trim().isEmpty) {
      setState(() => _hasSearched = false);
      return;
    }

    setState(() => _hasSearched = true);
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBg1,
      drawer: _SideDrawer(controller: controller),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──────────────────────────────────────────────
            Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.05, vertical: 14),
              child: Row(
                children: [
                  // RichText(
                  //   text: const TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'AIMJ',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w800,
                  //           color: AppColors.textPrimary,
                  //           letterSpacing: 0.5,
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: 'OBS',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w800,
                  //           color: AppColors.buttonPrimary,
                  //           letterSpacing: 0.5,
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: '.AI',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w800,
                  //           color: AppColors.textPrimary,
                  //           letterSpacing: 0.5,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 100,
                  ),
                  const Spacer(),
                  Obx(() {
                    final initial = controller.userName.value.isNotEmpty
                        ? controller.userName.value[0].toUpperCase()
                        : 'U';
                    return GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.darkRed,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            initial,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // ── Body ──────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Search section ─────────────────────────────────
                    Container(
                      width: double.infinity,
                      color: AppColors.white,
                      padding: EdgeInsets.fromLTRB(
                        sw * 0.05,
                        _hasSearched ? sh * 0.02 : sh * 0.03,
                        sw * 0.05,
                        _hasSearched ? sh * 0.02 : sh * 0.035,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!_hasSearched) ...[
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Get Your ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Dream Career Job',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.darkRed,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Now',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Multilevel Jobs for You to Explore',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: sh * 0.025),
                          ],

                          // ── Search card ──────────────────────────────
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.07),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                // ✅ Skills field bound to controller.searchCtrl
                                TextField(
                                  controller: controller.searchCtrl,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textPrimary),
                                  decoration: InputDecoration(
                                    hintText:
                                    'Skills, Designations, Companies',
                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textHint),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.border),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.border),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.buttonPrimary),
                                    ),
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        vertical: 10),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Location field (local ctrl, not in controller)
                                TextField(
                                  controller: _locationCtrl,
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (_) => _search(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textPrimary),
                                  decoration: const InputDecoration(
                                    hintText: 'Location',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textHint),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: AppColors.blueGradient, // ✅ use here
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _search,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Search Job',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
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
                    ),

                    // ── Stats OR Results ────────────────────────────────
                    if (!_hasSearched)
                      Center(
                        child: Container(
                          width: double.infinity,
                          color: AppColors.appBg1,
                          padding:
                          EdgeInsets.symmetric(vertical: sh * 0.04),
                          child: Column(
                            children: [
                              _StatItem(
                                value: '4+',
                                label: 'Companies',
                                valueColor: AppColors.darkRed,
                              ),
                              SizedBox(height: sh * 0.04),
                              _StatItem(
                                value: '5340+',
                                label: 'Jobs',
                                valueColor: AppColors.darkRed,
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Obx(() {
                        if (controller.isLoading.value) {
                          return Padding(
                            padding: EdgeInsets.only(top: sh * 0.1),
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.buttonPrimary),
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Results header
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  sw * 0.05, 18, sw * 0.05, 4),
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'We found ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                          '${controller.displayedJobs.length}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.darkRed,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: ' Matches\nfor you.',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (_) => FilterBottomSheet(
                                          currentFilter: controller.filter.value,
                                          onApply: controller.applyFilter,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: AppColors.border),
                                      ),
                                      child: Obx(() {
                                        final count = controller.activeFilterCount;
                                        return Row(
                                          children: [
                                            Icon(Icons.tune_rounded,
                                                size: 16,
                                                color: count > 0
                                                    ? AppColors.buttonPrimary
                                                    : AppColors.textPrimary),
                                            const SizedBox(width: 6),
                                            Text(
                                              count > 0 ? 'Filters ($count)' : 'Filters',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: count > 0
                                                    ? AppColors.buttonPrimary
                                                    : AppColors.textPrimary,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Job cards
                            ListView.builder(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: sw * 0.04),
                              itemCount:
                              controller.displayedJobs.length,
                              itemBuilder: (_, i) {
                                final job =
                                controller.displayedJobs[i];
                                return JobCard(
                                  job: job,
                                  onTap: () => controller
                                      .navigateToJobDetail(job),
                                );
                              },
                            ),

                            const SizedBox(height: 24),
                          ],
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat item ─────────────────────────────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const _StatItem({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// ── Side Drawer ───────────────────────────────────────────────────────────────

class _SideDrawer extends StatelessWidget {
  final DashboardController controller;
  const _SideDrawer({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  Obx(() {
                    final initial = controller.userName.value.isNotEmpty
                        ? controller.userName.value[0].toUpperCase()
                        : 'U';
                    return Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: AppColors.darkRed,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          initial,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userName.value,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          controller.userName.value,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close,
                        color: AppColors.textSecondary, size: 22),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: AppColors.border),

            _DrawerItem(
              icon: Icons.speed_outlined,
              label: 'Dashboard',
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.sideDashboard);
              },
            ),
            _DrawerItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              onTap: () => Get.back(),
            ),
            _DrawerItem(
              icon: Icons.bookmark_outline_rounded,
              label: 'Saved Jobs',
              onTap: () => Get.back(),
            ),
            _DrawerItem(
              icon: Icons.description_outlined,
              label: 'My Resume',
              onTap: () => Get.back(),
            ),
            _DrawerItem(
              icon: Icons.search_rounded,
              label: 'Search',
              onTap: () => Get.back(),
            ),

            const Divider(height: 1, color: AppColors.border),

            _DrawerItem(
              icon: Icons.logout_rounded,
              label: 'Logout',
              labelColor: AppColors.textRed,
              iconColor: AppColors.textRed,
              onTap: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Drawer item ───────────────────────────────────────────────────────────────

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;
  final Color labelColor;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = AppColors.textPrimary,
    this.labelColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}