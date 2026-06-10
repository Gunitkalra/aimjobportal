import 'dart:ui' show PathMetric;
import 'package:aimjobs/routes/app_routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/colors.dart';
import '../controller/getmyresume_Controller.dart';
import '../controller/uploadresume_Controller.dart';

class MyResumeScreen extends StatefulWidget {
  const MyResumeScreen({super.key});

  @override
  State<MyResumeScreen> createState() => _MyResumeScreenState();
}

class _MyResumeScreenState extends State<MyResumeScreen> {
  final _resumeController = Get.put(GetMyResumeController());
  final _uploadController = Get.put(UploadResumeController());


  String? _selectedFileName;
  String? _selectedFileSize;
  String? _selectedFilePath;
  bool _isUploading = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      if (file.size > 5 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File too large. Max size is 5MB.')),
        );
        return;
      }
      final bytes = file.size;
      final sizeStr = bytes < 1024 * 1024
          ? '${(bytes / 1024).toStringAsFixed(1)} KB'
          : '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      setState(() {
        _selectedFileName = file.name;
        _selectedFileSize = sizeStr;
        _selectedFilePath = file.path;
      });
    }
  }

  Future<void> _uploadAndParse() async {
    if (_selectedFileName == null || _selectedFilePath == null) return;
    setState(() => _isUploading = true);

    await _uploadController.uploadResume(_selectedFilePath!);

    if (mounted) {
      setState(() {
        _isUploading = false;
        _selectedFileName = null;
        _selectedFileSize = null;
        _selectedFilePath = null;
      });
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
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Image.asset(
              'assets/logo.png',
              height: 80,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 23,)
            // Text(
            //   'Dashboard',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w700,
            //     color: AppColors.textPrimary,
            //   ),
            // ),
          ],
        ),
        // const Text(
        //   'My Resume',
        //   style: TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.w700,
        //     color: AppColors.textPrimary,
        //   ),
        // ),
      ),
      body: Obx(() {
        if (_resumeController.isLoading.value && _resumeController.resumeData.value == null) {
          return const Center(child: CircularProgressIndicator(color: AppColors.darkRed));
        }

        final resumeData = _resumeController.resumeData.value?.data;
        final bool hasResume = resumeData != null;
        final String resumeName = resumeData?.fileName ?? '';
        final String uploadedOn = resumeData?.uploadedAt != null
            ? DateFormat('MMM dd, yyyy \'at\' hh:mm a').format(resumeData!.uploadedAt!.toLocal())
            : '';
        final bool parsingComplete = resumeData?.parsedAt != null;

        return SingleChildScrollView(
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
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero banner ─────────────────────────────────────────
                _HeroBanner(),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Current Resume ──────────────────────────────────────
                      if (hasResume) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/file-earmark-text.svg',
                        colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Current Resume',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Resume file card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/file-earmark-pdf-fill.svg',
                          colorFilter: const ColorFilter.mode(Color(0xFFE53935), BlendMode.srcIn),
                          width: 38,
                          height: 44,
                        ),
                      const SizedBox(height: 12),
                      Text(
                        resumeName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Uploaded on $uploadedOn',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Download button
                      GestureDetector(
                        onTap: () async {
                          final urlString = resumeData.downloadUrl;
                          if (urlString != null && urlString.isNotEmpty) {
                            final uri = Uri.parse(urlString);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Could not launch download link'))
                              );
                            }
                          }
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.lightRed, width: 0.5),
                          ),
                          child: const Icon(
                            Icons.download_rounded,
                            color: AppColors.lightRed,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Parsing status
                if (parsingComplete) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColors.appBg2.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD1FAE5)),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/check-circle-fill.svg',
                          colorFilter: const ColorFilter.mode(Color(0xFF2ECC71), BlendMode.srcIn),
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Parsing Complete',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Your profile has been updated with information\nextracted from your resume.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton.icon(
                          onPressed: () => Get.toNamed(AppRoutes.myprofile),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF046307),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                          icon: SvgPicture.asset(
                            'assets/person-circle.svg',
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            width: 16,
                            height: 16,
                          ),
                          label: const Text(
                            'View Profile',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ],

              // ── Upload New Resume ───────────────────────────────────
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/cloud-upload.svg',
                    colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Upload New Resume',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Warning notice
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFFFE082), width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFFF59E0B)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Uploading a new resume will replace your current one and trigger a new AI parsing.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF92400E),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Drop zone
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: _selectedFileName != null
                        ? Border.all(color: AppColors.darkRed, width: 1.5)
                        : null,
                  ),
                  child: _selectedFileName != null
                      ? _SelectedFilePreview(
                          name: _selectedFileName!,
                          size: _selectedFileSize ?? '',
                          onRemove: () => setState(() {
                            _selectedFileName = null;
                            _selectedFileSize = null;
                            _selectedFilePath = null;
                          }),
                        )
                      : CustomPaint(
                          painter: _DashedRectPainter(
                            color: const Color(0xFFCCCCCC),
                            strokeWidth: 1.5,
                            gap: 6.0,
                            radius: 12.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 28),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/cloud-upload.svg',
                                  colorFilter: const ColorFilter.mode(AppColors.darkRed, BlendMode.srcIn),
                                  width: 48,
                                  height: 48,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Drag & drop your resume here',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'or',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textMuted),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: _pickFile,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.darkRed,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(horizontal: 24),
                                    ),
                                    child: const Text(
                                      'Browse Files',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Supported formats: PDF, DOC, DOCX (Max 5MB)',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textMuted),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // Upload & Parse button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _selectedFileName != null ? _uploadAndParse : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkRed,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.darkRed.withOpacity(0.6),
                    disabledForegroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: _isUploading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white),
                        )
                      : SvgPicture.asset(
                          'assets/cloud-upload.svg',
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          width: 18,
                          height: 18,
                        ),
                  label: Text(
                    _isUploading ? 'Uploading...' : 'Upload & Parse Resume',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── AI-Powered Features ─────────────────────────────────
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/robot.svg',
                    colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'AI-Powered Features',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _AiFeatureTile(
                icon: 'assets/person-lines-fill.svg',
                label: 'Auto-Fill Profile',
                description: 'Automatically extract and fill your professional details',
              ),
              const SizedBox(height: 12),
              _AiFeatureTile(
                icon: 'assets/briefcase.svg',
                label: 'Work Experience',
                description: 'Parse your employment history and job titles',
              ),
              const SizedBox(height: 12),
              _AiFeatureTile(
                icon: 'assets/mortarboard.svg',
                label: 'Education',
                description: 'Extract your educational qualifications',
              ),
              const SizedBox(height: 12),
              _AiFeatureTile(
                icon: 'assets/lightning-charge-fill.svg',
                label: 'Skills Detection',
                description: 'Identify your technical and soft skills',
              ),

              const SizedBox(height: 30),

              // ── Footer ──────────────────────────────────────────────
              // Center(
              //   child: Column(
              //     children: [
              //       Text(
              //         'AIMJOBS.AI',
              //         style: GoogleFonts.poppins(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w800,
              //           color: const Color(0xFF1E88E5),
              //         ),
              //       ),
              //       const SizedBox(height: 6),
              //       const Text(
              //         '© 2026 Aimjobs.ai All Rights Reserved.',
              //         style: TextStyle(fontSize: 11, color: AppColors.textMuted),
              //       ),
              //       const SizedBox(height: 12),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           _FooterLink('About Us'),
              //           const _FooterDivider(),
              //           _FooterLink('Privacy Policy'),
              //           const _FooterDivider(),
              //           _FooterLink('Terms & Conditions'),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ── Hero Banner ───────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        gradient: AppColors.blueGradient,
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
            child: SvgPicture.asset(
              'assets/file-earmark-text.svg',
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Resume',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Upload and manage your CV for AI-powered profile completion',
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

// ── Selected File Preview ─────────────────────────────────────────────────────

class _SelectedFilePreview extends StatelessWidget {
  final String name;
  final String size;
  final VoidCallback onRemove;
  const _SelectedFilePreview(
      {required this.name, required this.size, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.darkRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.description_outlined,
                color: AppColors.darkRed, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(size,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFDDDDDD)),
              ),
              child: const Icon(Icons.close_rounded,
                  size: 15, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

// ── AI Feature Tile ───────────────────────────────────────────────────────────

class _AiFeatureTile extends StatelessWidget {
  final dynamic icon;
  final String label;
  final String description;
  const _AiFeatureTile({
    required this.icon,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;
    if (icon is String) {
      iconWidget = SvgPicture.asset(
        icon as String,
        width: 28,
        height: 28,
        colorFilter: const ColorFilter.mode(AppColors.darkRed, BlendMode.srcIn),
      );
    } else if (icon is IconData) {
      iconWidget = Icon(
        icon as IconData,
        color: AppColors.darkRed,
        size: 28,
      );
    } else {
      iconWidget = const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Dashed Rect Painter ───────────────────────────────────────────────────────

class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;

  _DashedRectPainter({
    this.color = const Color(0xFFCCCCCC),
    this.strokeWidth = 1.5,
    this.gap = 6.0,
    this.radius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    final dashPath = _buildDashPath(path, gap);
    canvas.drawPath(dashPath, paint);
  }

  Path _buildDashPath(Path source, double gap) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double len = gap;
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _FooterLink extends StatelessWidget {
  final String text;
  const _FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text.contains('Privacy')) {
          launchUrl(Uri.parse('https://www.aimjobs.ai/Home/Privacy'));
        } else if (text.contains('Terms')) {
          launchUrl(Uri.parse('https://www.aimjobs.ai/Home/Terms'));
        }
      },
      child: Text(
        text,
        style:
        const TextStyle(fontSize: 12, color: AppColors.textSecondary),
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