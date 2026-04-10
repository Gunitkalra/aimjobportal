import 'package:flutter/material.dart';
import '../../../../Utils/colors.dart';
import '../../model/job_model/Job_Model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback onTap;

  const JobCard({super.key, required this.job, required this.onTap});

  Color get _logoColor {
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Main content ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top: avatar + title + company ─────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.darkRed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            job.logoText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              job.company,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ── Experience + Location ─────────────────────────
                  Row(
                    children: [
                      Icon(Icons.card_travel_sharp,
                          size: 13, color: AppColors.darkRed),
                      const SizedBox(width: 4),
                      Text(
                        job.experience,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.black),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.location_on,
                          size: 13, color: AppColors.darkRed),
                      const SizedBox(width: 4),
                      Text(
                        job.location,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ── Description ───────────────────────────────────
                  Text(
                    job.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.black,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 10),

                  // ── Tags ──────────────────────────────────────────
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: job.tags
                        .map((tag) => _FlatTag(label: tag))
                        .toList(),
                  ),
                ],
              ),
            ),

            // ── Footer divider + posted info ───────────────────────
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Posted By: ${job.company}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'Posted on: ${job.postedDate}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
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

// ── Flat tag (matches screenshot style) ──────────────────────────────────────

class _FlatTag extends StatelessWidget {
  final String label;
  const _FlatTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.lightRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
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