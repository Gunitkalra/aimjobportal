import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';
import '../../dashboard/Controller/Dashboard_Controller.dart';

class SideDashboardScreen extends GetView<DashboardController> {
  const SideDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      // ── Updated: Using Standard AppBar ──────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true, // This forces the title to the center
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary,
              size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),

      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable content ───────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.04, vertical: 16),
                child: Column(
                  children: [
                    // 1. Welcome card
                    _WelcomeCard(controller: controller),
                    const SizedBox(height: 14),

                    // 2. Profile strength + Saved jobs row
                    _StatsRow(controller: controller),
                    const SizedBox(height: 14),

                    // 3. Profile completion
                    const _ProfileCompletionCard(),
                    const SizedBox(height: 14),

                    // 4. Complete your profile
                    const _CompleteProfileCard(),
                    const SizedBox(height: 14),

                    // 5. Quick actions
                    const _QuickActionsCard(),
                    const SizedBox(height: 14),

                    // 6. Recent activity
                    const _RecentActivityCard(),
                    const SizedBox(height: 14),

                    // 7. CV Status
                    const _CvStatusCard(),
                    const SizedBox(height: 14),

                    // 8. Profile tips
                    const _ProfileTipsCard(),
                    const SizedBox(height: 20),

                    // 9. Footer
                    const _Footer(),
                    const SizedBox(height: 16),
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

// ── Welcome card ──────────────────────────────────────────────────────────────

class _WelcomeCard extends StatelessWidget {
  final DashboardController controller;
  const _WelcomeCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Obx(() {
        final initial = controller.userName.value.isNotEmpty
            ? controller.userName.value[0].toUpperCase()
            : 'U';
        final name = controller.userName.value.isNotEmpty
            ? controller.userName.value
            : 'there';
        return Column(
          children: [
            // Avatar circle
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.25),
                border: Border.all(
                    color: Colors.white.withOpacity(0.4), width: 2),
              ),
              child: Center(
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome back, $name!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Here's your profile overview and\njob search activity",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ── Stats row (Profile Strength + Saved Jobs) ─────────────────────────────────

class _StatsRow extends StatelessWidget {
  final DashboardController controller;
  const _StatsRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StatTile(
          icon: Icons.speed_rounded,
          iconBgColor: const Color(0xFF2ECC71),
          value: '81%',
          label: 'Profile Strength',
        ),
        const SizedBox(height: 10),
        _StatTile(
          icon: Icons.bookmark_rounded,
          iconBgColor: const Color(0xFF2196F3),
          value: '0',
          label: 'Saved Jobs',
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String value;
  final String label;

  const _StatTile({
    required this.icon,
    required this.iconBgColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Profile completion card ───────────────────────────────────────────────────

class _ProfileCompletionCard extends StatelessWidget {
  const _ProfileCompletionCard();

  @override
  Widget build(BuildContext context) {
    final sections = [
      ('Personal Information', 0.80, '80%'),
      ('Job Details', 0.35, '35%'),
      ('Profile Summary', 1.0, '100%'),
      ('Skills & Languages', 0.50, '50%'),
      ('Work Experience', 1.0, '100%'),
      ('Education', 1.0, '100%'),
    ];

    return _SectionCard(
      icon: Icons.trending_up_rounded,
      iconColor: AppColors.darkRed,
      title: 'Profile Completion',
      child: Column(
        children: [
          // Circular progress
          SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: 0.81,
                    strokeWidth: 12,
                    backgroundColor: const Color(0xFFE0E0E0),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF2ECC71)),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '81%',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Complete',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Section bars
          ...sections.map((s) => _SectionBar(
            label: s.$1,
            progress: s.$2,
            percent: s.$3,
          )),
        ],
      ),
    );
  }
}

class _SectionBar extends StatelessWidget {
  final String label;
  final double progress;
  final String percent;

  const _SectionBar({
    required this.label,
    required this.progress,
    required this.percent,
  });

  IconData get _icon {
    if (label.contains('Personal')) return Icons.person_outline_rounded;
    if (label.contains('Job')) return Icons.work_outline_rounded;
    if (label.contains('Summary')) return Icons.article_outlined;
    if (label.contains('Skills')) return Icons.lightbulb_outline_rounded;
    if (label.contains('Work')) return Icons.business_outlined;
    return Icons.school_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_icon, size: 16, color: AppColors.darkRed),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Text(
                percent,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor:
              const AlwaysStoppedAnimation<Color>(AppColors.darkRed),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Complete your profile card ────────────────────────────────────────────────

class _CompleteProfileCard extends StatelessWidget {
  const _CompleteProfileCard();

  @override
  Widget build(BuildContext context) {
    final importantItems = [
      (
      'Current CTC',
      'Job Details',
      'Helps employers provide relevant salary offers',
      '1 min'
      ),
      (
      'Notice Period',
      'Job Details',
      'Employers need to know your availability timeline',
      '1 min'
      ),
      (
      'Preferred Locations',
      'Job Details',
      "Ensures you only see jobs in cities you're willing to relocate to",
      '2 min'
      ),
      (
      'Languages (at least 2)',
      'Skills & Languages',
      'Many roles require specific language proficiency',
      '1 min'
      ),
    ];

    final optionalItems = [
      (
      'Date of Birth',
      'Personal Information',
      'Helps employers understand your career stage',
      '30 sec'
      ),
      (
      'Industry',
      'Job Details',
      'Improves job recommendations in your sector',
      '30 sec'
      ),
      (
      'Department',
      'Job Details',
      'Helps filter jobs by functional area',
      '30 sec'
      ),
    ];

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                const Icon(Icons.warning_rounded,
                    color: AppColors.darkRed, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Complete Your Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.darkRed.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${importantItems.length + optionalItems.length} items',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkRed,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // Important section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                const Icon(Icons.info_rounded,
                    color: Color(0xFFF4A742), size: 18),
                const SizedBox(width: 8),
                Text(
                  'IMPORTANT (${importantItems.length})',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF4A742),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          ...importantItems.map((item) => _ProfileTaskCard(
            title: item.$1,
            category: item.$2,
            description: item.$3,
            time: item.$4,
            isImportant: true,
          )),

          const SizedBox(height: 4),

          // Optional section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                const Icon(Icons.remove_circle_outline_rounded,
                    color: AppColors.textSecondary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'OPTIONAL (${optionalItems.length})',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          ...optionalItems.map((item) => _ProfileTaskCard(
            title: item.$1,
            category: item.$2,
            description: item.$3,
            time: item.$4,
            isImportant: false,
          )),

          // + more link
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Text(
              '+ 1 more optional fields',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.darkRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTaskCard extends StatelessWidget {
  final String title;
  final String category;
  final String description;
  final String time;
  final bool isImportant;

  const _ProfileTaskCard({
    required this.title,
    required this.category,
    required this.description,
    required this.time,
    required this.isImportant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isImportant
            ? const Color(0xFFFFF8F0)
            : const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: isImportant
                ? const Color(0xFFF4A742)
                : const Color(0xFFCCCCCC),
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.darkRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        size: 12, color: AppColors.darkRed),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkRed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.label_outline_rounded,
                  size: 13, color: AppColors.buttonPrimary),
              const SizedBox(width: 4),
              Text(
                category,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.buttonPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.blueGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.arrow_circle_right_outlined,
                    size: 16, color: Colors.white),
                label: const Text(
                  'Complete',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick actions card ────────────────────────────────────────────────────────

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      icon: Icons.bolt_rounded,
      iconColor: AppColors.darkRed,
      title: 'Quick Actions',
      child: Column(
        children: [
          // Search Jobs — filled red
          SizedBox(
            width: double.infinity,
            height: 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.blueGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_rounded,
                        color: Colors.white, size: 28),
                    SizedBox(height: 4),
                    Text(
                      'Search Jobs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Saved Jobs
          _QuickActionTile(
            icon: Icons.bookmark_rounded,
            iconColor: const Color(0xFF2196F3),
            label: 'Saved Jobs',
            labelColor: const Color(0xFF2196F3),
            onTap: () {},
          ),
          const SizedBox(height: 10),

          // View Resume
          _QuickActionTile(
            icon: Icons.description_rounded,
            iconColor: const Color(0xFF2ECC71),
            label: 'View Resume',
            labelColor: const Color(0xFF2ECC71),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color labelColor;
  final VoidCallback onTap;

  const _QuickActionTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.labelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Recent Activity card ──────────────────────────────────────────────────────

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard();

  @override
  Widget build(BuildContext context) {
    final activities = [
      (
      Icons.edit_rounded,
      'Profile Updated',
      'You updated your profile information',
      '1 weeks ago'
      ),
      (
      Icons.upload_file_rounded,
      'CV Upload',
      "CV 'ANKUR CV.pdf new-converted (1).pdf' - Status: Pending",
      '1 weeks ago'
      ),
      (
      Icons.person_add_rounded,
      'Profile Created',
      'Your profile was created',
      '1 weeks ago'
      ),
    ];

    return _SectionCard(
      icon: Icons.access_time_rounded,
      iconColor: AppColors.darkRed,
      title: 'Recent Activity',
      child: Column(
        children: activities.asMap().entries.map((e) {
          final i = e.key;
          final a = e.value;
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.darkRed,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(a.$1,
                        color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.$2,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          a.$3,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          a.$4,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (i < activities.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, color: Color(0xFFEEEEEE)),
                )
              else
                const SizedBox(height: 4),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ── CV Status card ────────────────────────────────────────────────────────────

class _CvStatusCard extends StatelessWidget {
  const _CvStatusCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      icon: Icons.description_rounded,
      iconColor: AppColors.darkRed,
      title: 'CV Status',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.picture_as_pdf_rounded,
                    color: Colors.red.shade600, size: 28),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ANKUR CV.pdf new-converted (1).pdf',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Uploaded Mar 30, 2026 at 08:39 AM',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Pending badge
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time_rounded,
                    size: 16, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Text(
                  'Pending Processing',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.25,
              minHeight: 6,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF00BCD4)),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '25% processed',
            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

// ── Profile Tips card ─────────────────────────────────────────────────────────

class _ProfileTipsCard extends StatelessWidget {
  const _ProfileTipsCard();

  @override
  Widget build(BuildContext context) {
    final tips = [
      'Keep your skills updated with trending technologies',
      'Add specific achievements in your work experience',
      'Upload a professional profile picture',
      'Check for job matches daily to stay ahead',
    ];

    return _SectionCard(
      icon: Icons.lightbulb_rounded,
      iconColor: AppColors.darkRed,
      title: 'Profile Tips',
      child: Column(
        children: tips.asMap().entries.map((e) {
          final i = e.key;
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_rounded,
                      color: Color(0xFF2ECC71), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      e.value,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              if (i < tips.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(height: 1, color: Color(0xFFEEEEEE)),
                )
              else
                const SizedBox(height: 4),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLink('About Us'),
            const _FooterDivider(),
            _FooterLink('Privacy Policy'),
            const _FooterDivider(),
            _FooterLink('Terms & Conditions'),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          '© 2026 Aim Job Techno. All Rights Reserved.',
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  const _FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 12, color: AppColors.textSecondary),
      ),
    );
  }
}

class _FooterDivider extends StatelessWidget {
  const _FooterDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text('|',
          style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
    );
  }
}

// ── Reusable section card ─────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}