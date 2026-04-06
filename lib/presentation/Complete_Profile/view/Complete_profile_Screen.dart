import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../../../routes/app_routes.dart';
import '../Controller/Complete_Profile_Controller.dart';


class CompleteProfileScreen extends GetView<CompleteProfileController> {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top progress bar ─────────────────────────────────────
            _TopProgressBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: sh * 0.028),

                      // ── Header ─────────────────────────────────────
                      Text(
                        'Complete Your Profile',
                        style: TextStyle(
                          fontSize: sw * 0.062,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Help employers find the right fit for you',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      SizedBox(height: sh * 0.032),

                      // ── Profile avatar ────────────────────────────
                      Center(
                        child: Stack(
                          children: [
                            Obx(() => Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.appBg1,
                                border: Border.all(
                                  color: AppColors.buttonPrimary.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: controller.avatarPath.value.isEmpty
                                  ? const Icon(
                                Icons.person_outline_rounded,
                                size: 44,
                                color: AppColors.textHint,
                              )
                                  : ClipOval(
                                child: Image.asset(
                                  controller.avatarPath.value,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: controller.pickAvatar,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: AppColors.buttonPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: sh * 0.032),

                      // ── Full name ──────────────────────────────────
                      _FieldLabel(label: 'Full Name *'),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: controller.nameCtrl,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                        decoration: _inputDecoration(
                          hint: 'Enter your full name',
                          prefix: Icons.person_outline_rounded,
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Name is required';
                          if (v.trim().length < 2) return 'Name is too short';
                          return null;
                        },
                      ),

                      SizedBox(height: sh * 0.02),

                      // ── Phone number ──────────────────────────────
                      _FieldLabel(label: 'Phone Number *'),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: controller.phoneCtrl,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        maxLength: 10,
                        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                        decoration: _inputDecoration(
                          hint: 'Enter 10-digit phone number',
                          prefix: Icons.phone_outlined,
                        ).copyWith(counterText: ''),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Phone number is required';
                          if (v.length < 10) return 'Enter a valid 10-digit number';
                          return null;
                        },
                      ),

                      SizedBox(height: sh * 0.02),

                      // ── Email ─────────────────────────────────────
                      _FieldLabel(label: 'Email Address *'),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: controller.emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                        decoration: _inputDecoration(
                          hint: 'Enter your email',
                          prefix: Icons.email_outlined,
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Email is required';
                          if (!GetUtils.isEmail(v.trim())) return 'Enter a valid email';
                          return null;
                        },
                      ),

                      SizedBox(height: sh * 0.02),

                      // ── Job title ─────────────────────────────────
                      _FieldLabel(label: 'Current / Desired Job Title'),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: controller.jobTitleCtrl,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                        decoration: _inputDecoration(
                          hint: 'e.g. Software Engineer, Designer',
                          prefix: Icons.work_outline_rounded,
                        ),
                      ),

                      SizedBox(height: sh * 0.02),

                      // ── Location ──────────────────────────────────
                      _FieldLabel(label: 'Location'),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: controller.locationCtrl,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                        decoration: _inputDecoration(
                          hint: 'City, State',
                          prefix: Icons.location_on_outlined,
                        ),
                      ),

                      SizedBox(height: sh * 0.032),

                      // ── Resume upload section ─────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.appBg1,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border, width: 1.5),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.buttonPrimary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.description_outlined,
                                    color: AppColors.buttonPrimary,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Upload Resume',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'PDF, DOC or DOCX — max 5MB',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: sh * 0.018),

                            Obx(() => controller.resumeFileName.value.isEmpty
                                ? _ResumeUploadArea(
                              onTap: controller.pickResume,
                            )
                                : _ResumeFileCard(
                              fileName: controller.resumeFileName.value,
                              fileSize: controller.resumeFileSize.value,
                              onRemove: controller.removeResume,
                            )),
                          ],
                        ),
                      ),

                      SizedBox(height: sh * 0.012),

                      // ── Skip resume hint ──────────────────────────
                      Center(
                        child: TextButton(
                          onPressed: controller.skipResume,
                          child: const Text(
                            'Skip for now — add resume later',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: sh * 0.028),

                      // ── Save & continue button ────────────────────
                      Obx(() => SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonPrimary,
                            disabledBackgroundColor:
                            AppColors.buttonPrimary.withOpacity(0.6),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            'Save & Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),

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
      hintStyle: const TextStyle(fontSize: 14, color: AppColors.textHint),
      filled: true,
      fillColor: AppColors.appBg1,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: Icon(prefix, color: AppColors.textHint, size: 20),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.buttonPrimary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.textRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.textRed, width: 1.5),
      ),
    );
  }
}

// ── Top progress bar ──────────────────────────────────────────────────────────

class _TopProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Step 2 of 2',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                '100%',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.buttonPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 1.0,
              backgroundColor: AppColors.appBg5,
              color: AppColors.buttonPrimary,
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Resume upload area ────────────────────────────────────────────────────────

class _ResumeUploadArea extends StatelessWidget {
  final VoidCallback onTap;

  const _ResumeUploadArea({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.buttonPrimary.withOpacity(0.35),
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 32,
              color: AppColors.buttonPrimary.withOpacity(0.7),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap to upload your resume',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.buttonPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Supported: PDF, DOC, DOCX',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Resume file card (after upload) ──────────────────────────────────────────

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
        color: AppColors.buttonPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.buttonPrimary.withOpacity(0.25),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.buttonPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.picture_as_pdf_rounded,
              color: AppColors.buttonPrimary,
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
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.buttonPrimary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Uploaded',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.buttonPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      fileSize,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
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
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.line),
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 16,
                color: AppColors.textSecondary,
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
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}