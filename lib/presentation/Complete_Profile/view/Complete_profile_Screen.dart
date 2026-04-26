// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../../../Utils/colors.dart';
// import '../../../routes/app_routes.dart';
// import '../Controller/Complete_Profile_Controller.dart';
//
//
//
// class CompleteProfileScreen extends GetView<CompleteProfileController> {
//   const CompleteProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final sw = MediaQuery.of(context).size.width;
//     final sh = MediaQuery.of(context).size.height;
//
//
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // ── Top progress bar ─────────────────────────────────────
//             _TopProgressBar(),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
//                 child: Form(
//                   key: controller.formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: sh * 0.028),
//
//                       // ── Header ─────────────────────────────────────
//                       Text(
//                         'Complete Your Profile',
//                         style: TextStyle(
//                           fontSize: sw * 0.062,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       Text(
//                         'Help employers find the right fit for you',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//
//                       SizedBox(height: sh * 0.032),
//
//                       // ── Full name ──────────────────────────────────
//                       _FieldLabel(label: 'Full Name *'),
//                       SizedBox(height: 8),
//                       TextFormField(
//                         controller: controller.nameCtrl,
//                         textCapitalization: TextCapitalization.words,
//                         textInputAction: TextInputAction.next,
//                         style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//                         decoration: _inputDecoration(
//                           hint: 'Enter your full name',
//                           prefix: Icons.person_outline_rounded,
//                         ),
//                         validator: (v) {
//                           if (v == null || v.trim().isEmpty) return 'Name is required';
//                           if (v.trim().length < 2) return 'Name is too short';
//                           return null;
//                         },
//                       ),
//
//                       SizedBox(height: sh * 0.02),
//
//                       // ── Phone number ──────────────────────────────
//                       _FieldLabel(label: 'Phone Number *'),
//                       SizedBox(height: 8),
//                       TextFormField(
//                         controller: controller.phoneCtrl,
//                         keyboardType: TextInputType.phone,
//                         textInputAction: TextInputAction.next,
//                         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                         maxLength: 10,
//                         style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//                         decoration: _inputDecoration(
//                           hint: 'Enter 10-digit phone number',
//                           prefix: Icons.phone_outlined,
//                         ).copyWith(counterText: ''),
//                         validator: (v) {
//                           if (v == null || v.isEmpty) return 'Phone number is required';
//                           if (v.length < 10) return 'Enter a valid 10-digit number';
//                           return null;
//                         },
//                       ),
//
//                       SizedBox(height: sh * 0.02),
//
//                       // ── Email ─────────────────────────────────────
//                       _FieldLabel(label: 'Email Address *'),
//                       SizedBox(height: 8),
//                       TextFormField(
//                         controller: controller.emailCtrl,
//                         keyboardType: TextInputType.emailAddress,
//                         textInputAction: TextInputAction.next,
//                         style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//                         decoration: _inputDecoration(
//                           hint: 'Enter your email',
//                           prefix: Icons.email_outlined,
//                         ),
//                         validator: (v) {
//                           if (v == null || v.trim().isEmpty) return 'Email is required';
//                           if (!GetUtils.isEmail(v.trim())) return 'Enter a valid email';
//                           return null;
//                         },
//                       ),
//
//                       SizedBox(height: sh * 0.02),
//
//                       // ── Job title ─────────────────────────────────
//                       // _FieldLabel(label: 'Current / Desired Job Title'),
//                       // SizedBox(height: 8),
//                       // TextFormField(
//                       //   controller: controller.jobTitleCtrl,
//                       //   textInputAction: TextInputAction.next,
//                       //   style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//                       //   decoration: _inputDecoration(
//                       //     hint: 'e.g. Software Engineer, Designer',
//                       //     prefix: Icons.work_outline_rounded,
//                       //   ),
//                       // ),
//                       //
//                       // SizedBox(height: sh * 0.02),
//
//                       // ── Location ──────────────────────────────────
//                       // _FieldLabel(label: 'Location'),
//                       // SizedBox(height: 8),
//                       // TextFormField(
//                       //   controller: controller.locationCtrl,
//                       //   textInputAction: TextInputAction.done,
//                       //   style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//                       //   decoration: _inputDecoration(
//                       //     hint: 'City, State',
//                       //     prefix: Icons.location_on_outlined,
//                       //   ),
//                       // ),
//                       //
//                       // SizedBox(height: sh * 0.032),
//
//                       // ── Resume upload section ─────────────────────
//                       Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.appBg1,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: AppColors.border, width: 1.5),
//                         ),
//                         padding: const EdgeInsets.all(20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 40,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                     color: AppColors.darkRed.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: const Icon(
//                                     Icons.description_outlined,
//                                     color: AppColors.textPrimary,
//                                     size: 22,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: const [
//                                       Text(
//                                         'Upload Resume',
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w600,
//                                           color: AppColors.textPrimary,
//                                         ),
//                                       ),
//                                       SizedBox(height: 2),
//                                       Text(
//                                         'PDF, DOC or DOCX — max 5MB',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: AppColors.textMuted,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             SizedBox(height: sh * 0.018),
//
//                             Obx(() => controller.resumeFileName.value.isEmpty
//                                 ? _ResumeUploadArea(
//                               onTap: controller.pickResume,
//                             )
//                                 : _ResumeFileCard(
//                               fileName: controller.resumeFileName.value,
//                               fileSize: controller.resumeFileSize.value,
//                               onRemove: controller.removeResume,
//                             )),
//                           ],
//                         ),
//                       ),
//
//                       SizedBox(height: sh * 0.012),
//
//                       // ── Save & continue button ────────────────────
//                       Obx(() => SizedBox(
//                         width: double.infinity,
//                         height: 52,
//                         child: ElevatedButton(
//                           onPressed: controller.isLoading.value
//                               ? null
//                               : controller.saveProfile,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.darkRed,
//                             disabledBackgroundColor:
//                             AppColors.darkRed.withOpacity(0.6),
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                           ),
//                           child: controller.isLoading.value
//                               ? const SizedBox(
//                             width: 22,
//                             height: 22,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2.5,
//                               color: Colors.white,
//                             ),
//                           )
//                               : const Text(
//                             'Save & Continue',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       )),
//
//                       SizedBox(height: sh * 0.04),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration({
//     required String hint,
//     required IconData prefix,
//     Widget? suffix,
//   }) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(fontSize: 14, color: AppColors.textHint),
//       filled: true,
//       fillColor: AppColors.appBg1,
//       contentPadding:
//       const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       prefixIcon: Icon(prefix, color: AppColors.textHint, size: 20),
//       suffixIcon: suffix,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.darkRed),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.darkRed),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.darkRed, width: 1.5),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.textRed),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.textRed, width: 1.5),
//       ),
//     );
//   }
// }
//
// // ── Top progress bar ──────────────────────────────────────────────────────────
//
// class _TopProgressBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Step 2 of 2',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: AppColors.textMuted,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const Text(
//                 '100%',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: AppColors.darkRed,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: LinearProgressIndicator(
//               value: 1.0,
//               backgroundColor: AppColors.appBg5,
//               color: AppColors.darkRed,
//               minHeight: 5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Resume upload area ────────────────────────────────────────────────────────
//
// class _ResumeUploadArea extends StatelessWidget {
//   final VoidCallback onTap;
//
//   const _ResumeUploadArea({required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         height: 100,
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: AppColors.darkRed.withOpacity(0.35),
//             width: 1.5,
//             style: BorderStyle.solid,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.cloud_upload_outlined,
//               size: 32,
//               color: AppColors.darkRed.withOpacity(0.7),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Tap to upload your resume',
//               style: TextStyle(
//                 fontSize: 13,
//                 color: AppColors.darkRed,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 2),
//             const Text(
//               'Supported: PDF, DOC, DOCX',
//               style: TextStyle(
//                 fontSize: 11,
//                 color: AppColors.textMuted,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ── Resume file card (after upload) ──────────────────────────────────────────
//
// class _ResumeFileCard extends StatelessWidget {
//   final String fileName;
//   final String fileSize;
//   final VoidCallback onRemove;
//
//   const _ResumeFileCard({
//     required this.fileName,
//     required this.fileSize,
//     required this.onRemove,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: AppColors.darkRed.withOpacity(0.06),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: AppColors.darkRed.withOpacity(0.25),
//           width: 1.5,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 44,
//             decoration: BoxDecoration(
//               color: AppColors.darkRed.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(
//               Icons.picture_as_pdf_rounded,
//               color: AppColors.textPrimary,
//               size: 22,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   fileName,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 2),
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 7, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: AppColors.darkRed.withOpacity(0.12),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: const Text(
//                         'Uploaded',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: AppColors.textPrimary,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       fileSize,
//                       style: const TextStyle(
//                         fontSize: 11,
//                         color: AppColors.textMuted,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: onRemove,
//             child: Container(
//               width: 32,
//               height: 32,
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 shape: BoxShape.circle,
//                 border: Border.all(color: AppColors.line),
//               ),
//               child: const Icon(
//                 Icons.close_rounded,
//                 size: 16,
//                 color: AppColors.textRed,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Field label ───────────────────────────────────────────────────────────────
//
// class _FieldLabel extends StatelessWidget {
//   final String label;
//   const _FieldLabel({required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label,
//       style: const TextStyle(
//         fontSize: 14,
//         color: AppColors.textPrimary,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../Controller/Complete_Profile_Controller.dart';

// ── Shared colour tokens ──────────────────────────────────────────────────────
const _kBlue      = Color(0xFF1A56DB);
const _kBlueSoft  = Color(0xFFEFF6FF);
const _kBlueDash  = Color(0xFF93C5FD);
const _kBorder    = Color(0xFFE2E8F0);
const _kBg        = Color(0xFFF8FAFC);
const _kTextPrimary   = Color(0xFF111827);
const _kTextSecondary = Color(0xFF6B7280);
const _kTextHint      = Color(0xFFADB5BD);

class CompleteProfileScreen extends GetView<CompleteProfileController> {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Blue hero header ─────────────────────────────────────
            _HeroHeader(),

            // ── Scrollable form ──────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: sh * 0.028),

                      // ── Full Name ──────────────────────────────────
                      const _FieldLabel(label: 'Full Name *'),
                      const SizedBox(height: 7),
                      TextFormField(
                        controller: controller.nameCtrl,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                            fontSize: 14, color: _kTextPrimary),
                        decoration: _inputDecoration(
                          hint: 'Enter your full name',
                          prefix: Icons.person_outline_rounded,
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty)
                            return 'Name is required';
                          if (v.trim().length < 2)
                            return 'Name is too short';
                          return null;
                        },
                      ),

                      SizedBox(height: sh * 0.02),

                      // ── Mobile Number ──────────────────────────────
                      const _FieldLabel(label: 'Mobile Number *'),
                      const SizedBox(height: 7),
                      TextFormField(
                        controller: controller.phoneCtrl,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 10,
                        style: const TextStyle(
                            fontSize: 14, color: _kTextPrimary),
                        decoration: _inputDecoration(
                          hint: 'Enter 10-digit mobile number',
                          prefix: Icons.phone_outlined,
                        ).copyWith(counterText: ''),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return 'Phone number is required';
                          if (v.length < 10)
                            return 'Enter a valid 10-digit number';
                          return null;
                        },
                      ),

                      SizedBox(height: sh * 0.02),

                      // ── Email (read-only / pre-filled) ─────────────
                      const _FieldLabel(label: 'Email Address'),
                      const SizedBox(height: 7),
                      TextFormField(
                        controller: controller.emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        style: const TextStyle(
                            fontSize: 14, color: _kTextSecondary),
                        decoration: _inputDecoration(
                          hint: 'your@email.com',
                          prefix: Icons.mail_outline_rounded,
                        ).copyWith(
                          fillColor: const Color(0xFFF1F5F9),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty)
                            return 'Email is required';
                          if (!GetUtils.isEmail(v.trim()))
                            return 'Enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Your registered email address',
                        style: TextStyle(
                          fontSize: 12,
                          color: _kTextHint,
                        ),
                      ),

                      SizedBox(height: sh * 0.024),

                      // ── Upload CV card ─────────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: _kBlueSoft,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: _kBlueDash, width: 1.2),
                        ),
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon + title
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: _kBlue.withOpacity(0.12),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.description_outlined,
                                color: AppColors.darkRed,
                                size: 26,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Upload Your CV',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _kTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // AI info banner
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 11),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: _kBorder, width: 1),
                              ),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.auto_awesome_outlined,
                                    color: _kBlue,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Text(
                                      'Our AI will analyze your CV to automatically create your complete professional profile',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: _kTextSecondary,
                                        height: 1.45,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Upload area / file card
                            Obx(() =>
                            controller.resumeFileName.value.isEmpty
                                ? _ResumeUploadArea(
                              onTap: controller.pickResume,
                            )
                                : _ResumeFileCard(
                              fileName: controller
                                  .resumeFileName.value,
                              fileSize: controller
                                  .resumeFileSize.value,
                              onRemove: controller.removeResume,
                            )),
                          ],
                        ),
                      ),

                      SizedBox(height: sh * 0.028),

                      // ── Complete Profile button ────────────────────
                      Obx(() => SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.saveProfile,
                          icon: controller.isLoading.value
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                              : const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: controller.isLoading.value
                              ? const SizedBox.shrink()
                              : const Text(
                            'Complete Profile',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkRed,
                            disabledBackgroundColor:
                            AppColors.darkRed,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )),

                      SizedBox(height: sh * 0.016),

                      // ── Security note ──────────────────────────────
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: _kBg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _kBorder),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.shield_outlined,
                                color: _kTextSecondary, size: 16),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Your information is secure and will only be used to match you with relevant job opportunities.',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: _kTextSecondary,
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: sh * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefix,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: _kTextHint),
      filled: true,
      fillColor: _kBg,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      prefixIcon: Icon(prefix, color: _kTextSecondary, size: 20),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _kBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _kBlue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
            color: Color(0xFFEF4444), width: 1.5),
      ),
    );
  }
}

// ── Blue Hero Header ──────────────────────────────────────────────────────────

class _HeroHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      color: const Color(0xFFEFF6FF),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.darkRed,
              size: 34,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Complete Your Profile',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _kTextPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Just a few more details to get you started',
            style: TextStyle(
              fontSize: 13.5,
              color: _kTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Resume upload area (dashed border) ───────────────────────────────────────

class _ResumeUploadArea extends StatelessWidget {
  final VoidCallback onTap;
  const _ResumeUploadArea({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkRed, width: 1.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: 40,
            color: AppColors.darkRed,
          ),
          const SizedBox(height: 10),
          const Text(
            'Drag & drop your CV here',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _kTextPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'or',
            style: TextStyle(fontSize: 13, color: _kTextSecondary),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkRed,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Browse Files',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Supported formats: PDF, DOC, DOCX (Max 5MB)',
            style: TextStyle(fontSize: 11.5, color: _kTextHint),
          ),
        ],
      ),
    );
  }
}

// ── Resume file card (shown after upload) ────────────────────────────────────

class _ResumeFileCard extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final VoidCallback onRemove;

  const _ResumeFileCard({
    required this.fileName,
    required this.fileSize,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _kBlueSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBlueDash, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 44,
            decoration: BoxDecoration(
              color: _kBlue.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.picture_as_pdf_rounded,
              color: AppColors.darkRed,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _kTextPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kBlue.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Uploaded',
                        style: TextStyle(
                          fontSize: 10,
                          color: _kBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      fileSize,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _kTextSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: _kBorder),
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 16,
                color: Color(0xFFEF4444),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Field label ───────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        color: _kTextPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}