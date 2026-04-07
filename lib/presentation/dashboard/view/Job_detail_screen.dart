import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../model/job_model/Job_Model.dart';


class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  Color get _logoColor {
    final job = Get.arguments as JobModel;
    const colors = [
      Color(0xFFB33A3A),
      Color(0xFF1A73E8),
      Color(0xFF34A853),
      Color(0xFFF4A742),
      Color(0xFF7B1FA2),
      Color(0xFF00ACC1),
    ];
    return colors[job.company.length % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final job = Get.arguments as JobModel;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── App bar ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: AppColors.textPrimary, size: 20),
                  ),

                  Center(
                    child: const Text(
                      'Job Detail',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                ],
              ),
            ),

            // ── Scrollable content ────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),

                    // ── Company header ─────────────────────────────────
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

                    // ── Experience + Location ──────────────────────────
                    Row(
                      children: [
                        const Icon(Icons.work_history_outlined,
                            size: 15, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          job.experience,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.location_on_outlined,
                            size: 15, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          job.location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ── Job type badge ─────────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: const Color(0xFFFFCC80), width: 1),
                      ),
                      child: Text(
                        job.jobType,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ── Tags ───────────────────────────────────────────
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: job.tags
                          .map((tag) => _DetailTag(label: tag))
                          .toList(),
                    ),

                    const SizedBox(height: 24),
                    _Divider(),

                    // ── Key Skills ─────────────────────────────────────
                    const SizedBox(height: 20),
                    const _SectionTitle(title: 'Key Skills'),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: job.skills
                          .map((s) => _SkillChip(label: s))
                          .toList(),
                    ),

                    const SizedBox(height: 24),
                    _Divider(),

                    // ── Job Description ────────────────────────────────
                    const SizedBox(height: 20),
                    const _SectionTitle(title: 'Job Description'),
                    const SizedBox(height: 12),
                    Text(
                      job.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.7,
                      ),
                    ),

                    const SizedBox(height: 24),
                    _Divider(),

                    // ── Education ──────────────────────────────────────
                    const SizedBox(height: 20),
                    const _SectionTitle(title: 'Education Requirements'),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ',
                            style: TextStyle(
                                color: AppColors.textSecondary, fontSize: 14)),
                        Expanded(
                          child: Text(
                            job.education,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // ── Salary info ────────────────────────────────────
                    const SizedBox(height: 24),
                    _Divider(),
                    const SizedBox(height: 20),
                    const _SectionTitle(title: 'Salary'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.buttonPrimary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.currency_rupee_rounded,
                                  size: 15,
                                  color: AppColors.buttonPrimary),
                              Text(
                                job.salary,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.buttonPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // ── Bottom action bar ─────────────────────────────────────
            Container(
              padding: EdgeInsets.fromLTRB(
                  20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: AppColors.line, width: 1),
                ),
              ),
              child: Row(
                children: [
                  // Save Job
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_border_rounded,
                          color: AppColors.darkRed,
                          size: 24),
                      label: const Text('Save Job'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.line, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Apply
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Apply action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkRed,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, color: AppColors.line);
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.appBg1,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        color: AppColors.darkRed,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class _DetailTag extends StatelessWidget {
  final String label;
  const _DetailTag({required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFF90CAF9)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xFF1565C0),
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}