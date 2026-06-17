import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/colors.dart'; // Verified mapping to your shared color utility

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  // Clean utility function to launch external URLs safely
  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open link: $urlString')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 23),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Hero banner ─────────────────────────────────────────
              const _HeroAboutBanner(),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Mission Statement ──────────────────────────────
                    const Text(
                      'Find Jobs Faster with AI — All Company Career Pages in One Place',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'AimJobs.ai is a smart job discovery platform that helps job seekers find opportunities faster by bringing jobs from multiple company career pages into one place. We eliminate the need to visit different websites — giving you a single platform to search, match, and apply with ease.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                    const SizedBox(height: 16),

                    // ── Who We Are & What We Do ────────────────────────
                    _buildSectionHeader('Who We Are', Icons.groups_rounded),
                    const SizedBox(height: 8),
                    const Text(
                      'We are a team of technologists passionate about simplifying the job search experience. By aggregating opportunities directly from company career pages and pairing them with AI-powered resume parsing, we make it faster and easier for candidates to land their next role.',
                      style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                    ),

                    const SizedBox(height: 24),
                    _buildSectionHeader('What We Do', Icons.assignment_turned_in_rounded),
                    const SizedBox(height: 12),
                    _buildBulletPoint('Collect jobs directly from verified company career pages.'),
                    _buildBulletPoint('Provide a powerful search experience by skills, title, and location.'),
                    _buildBulletPoint('Parse your uploaded resume to auto-create your profile instantly.'),
                    _buildBulletPoint('Enable quick and easy job applications in one place.'),

                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                    const SizedBox(height: 16),

                    // ── Key Features Grid / Column ─────────────────────
                    _buildSectionHeader('Key Features', Icons.star_rounded),
                    const SizedBox(height: 12),

                    _FeatureItemTile(
                      icon: Icons.psychology_rounded, // Best fit for Resume Parsing / AI
                      label: 'Resume Parsing',
                      description: 'Upload your CV and instantly build your profile — no manual form filling.',
                    ),
                    const SizedBox(height: 12),
                    _FeatureItemTile(
                      icon: Icons.manage_search_rounded,
                      label: 'Smart Job Search',
                      description: 'Search by skills, title, and location with intelligent filters.',
                    ),
                    const SizedBox(height: 12),
                    _FeatureItemTile(
                      icon: Icons.pie_chart_outline_rounded,
                      label: 'Jobs in One Place',
                      description: 'Access opportunities from dozens of company career pages in seconds.',
                    ),
                    const SizedBox(height: 12),
                    _FeatureItemTile(
                      icon: Icons.bolt_rounded,
                      label: 'Easy Apply',
                      description: 'Apply quickly, often redirecting you straight to the company\'s career page.',
                    ),

                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                    const SizedBox(height: 16),

                    // ── Why Choose Us ──────────────────────────────────
                    _buildSectionHeader('Why Choose AimJobs.ai', Icons.verified_rounded),
                    const SizedBox(height: 12),

                    // Displaying the unique highlights
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildBadge('No manual profile filling'),
                        _buildBadge('Saves time & effort'),
                        _buildBadge('Clean, distraction-free UI'),
                        _buildBadge('Direct company access'),
                        _buildBadge('AI skill matching'),
                        _buildBadge('100% Free'),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Text(
                      'Start Your Job Search Today',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Upload your resume and discover jobs instantly. AimJobs.ai is built for job seekers across India looking for the latest opportunities from top companies — all matched to your skills and experience in one place.',
                      style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                    ),

                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                    const SizedBox(height: 16),

                    // ── Social Connect Footer ──────────────────────────
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'CONNECT WITH US',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textMuted,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _SocialButton(icon: Icons.language_rounded, onTap: () => _launchURL('https://aimjobs.ai/')),
                              const SizedBox(width: 14),
                              _SocialButton(icon: Icons.facebook_rounded, onTap: () => _launchURL('https://www.facebook.com/aimjobsai/')),
                              const SizedBox(width: 14),
                              _SocialButton(icon: Icons.camera_alt_rounded, onTap: () => _launchURL('https://www.instagram.com/aimjobs.ai/')),
                              const SizedBox(width: 14),
                              _SocialButton(icon: Icons.business_center_rounded, onTap: () => _launchURL('https://www.linkedin.com/company/aimjobs-ai/')),
                              const SizedBox(width: 14),
                              _SocialButton(icon: Icons.play_arrow_rounded, onTap: () => _launchURL('https://www.youtube.com/@aimjobsai')),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Text(
                          //   'AIMJOBS.AI',
                          //   style: GoogleFonts.poppins(
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w800,
                          //     color: const Color(0xFF1E88E5),
                          //   ),
                          // ),
                          // const SizedBox(height: 4),
                          // const Text(
                          //   '© 2026 Aimjobs.ai All Rights Reserved.',
                          //   style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Visual layout building blocks
  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.darkRed, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: AppColors.darkRed, fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB), // Elegant pale gold badge background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFE082), width: 0.8),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF92400E)),
      ),
    );
  }
}

// ── Hero Banner Block ─────────────────────────────────────────────────────────

class _HeroAboutBanner extends StatelessWidget {
  const _HeroAboutBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        gradient: AppColors.blueGradient, // Perfectly maps back to your color configuration
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Learn more about India\'s fast growing smart job discovery platform.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    height: 1.4,
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

// ── Feature Layout Item Tile ──────────────────────────────────────────────────

class _FeatureItemTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;

  const _FeatureItemTile({
    required this.icon,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkRed, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
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

// ── Social IconButton Utility ──────────────────────────────────────────────────

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 20),
      ),
    );
  }
}