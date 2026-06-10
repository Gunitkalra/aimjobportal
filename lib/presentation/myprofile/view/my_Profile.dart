import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../../Utils/colors.dart';
import '../controller/getProfile_Controller.dart';
import '../controller/updatepersonalinfo_controller.dart';
import '../controller/updatejobdetail_controller.dart';
import '../controller/updateprofilesummary_controller.dart';
import '../controller/updateskills_language_controller.dart';
import '../controller/updateworkexperience_controller.dart';
import '../controller/updateeducation_controller.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  // ── Personal Info ──────────────────────────────────────────────
  final _nameCtrl       = TextEditingController(text: 'N/A');
  final _mobileCtrl     = TextEditingController(text: 'N/A');
  final _genderCtrl     = TextEditingController(text: 'N/A');
  final _dobCtrl        = TextEditingController(text: 'N/A');
  final _emailCtrl      = TextEditingController(text: 'N/A');

  // ── Job Details ────────────────────────────────────────────────
  final _designationCtrl  = TextEditingController(text: 'N/A');
  final _ctcCtrl          = TextEditingController(text: 'N/A');
  final _expCtrl          = TextEditingController(text: 'N/A');
  final _locationCtrl     = TextEditingController(text: 'N/A');
  final _noticePeriodCtrl = TextEditingController(text: 'N/A');
  final _industryCtrl     = TextEditingController(text: 'N/A');
  final _departmentCtrl   = TextEditingController(text: 'N/A');
  final _jobTypeCtrl      = TextEditingController(text: 'N/A');
  final _prefredlocationCtrl      = TextEditingController(text: 'N/A');

  // ── Profile Summary ────────────────────────────────────────────
  final _summaryCtrl = TextEditingController(
    text: 'N/A' );

  // ── Skills ─────────────────────────────────────────────────────
  final _skillsCtrl    = TextEditingController(text: 'N/A');
  final _languagesCtrl = TextEditingController(text: 'N/A');

  // ── Work Experience list ───────────────────────────────────────
  late List<WorkExpEntry> _workEntries;
  late List<WorkExpEntry> _workSnapshots;

  // ── Education list ─────────────────────────────────────────────
  late List<EduEntry> _eduEntries;
  late List<EduEntry> _eduSnapshots;

  // ── Edit states ────────────────────────────────────────────────
  bool _editPersonal = false;
  bool _editJob      = false;
  bool _editSummary  = false;
  bool _editSkills   = false;
  bool _editWork     = false;
  bool _editEdu      = false;

  late Map<TextEditingController, String> _snapshots;
  late final GetProfileController _profileController;
  late final UpdatePersonalInformationController _updatePersonalInfoController;
  late final UpdateJobDetailController _updateJobDetailController;
  late final UpdateProfileSummaryController _updateProfileSummaryController;
  late final UpdateSkillsLanguageController _updateSkillsLanguageController;
  late final UpdateWorkExperienceController _updateWorkExperienceController;
  late final UpdateEducationController _updateEducationController;

  @override
  void initState() {
    super.initState();
    
    _profileController = Get.put(GetProfileController());
    _updatePersonalInfoController = Get.put(UpdatePersonalInformationController());
    _updateJobDetailController = Get.put(UpdateJobDetailController());
    _updateProfileSummaryController = Get.put(UpdateProfileSummaryController());
    _updateSkillsLanguageController = Get.put(UpdateSkillsLanguageController());
    _updateWorkExperienceController = Get.put(UpdateWorkExperienceController());
    _updateEducationController = Get.put(UpdateEducationController());
    
    _workEntries = [];
    _eduEntries = [];
    
    ever(_profileController.profileData, (profile) {
      if (profile?.data != null) {
        final data = profile!.data!;
        
        _nameCtrl.text = data.personalInfo?.fullName ?? '';
        _mobileCtrl.text = data.personalInfo?.mobileNumber ?? '';
        _genderCtrl.text = (data.personalInfo?.gender == null || data.personalInfo!.gender!.toLowerCase() == 'not specified') ? '' : data.personalInfo!.gender!;
        _dobCtrl.text = data.personalInfo?.dateOfBirth != null 
            ? DateFormat('d MMM yyyy').format(data.personalInfo!.dateOfBirth!) 
            : '';
        _emailCtrl.text = data.email ?? '';
        
        final designationVal = data.jobDetails?.currentDesignation;
        _designationCtrl.text = (designationVal == null || designationVal.toLowerCase() == 'not specified') ? '' : designationVal;

        final ctcVal = data.jobDetails?.ctc;
        _ctcCtrl.text = (ctcVal == null || ctcVal == 0) ? '' : ctcVal.toString();

        final expVal = data.jobDetails?.totalExperience;
        _expCtrl.text = (expVal == null || expVal == 0) ? '' : '$expVal Years';

        final locationVal = data.jobDetails?.currentLocation;
        _locationCtrl.text = (locationVal == null || locationVal.toLowerCase() == 'not specified') ? '' : locationVal;

        final noticeVal = data.jobDetails?.noticePeriod;
        _noticePeriodCtrl.text = (noticeVal == null || noticeVal == 0) ? '' : '$noticeVal Days';

        final industryVal = data.jobDetails?.industry;
        _industryCtrl.text = (industryVal == null || industryVal.toLowerCase() == 'not specified') ? '' : industryVal;

        final departmentVal = data.jobDetails?.department;
        _departmentCtrl.text = (departmentVal == null || departmentVal.toLowerCase() == 'not specified') ? '' : departmentVal;

        final jobTypesList = data.jobDetails?.jobTypes ?? [];
        _jobTypeCtrl.text = jobTypesList.isEmpty ? '' : jobTypesList.join(', ');

        final preferredLocList = data.jobDetails?.preferredLocations ?? [];
        _prefredlocationCtrl.text = preferredLocList.isEmpty ? '' : preferredLocList.join(', ');
        
        _summaryCtrl.text = data.profileSummary ?? '';
        
        final skillsList = data.skillsLanguages?.skills ?? [];
        _skillsCtrl.text = skillsList.isEmpty ? '' : skillsList.join(', ');

        final langsList = data.skillsLanguages?.languages ?? [];
        _languagesCtrl.text = langsList.isEmpty ? '' : langsList.join(', ');
        
        _workEntries = data.workExperience.map((w) {
            final start = w.startDate != null ? DateFormat('d MMM yyyy').format(w.startDate!) : "";
            final end = w.endDate != null ? DateFormat('d MMM yyyy').format(w.endDate!) : "";
            return WorkExpEntry(
              company: w.company ?? '',
              position: w.position ?? '',
              startDate: start,
              endDate: end,
              isCurrentJob: w.isCurrentJob ?? (w.endDate == null),
              description: w.description ?? '',
            );
        }).toList();

        _eduEntries = data.education.map((e) => EduEntry(
          degree: e.degree ?? '',
          institute: e.institutionName ?? '',
          level: e.level ?? '',
        )).toList();
        
        if (mounted) setState((){});
      }
    });
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl, _mobileCtrl, _genderCtrl, _dobCtrl, _emailCtrl,
      _designationCtrl, _ctcCtrl, _expCtrl, _locationCtrl,
      _noticePeriodCtrl, _industryCtrl, _departmentCtrl, _jobTypeCtrl, _prefredlocationCtrl,
      _summaryCtrl, _skillsCtrl, _languagesCtrl,
    ]) c.dispose();
    for (final e in _workEntries) e.dispose();
    for (final e in _eduEntries)  e.dispose();
    super.dispose();
  }

  // ── Generic field-based edit helpers ──────────────────────────
  void _startEdit(Function(bool) setter, List<TextEditingController> ctrls) {
    _snapshots = {for (var c in ctrls) c: c.text};
    setState(() => setter(true));
  }

  void _cancelEdit(Function(bool) setter, List<TextEditingController> ctrls) {
    for (var c in ctrls) c.text = _snapshots[c] ?? c.text;
    setState(() => setter(false));
  }

  void _saveEdit(Function(bool) setter) => setState(() => setter(false));

  // ── Work experience helpers ────────────────────────────────────
  void _startWorkEdit() {
    _workSnapshots = _workEntries.map((e) => e.clone()).toList();
    setState(() => _editWork = true);
  }

  void _cancelWorkEdit() {
    for (final e in _workEntries) e.dispose();
    _workEntries = _workSnapshots;
    setState(() => _editWork = false);
  }

  void _saveWorkEdit() => setState(() => _editWork = false);

  void _addWorkEntry() => setState(() => _workEntries.add(WorkExpEntry()));

  void _removeWorkEntry(int index) {
    _workEntries[index].dispose();
    setState(() => _workEntries.removeAt(index));
  }

  // ── Education helpers ──────────────────────────────────────────
  void _startEduEdit() {
    _eduSnapshots = _eduEntries.map((e) => e.clone()).toList();
    setState(() => _editEdu = true);
  }

  void _cancelEduEdit() {
    for (final e in _eduEntries) e.dispose();
    _eduEntries = _eduSnapshots;
    setState(() => _editEdu = false);
  }

  void _saveEduEdit() => setState(() => _editEdu = false);

  void _addEduEntry() => setState(() => _eduEntries.add(EduEntry()));

  void _removeEduEntry(int index) {
    _eduEntries[index].dispose();
    setState(() => _eduEntries.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
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
        //
        // const Text('My Profile',
        //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,
        //         color: AppColors.textPrimary)),
      ),
      body: Obx(() {
        if (_profileController.isLoading.value && _profileController.profileData.value == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.darkRed),
          );
        }
        return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: 16),
        child: Column(
          children: [
            _AvatarHeader(name: _nameCtrl.text),
            const SizedBox(height: 16),

            // Personal Information
            _ProfileCard(
              icon: 'assets/person-circle.svg',
              title: 'Personal Information',
              isEditing: _editPersonal,
              isLoading: _updatePersonalInfoController.isLoading,
              onEdit: () => _startEdit((v) => _editPersonal = v,
                  [_nameCtrl, _mobileCtrl, _genderCtrl, _dobCtrl, _emailCtrl]),
              onCancel: () => _cancelEdit((v) => _editPersonal = v,
                  [_nameCtrl, _mobileCtrl, _genderCtrl, _dobCtrl, _emailCtrl]),
              onSave: () async {
                DateTime? dateParsing;
                final rawDate = _dobCtrl.text.trim();
                
                if (rawDate.isNotEmpty && rawDate != 'Not specified') {
                  dateParsing = DateTime.tryParse(rawDate);
                  if (dateParsing == null) {
                      try {
                        dateParsing = DateFormat('d MMM yyyy').parseLoose(rawDate);
                      } catch (_) {}
                  }
                  // Fallback for DD-MM-YYYY or DD/MM/YYYY
                  if (dateParsing == null) {
                      String safeStr = rawDate.replaceAll('/', '-');
                      final parts = safeStr.split('-');
                      if (parts.length == 3 && parts[0].length <= 2 && parts[2].length == 4) {
                        dateParsing = DateTime.tryParse('${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}');
                      }
                  }
                }

                if (dateParsing != null) {
                  final today = DateTime.now();
                  int age = today.year - dateParsing.year;
                  if (today.month < dateParsing.month ||
                      (today.month == dateParsing.month && today.day < dateParsing.day)) {
                    age--;
                  }
                  if (age < 18 || age > 70) {
                    Get.snackbar(
                      "Error",
                      "Age must be between 18 and 70 years",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.top,
                    );
                    return;
                  }
                }
                
                final String? isoDate = dateParsing != null 
                    ? "${DateFormat('yyyy-MM-dd').format(dateParsing)}T00:00:00Z" 
                    : null;
                final bool success = await _updatePersonalInfoController.updatePersonalInfo(
                  fullName: _nameCtrl.text,
                  mobileNumber: _mobileCtrl.text,
                  gender: _genderCtrl.text,
                  dateOfBirth: isoDate,
                );
                if (success) {
                  _saveEdit((v) => _editPersonal = v);
                }
              },
              viewChild: _InfoGrid(rows: [
                _InfoRow('Full Name',      _nameCtrl.text),
                _InfoRow('Mobile Number',  _mobileCtrl.text,),
                _InfoRow('Gender',         _genderCtrl.text),
                _InfoRow('Date of Birth',  _dobCtrl.text),
                _InfoRow('Email Address',  _emailCtrl.text, isVerified: true),
              ]),
              editChild: _EditGrid(fields: [
                _EditField('Full Name *',      _nameCtrl, helpText: 'Letters and spaces only, 2-100 characters', hintText: 'Enter your full name'),
                _EditField('Mobile Number *',  _mobileCtrl, inputType: TextInputType.phone, helpText: '10-digit number starting with 6, 7, 8, or 9', hintText: 'Enter mobile number'),
                _EditField('Gender',         _genderCtrl, isDropdown: true, dropdownItems: ['Male', 'Female', 'Other']),
                _EditField('Date of Birth',  _dobCtrl, isDateField: true, helpText: 'You must be 18-70 years old', hintText: 'Select date of birth'),
                // _EditField('Email Address',  _emailCtrl, inputType: TextInputType.emailAddress, enabled: false),
              ]),
            ),
            const SizedBox(height: 12),

            // Job Details
            _ProfileCard(
              icon: 'assets/briefcase-fill.svg',
              title: 'Job Details',
              isEditing: _editJob,
              isLoading: _updateJobDetailController.isLoading,
              onEdit: () => _startEdit((v) => _editJob = v, [
                _designationCtrl, _ctcCtrl, _expCtrl, _locationCtrl,
                _noticePeriodCtrl, _industryCtrl, _departmentCtrl, _jobTypeCtrl, _prefredlocationCtrl,
              ]),
              onCancel: () => _cancelEdit((v) => _editJob = v, [
                _designationCtrl, _ctcCtrl, _expCtrl, _locationCtrl,
                _noticePeriodCtrl, _industryCtrl, _departmentCtrl, _jobTypeCtrl, _prefredlocationCtrl,
              ]),
              onSave: () async {
                final cleanCtc = _ctcCtrl.text.replaceAll(RegExp(r'[^0-9]'), '');
                final int ctcVal = int.tryParse(cleanCtc) ?? 0;
                
                final cleanExp = _expCtrl.text.replaceAll(RegExp(r'[^0-9]'), '');
                final int expVal = int.tryParse(cleanExp) ?? 0;
                
                final cleanNotice = _noticePeriodCtrl.text.replaceAll(RegExp(r'[^0-9]'), '');
                final int noticeVal = int.tryParse(cleanNotice) ?? 0;
                
                final jobTypesList = _jobTypeCtrl.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                
                final preferredLocList = _prefredlocationCtrl.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                
                await _updateJobDetailController.updateJobDetails(
                  currentDesignation: _designationCtrl.text,
                  ctc: ctcVal,
                  totalExperience: expVal,
                  noticePeriod: noticeVal,
                  preferredLocations: preferredLocList,
                  currentLocation: _locationCtrl.text,
                  industry: _industryCtrl.text,
                  department: _departmentCtrl.text,
                  jobTypes: jobTypesList,
                );
                _saveEdit((v) => _editJob = v);
              },
              viewChild: _InfoGrid(rows: [
                _InfoRow('Current Designation', _designationCtrl.text),
                _InfoRow('Current CTC',        _ctcCtrl.text),
                _InfoRow('Total Experience',   _expCtrl.text),
                _InfoRow('Notice Period',      _noticePeriodCtrl.text),
                _InfoRow('Current Location',   _locationCtrl.text),
                _InfoRow('Preferred Locations',_prefredlocationCtrl.text, isMuted: _prefredlocationCtrl.text == 'Not specified'),
                _InfoRow('Industry',           _industryCtrl.text),
                _InfoRow('Department',         _departmentCtrl.text),
                _InfoRow('Job Type',           _jobTypeCtrl.text),
              ]),
              editChild: _EditGrid(fields: [
                _EditField('Current Designation (Job Title)', _designationCtrl, helpText: '2-100 characters', hintText: 'e.g., Software Engineer'),
                _EditField('Current CTC (in Lakhs)',      _ctcCtrl, helpText: '0-999.99 lakhs', hintText: 'e.g., 15.5'),
                _EditField('Total Experience (in Years)', _expCtrl, helpText: '0-50 years', hintText: 'e.g., 5'),
                _EditField('Notice Period (in Days)',    _noticePeriodCtrl, helpText: '0-365 days', hintText: 'e.g., 30'),
                _EditField('Current Location', _locationCtrl, helpText: '2-100 characters', hintText: 'e.g., Delhi  India'),
                _EditField('Preferred Locations', _prefredlocationCtrl, helpText: 'Max 4 locations, 2-50 characters each', hintText: 'Type and press Enter', isChipInput: true),
                _EditField('Industry',         _industryCtrl, isDropdown: true, dropdownItems: ['Select Industry', 'Information Technology', 'Banking & Finance', 'Automotive', 'Manufacturing', 'Healthcare', 'Pharmaceuticals & Biotech', 'Retail & E-Commerce', 'Consulting', 'Telecommunications', 'Energy & Utilities', 'Education', 'Media & Entertainment', 'Government & Public Sector', 'Logistics & Supply Chain', 'Real Estate', 'Hospitality & Travel', 'Non-Profit', 'Legal', 'Agriculture', 'Other']),
                _EditField('Department',       _departmentCtrl, isDropdown: true, dropdownItems: ['Select Department', 'Engineering', 'Software Development', 'Information Technology', 'Data and Analytics', 'DevOps and Infrastructure', 'Security', 'Research and Development', 'Quality Assurance', 'IT Support', 'Design', 'Creative and Art Services', 'User Experience', 'Project and Program Management', 'Product Management', 'Operations', 'Logistics']),
                _EditField('Job Type',         _jobTypeCtrl, isCheckboxes: true, checkboxItems: ['Permanent', 'Full-Time', 'Part-Time', 'Contractor', 'Freelance', 'Intern']),
              ]),
            ),
            const SizedBox(height: 12),

            // Profile Summary
            _ProfileCard(
              icon: 'assets/card-text.svg',
              title: 'Profile Summary',
              isEditing: _editSummary,
              isLoading: _updateProfileSummaryController.isLoading,
              onEdit: () => _startEdit((v) => _editSummary = v, [_summaryCtrl]),
              onCancel: () => _cancelEdit((v) => _editSummary = v, [_summaryCtrl]),
              onSave: () async {
                await _updateProfileSummaryController.updateProfileSummary(
                  summary: _summaryCtrl.text,
                );
                _saveEdit((v) => _editSummary = v);
              },
              viewChild: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 120,
                    child: Text('Professional Summary',
                        style: TextStyle(fontSize: 13,
                            color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final String val = _summaryCtrl.text.trim();
                        final bool isEmpty = val.isEmpty || val.toLowerCase() == 'not specified';
                        return Text(
                          isEmpty ? 'Not specified' : _summaryCtrl.text,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.6,
                            fontStyle: isEmpty ? FontStyle.italic : FontStyle.normal,
                            color: isEmpty ? AppColors.textMuted : AppColors.black,
                            fontWeight: isEmpty ? FontWeight.w500 : FontWeight.w600,
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
              editChild: _EditGrid(fields: [
                _EditField('Professional Summary', _summaryCtrl, helpText: '10-2000 characters', maxLines: 6, hintText: 'Write a brief summary about your professional background...'),
              ]),
            ),
            const SizedBox(height: 12),

            // Skills & Languages
            _ProfileCard(
              icon: 'assets/lightbulb-fill.svg',
              title: 'Skills & Languages',
              isEditing: _editSkills,
              isLoading: _updateSkillsLanguageController.isLoading,
              onEdit: () => _startEdit(
                      (v) => _editSkills = v, [_skillsCtrl, _languagesCtrl]),
              onCancel: () => _cancelEdit(
                      (v) => _editSkills = v, [_skillsCtrl, _languagesCtrl]),
              onSave: () async {
                final rawSkills = _skillsCtrl.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                final rawLangs = _languagesCtrl.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                
                await _updateSkillsLanguageController.updateSkillsAndLanguages(
                  skills: rawSkills,
                  languages: rawLangs,
                );
                _saveEdit((v) => _editSkills = v);
              },
                viewChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text('Skills',
                            style: TextStyle(fontSize: 13,
                                color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            final List<String> skills = _skillsCtrl.text.split(',')
                                .map((s) => s.trim())
                                .where((s) => s.isNotEmpty && s.toLowerCase() != 'not specified')
                                .toList();
                            if (skills.isEmpty) {
                              return const Text(
                                'Not specified',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textMuted,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                            return Wrap(
                              spacing: 8, runSpacing: 8,
                              children: skills.map((s) => _SkillChip(label: s)).toList(),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text('Known Languages',
                            style: TextStyle(fontSize: 13,
                                color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(_languagesCtrl.text.isEmpty ? 'Not specified' : _languagesCtrl.text,
                            style: TextStyle(fontSize: 13,
                                color: (_languagesCtrl.text.isEmpty || _languagesCtrl.text == 'Not specified') ? AppColors.textMuted : AppColors.textPrimary,
                                fontStyle: (_languagesCtrl.text.isEmpty || _languagesCtrl.text == 'Not specified') ? FontStyle.italic : FontStyle.normal,
                                fontWeight: (_languagesCtrl.text.isEmpty || _languagesCtrl.text == 'Not specified') ? FontWeight.w500 : FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
              editChild: _EditGrid(fields: [
                _EditField('Skills', _skillsCtrl, hintText: 'e.g. Flutter, Dart, Firebase', helpText: 'Max 10 skills, separate with commas (each 2-50 characters)'),
                _EditField('Known Languages', _languagesCtrl, hintText: 'e.g., English, Hindi, Tamil', helpText: 'Max 10 languages, separate with commas (each 2-30 characters)'),
              ]),
            ),
            const SizedBox(height: 12),

            // ── Work Experience ──────────────────────────────────────
            _MultiEntryCard(
              icon: 'assets/building.svg',
              title: 'Work Experience',
              isEditing: _editWork,
              isLoading: _updateWorkExperienceController.isLoading,
              onEdit: _startWorkEdit,
              onCancel: _cancelWorkEdit,
              onSave: () async {
                 final List<Map<String,dynamic>> experiences = [];
                 for(final e in _workEntries) {
                    DateTime? startDate;
                    DateTime? endDate;
                    
                    try {
                        startDate = DateFormat('d MMM yyyy').parseLoose(e.startDateCtrl.text);
                    } catch (_) {
                        try { startDate = DateFormat('MMM yyyy').parseLoose(e.startDateCtrl.text); } catch (_) {}
                    }
                    
                    if (!e.isCurrentJob.value && e.endDateCtrl.text.isNotEmpty) {
                        try {
                            endDate = DateFormat('d MMM yyyy').parseLoose(e.endDateCtrl.text);
                        } catch (_) {
                            try { endDate = DateFormat('MMM yyyy').parseLoose(e.endDateCtrl.text); } catch (_) {}
                        }
                    }

                    experiences.add({
                        "company": e.companyCtrl.text,
                        "position": e.positionCtrl.text,
                        "startDate": startDate != null ? "${DateFormat('yyyy-MM-dd').format(startDate)}T00:00:00Z" : null,
                        "endDate": endDate != null ? "${DateFormat('yyyy-MM-dd').format(endDate)}T00:00:00Z" : null,
                        "description": e.descCtrl.text,
                        "isCurrentJob": e.isCurrentJob.value,
                    });
                 }
                 
                 print("Submitting Payload: $experiences");
                 await _updateWorkExperienceController.updateWorkExperience(workExperiences: experiences);
                 _saveWorkEdit();
              },
              onAdd: _addWorkEntry,
              addLabel: 'Add Work Experience',
              viewChild: _workEntries.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'No work experience added yet',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF94A3B8),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: _workEntries.asMap().entries.map((e) {
                        final entry = e.value;
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: e.key < _workEntries.length - 1 ? 10 : 0),
                          child: _WorkExpViewCard(
                            company:     entry.companyCtrl.text,
                            position:    entry.positionCtrl.text,
                            duration:    entry.isCurrentJob.value 
                                ? "${entry.startDateCtrl.text} - Present" 
                                : "${entry.startDateCtrl.text} - ${entry.endDateCtrl.text}",
                            description: entry.descCtrl.text,
                          ),
                        );
                      }).toList(),
                    ),
              editChild: Column(
                children: [
                  ..._workEntries.asMap().entries.map((e) {
                    final i     = e.key;
                    final entry = e.value;
                    return _WorkExpEditCard(
                      entry: entry,
                      index: i,
                      total: _workEntries.length,
                      onRemove: () => _removeWorkEntry(i),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Education ────────────────────────────────────────────
            _MultiEntryCard(
              icon: 'assets/mortarboard-fill.svg',
              title: 'Education',
              isEditing: _editEdu,
              isLoading: _updateEducationController.isLoading,
              onEdit: _startEduEdit,
              onCancel: _cancelEduEdit,
              onSave: () async {
                 final List<Map<String,dynamic>> educations = [];
                 for(final e in _eduEntries) {
                    educations.add({
                        "level": e.levelCtrl.text,
                        "institutionName": e.instCtrl.text,
                        "degree": e.degreeCtrl.text,
                    });
                 }
                 await _updateEducationController.updateEducation(educationList: educations);
                 _saveEduEdit();
              },
              onAdd: _addEduEntry,
              addLabel: 'Add Education',
              viewChild: _eduEntries.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'No education details added yet',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF94A3B8),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _eduEntries.asMap().entries.map((e) {
                        final entry = e.value;
                        final isLast = e.key == _eduEntries.length - 1;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _InfoGrid(rows: [
                              _InfoRow('Education', entry.levelCtrl.text),
                              _InfoRow('Degree', entry.degreeCtrl.text),
                              _InfoRow('University/Board', entry.instCtrl.text),
                            ]),
                            if (!isLast) ...[
                              const SizedBox(height: 12),
                              const Divider(height: 1, color: Color(0xFFEEEEEE)),
                              const SizedBox(height: 16),
                            ],
                          ],
                        );
                      }).toList(),
                    ),
              editChild: Column(
                children: _eduEntries.asMap().entries.map((e) {
                  final i     = e.key;
                  final entry = e.value;
                  return _EduEditCard(
                    entry: entry,
                    index: i,
                    total: _eduEntries.length,
                    onRemove: () => _removeEduEntry(i),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Footer
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     _FooterLink('About Us'),
            //     const _FooterDivider(),
            //     _FooterLink('Privacy Policy'),
            //     const _FooterDivider(),
            //     _FooterLink('Terms & Conditions'),
            //   ],
            // ),
            // const SizedBox(height: 6),
            // const Text('© 2026 Aim Job Techno. All Rights Reserved.',
            //     style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
            const SizedBox(height: 16),
          ],
        ),
      );
      }),
    );
  }

  Widget _buildTextField(TextEditingController ctrl,
      {required String label, int maxLines = 1,
        TextInputType inputType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                color: AppColors.textSecondary)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          keyboardType: inputType,
          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
          decoration: _inputDeco(),
        ),
      ],
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class WorkExpEntry {
  final TextEditingController companyCtrl;
  final TextEditingController positionCtrl;
  final TextEditingController startDateCtrl;
  final TextEditingController endDateCtrl;
  final RxBool isCurrentJob;
  final TextEditingController descCtrl;

  WorkExpEntry({
    String company = '', String position = '',
    String startDate = '', String endDate = '',
    bool isCurrentJob = false,
    String description = '',
  })  : companyCtrl  = TextEditingController(text: company),
        positionCtrl = TextEditingController(text: position),
        startDateCtrl = TextEditingController(text: startDate),
        endDateCtrl  = TextEditingController(text: endDate),
        isCurrentJob = RxBool(isCurrentJob),
        descCtrl     = TextEditingController(text: description);

  WorkExpEntry clone() => WorkExpEntry(
    company:     companyCtrl.text,
    position:    positionCtrl.text,
    startDate:   startDateCtrl.text,
    endDate:     endDateCtrl.text,
    isCurrentJob: isCurrentJob.value,
    description: descCtrl.text,
  );

  void dispose() {
    companyCtrl.dispose();
    positionCtrl.dispose();
    startDateCtrl.dispose();
    endDateCtrl.dispose();
    descCtrl.dispose();
  }
}

class EduEntry {
  final TextEditingController degreeCtrl;
  final TextEditingController instCtrl;
  final TextEditingController levelCtrl;

  EduEntry({String degree = '', String institute = '', String level = ''})
      : degreeCtrl = TextEditingController(text: degree),
        instCtrl   = TextEditingController(text: institute),
        levelCtrl  = TextEditingController(text: level);

  EduEntry clone() => EduEntry(
    degree:    degreeCtrl.text,
    institute: instCtrl.text,
    level:     levelCtrl.text,
  );

  void dispose() {
    degreeCtrl.dispose();
    instCtrl.dispose();
    levelCtrl.dispose();
  }
}

// ── Shared input decoration ───────────────────────────────────────────────────

InputDecoration _inputDeco({String? hint}) => InputDecoration(
  hintText: hint,
  hintStyle: const TextStyle(fontSize: 13, color: AppColors.textHint),
  filled: true,
  fillColor: const Color(0xFFF7F8FA),
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.darkRed, width: 1.5)),
);

// ── Multi-entry card (Work / Education) ───────────────────────────────────────

class _MultiEntryCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final VoidCallback onAdd;
  final String addLabel;
  final Widget viewChild;
  final Widget editChild;
  final RxBool? isLoading;

  const _MultiEntryCard({
    required this.icon, required this.title,
    required this.isEditing,
    this.isLoading,
    required this.onEdit, required this.onCancel, required this.onSave,
    required this.onAdd, required this.addLabel,
    required this.viewChild, required this.editChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: AppColors.darkRed),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            icon,
                            colorFilter: const ColorFilter.mode(AppColors.darkRed, BlendMode.srcIn),
                            width: 18,
                            height: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(title,
                              style: const TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary)),
                        ),
                        if (!isEditing)
                          GestureDetector(
                            onTap: onEdit,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/pencil.svg',
                                  width: 14,
                                  height: 14,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.darkRed,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text('Edit',
                                    style: TextStyle(fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textHint)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 280),
            crossFadeState: isEditing
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Padding(
                padding: const EdgeInsets.all(16), child: viewChild),
            secondChild: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  editChild,

                  const SizedBox(height: 12),

                  // ── Add button ───────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: onAdd,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.darkRed,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.add_circle_outline_rounded,
                                size: 18, color: AppColors.darkRed),
                            const SizedBox(width: 8),
                            Text(addLabel,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkRed)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Cancel / Save ────────────────────────────────
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.darkRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: isLoading != null 
                        ? Obx(() => isLoading!.value 
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                                SizedBox(width: 8),
                                Text('Save', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                              ],
                            ))
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Save', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                            ],
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: ElevatedButton(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel_outlined, color: AppColors.textSecondary, size: 18),
                          SizedBox(width: 8),
                          Text('Cancel', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                ],
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

// ── Work Experience – view card ───────────────────────────────────────────────

class _WorkExpViewCard extends StatelessWidget {
  final String company, position, duration, description;
  const _WorkExpViewCard({
    required this.company, required this.position,
    required this.duration, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: _InfoGrid(rows: [
        _InfoRow('Company', company.isEmpty ? 'Not specified' : company, isMuted: company.isEmpty),
        _InfoRow('Position', position.isEmpty ? 'Not specified' : position, isMuted: position.isEmpty),
        _InfoRow('Duration', duration.trim() == '-' ? 'Not specified' : duration, isMuted: duration.trim() == '-'),
        _InfoRow('Description', description.isEmpty ? 'Not specified' : description, isMuted: description.isEmpty),
      ]),
    );
  }
}

// ── Work Experience – edit card ───────────────────────────────────────────────

class _WorkExpEditCard extends StatelessWidget {
  final WorkExpEntry entry;
  final int index;
  final int total;
  final VoidCallback onRemove;

  const _WorkExpEditCard({
    required this.entry, required this.index,
    required this.total, required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Entry header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Text('Experience ${index + 1}',
                    style: const TextStyle(fontSize: 14,
                        fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const Spacer(),
                if (total > 1)
                  GestureDetector(
                    onTap: onRemove,
                    child: const Icon(Icons.delete_outline_rounded,
                          size: 20, color: Colors.red),
                  ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _labeledField(context, 'Company Name *', entry.companyCtrl,  hint: 'e.g. Assa Technology'),
                const SizedBox(height: 12),
                _labeledField(context, 'Position *',    entry.positionCtrl, hint: 'e.g. Junior Flutter Developer'),
                const SizedBox(height: 12),
                _labeledField(context, 'Start Date *',  entry.startDateCtrl, hint: 'e.g. 1 Jan 2024', isDate: true),
                const SizedBox(height: 12),
                Obx(() => _labeledField(context, 'End Date',      entry.endDateCtrl, hint: 'e.g. 1 Mar 2024', isDate: true, enabled: !entry.isCurrentJob.value)),
                const SizedBox(height: 12),
                Obx(() => Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: entry.isCurrentJob.value,
                        onChanged: (val) {
                          entry.isCurrentJob.value = val ?? false;
                          if (val == true) {
                            entry.endDateCtrl.clear();
                          }
                        },
                        activeColor: AppColors.darkRed,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        side: const BorderSide(color: Color(0xFFBDBDBD)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('Currently working here',
                        style: TextStyle(fontSize: 13, color: AppColors.textPrimary)),
                  ],
                )),
                const SizedBox(height: 12),
                const Text('Description',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                const SizedBox(height: 5),
                TextFormField(
                  controller: entry.descCtrl,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                  decoration: _inputDeco(hint: 'Describe your role...'),
                ),
                const SizedBox(height: 4),
                const Text('Max 500 characters',
                    style: TextStyle(fontSize: 11, color: AppColors.textHint)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _labeledField(BuildContext context, String label, TextEditingController ctrl,
      {String? hint, bool isDate = false, bool enabled = true}) {
    final bool hasAsterisk = label.endsWith('*');
    final String cleanLabel = hasAsterisk ? label.substring(0, label.length - 1).trim() : label;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: cleanLabel,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
            children: [
              if (hasAsterisk)
                const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        const SizedBox(height: 5),
        if (isDate)
          TextFormField(
            controller: ctrl,
            enabled: enabled,
            readOnly: true,
            onTap: enabled ? () async {
              DateTime? initialDate;
              try {
                if (ctrl.text.isNotEmpty) {
                  initialDate = DateFormat('d MMM yyyy').parseLoose(ctrl.text);
                }
              } catch (_) {}
              
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: initialDate ?? DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                ctrl.text = DateFormat('d MMM yyyy').format(picked);
              }
            } : null,
            style: TextStyle(fontSize: 13, color: enabled ? AppColors.textPrimary : AppColors.textMuted),
            decoration: _inputDeco(hint: hint),
          )
        else
          TextFormField(
            controller: ctrl,
            enabled: enabled,
            style: TextStyle(fontSize: 13, color: enabled ? AppColors.textPrimary : AppColors.textMuted),
            decoration: _inputDeco(hint: hint),
          ),
      ],
    );
  }
}


// ── Education – edit card ─────────────────────────────────────────────────────

class _EduEditCard extends StatelessWidget {
  final EduEntry entry;
  final int index;
  final int total;
  final VoidCallback onRemove;

  const _EduEditCard({
    required this.entry,
    required this.index,
    required this.total,
    required this.onRemove,
  });

  void _showEducationLevelPicker(BuildContext context, TextEditingController ctrl, List<String> levels) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: levels.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isSelected = ctrl.text == item || (ctrl.text.isEmpty && item == 'Select Level');
                  final isLast = index == levels.length - 1;

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        ctrl.text = item;
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: isLast ? null : const Border(
                            bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? AppColors.darkRed : const Color(0xFF475569),
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.darkRed,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> educationLevels = [
      'Select Level',
      '10th',
      '12th',
      'Graduation',
      'Master',
      'PhD',
    ];

    if (entry.levelCtrl.text.isEmpty) {
      entry.levelCtrl.text = 'Select Level';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Education ${index + 1}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (total > 1)
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),
          _labeledField(
            context,
            'Education Level *',
            entry.levelCtrl,
            isDropdown: true,
            dropdownItems: educationLevels,
          ),
          const SizedBox(height: 12),
          _labeledField(
            context,
            'University/College *',
            entry.instCtrl,
            hint: 'e.g. State Board, IIT Delhi',
          ),
          const SizedBox(height: 12),
          _labeledField(
            context,
            'Degree *',
            entry.degreeCtrl,
            hint: 'e.g. B.Tech, MBA',
          ),
        ],
      ),
    );
  }

  Widget _labeledField(
    BuildContext context,
    String label,
    TextEditingController ctrl, {
    String? hint,
    bool isDropdown = false,
    List<String>? dropdownItems,
  }) {
    final bool hasAsterisk = label.endsWith('*');
    final String cleanLabel = hasAsterisk ? label.substring(0, label.length - 1).trim() : label;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: cleanLabel,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
            children: [
              if (hasAsterisk)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        if (isDropdown && dropdownItems != null)
          TextFormField(
            controller: ctrl,
            readOnly: true,
            onTap: () => _showEducationLevelPicker(context, ctrl, dropdownItems),
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            decoration: _inputDeco(hint: hint).copyWith(
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.textSecondary,
              ),
            ),
          )
        else
          TextFormField(
            controller: ctrl,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            decoration: _inputDeco(hint: hint),
          ),
      ],
    );
  }
}

// ── Standard profile card (for non-list sections) ─────────────────────────────

class _ProfileCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool isEditing;
  final VoidCallback onEdit, onCancel, onSave;
  final Widget viewChild, editChild;
  final RxBool? isLoading;

  const _ProfileCard({
    required this.icon, required this.title,
    required this.isEditing,
    required this.onEdit, required this.onCancel, required this.onSave,
    required this.viewChild, required this.editChild,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: AppColors.darkRed),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Center(
                            child: SvgPicture.asset(
                              icon,
                              colorFilter: const ColorFilter.mode(AppColors.darkRed, BlendMode.srcIn),
                              width: 18,
                              height: 18,
                            ),
                          ),

                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(title,
                              style: const TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary)),
                        ),
                        if (!isEditing)
                          GestureDetector(
                            onTap: onEdit,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/pencil.svg',
                                  width: 14,
                                  height: 14,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.darkRed,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text('Edit',
                                    style: TextStyle(fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textHint)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 280),
            crossFadeState: isEditing
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Padding(
                padding: const EdgeInsets.all(16), child: viewChild),
            secondChild: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  editChild,
                  const SizedBox(height: 20),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.darkRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: isLoading != null 
                        ? Obx(() => isLoading!.value 
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                                SizedBox(width: 8),
                                Text('Save', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                              ],
                            ))
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Save', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                            ],
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: ElevatedButton(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel_outlined, color: AppColors.textSecondary, size: 18),
                          SizedBox(width: 8),
                          Text('Cancel', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                ],
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

// ── Info display helpers ──────────────────────────────────────────────────────

class _InfoRow {
  final String label, value;
  final bool isVerified;
  final bool isLink;
  final bool isMuted;
  _InfoRow(this.label, String val, {this.isVerified = false, this.isLink = false, bool? isMuted})
      : value = (val.trim().isEmpty || val.trim().toLowerCase() == 'not specified' || val.trim() == '0 Years' || val.trim() == '0 Days') ? 'Not specified' : val,
        isMuted = isMuted ?? (val.trim().isEmpty || val.trim().toLowerCase() == 'not specified' || val.trim() == '0 Years' || val.trim() == '0 Days');
}

class _InfoGrid extends StatelessWidget {
  final List<_InfoRow> rows;
  const _InfoGrid({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: rows.map((r) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(r.label,
                  style: const TextStyle(fontSize: 13,
                      color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
            ),
            const Text(' :   ', style: TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.value,
                      style: TextStyle(fontSize: 13,
                          fontStyle: r.isMuted ? FontStyle.italic : FontStyle.normal,
                          color: r.isMuted ? AppColors.textMuted : (r.isLink ? AppColors.darkRed : AppColors.black),
                          decoration: r.isLink ? TextDecoration.underline : null,
                          fontWeight: r.isMuted ? FontWeight.w500 : FontWeight.w500)),
                  if (r.isVerified) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.darkRed.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Verified',
                          style: TextStyle(fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkRed)),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

class _EditField {
  final String label;
  final TextEditingController ctrl;
  final TextInputType inputType;
  final bool enabled;
  final bool isDateField;
  final bool isChipInput;
  final String? helpText;
  final String? hintText;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final bool isCheckboxes;
  final List<String>? checkboxItems;
  final Widget? suffixIcon;
  final int maxLines;
  _EditField(this.label, this.ctrl, {this.inputType = TextInputType.text, this.enabled = true, this.isDateField = false, this.isChipInput = false, this.helpText, this.hintText, this.isDropdown = false, this.dropdownItems, this.isCheckboxes = false, this.checkboxItems, this.suffixIcon, this.maxLines = 1});
}

class _EditGrid extends StatelessWidget {
  final List<_EditField> fields;
  const _EditGrid({required this.fields});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fields.map((f) {
        final bool hasAsterisk = f.label.endsWith('*');
        final String cleanLabel = hasAsterisk ? f.label.substring(0, f.label.length - 1).trim() : f.label;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: cleanLabel,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                  children: [
                    if (hasAsterisk)
                      const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              if (f.isDropdown)
                DropdownButtonFormField<String>(
                  value: f.dropdownItems?.contains(f.ctrl.text) == true ? f.ctrl.text : (f.dropdownItems?.isNotEmpty == true ? f.dropdownItems!.first : null),
                  items: f.dropdownItems?.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)))).toList(),
                  onChanged: f.enabled ? (val) {
                    if (val != null) f.ctrl.text = val;
                  } : null,
                  decoration: _inputDeco(),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                )
              else if (f.isCheckboxes && f.checkboxItems != null)
                Column(
                  children: f.checkboxItems!.map((item) {
                    return StatefulBuilder(builder: (context, setState) {
                      final currentItems = f.ctrl.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                      final isChecked = currentItems.contains(item);
                      return Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (val) {
                              if (val == true) {
                                currentItems.add(item);
                              } else {
                                currentItems.remove(item);
                              }
                              f.ctrl.text = currentItems.join(', ');
                              setState(() {});
                            },
                            activeColor: AppColors.darkRed,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            side: const BorderSide(color: Color(0xFFBDBDBD)),
                          ),
                          Text(item, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
                        ],
                      );
                    });
                  }).toList(),
                )
              else if (f.isDateField)
                TextFormField(
                  controller: f.ctrl,
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      f.ctrl.text = DateFormat('d MMM yyyy').format(picked);
                    }
                  },
                  style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                  decoration: _inputDeco(hint: 'Select Date'),
                )
              else if (f.isChipInput)
                _ChipInputField(ctrl: f.ctrl, hintText: f.hintText ?? 'Type and press Enter')
              else
                TextFormField(
                  controller: f.ctrl,
                  keyboardType: f.inputType,
                  enabled: f.enabled,
                  maxLines: f.maxLines,
                  style: TextStyle(
                      fontSize: 13, color: f.enabled ? AppColors.textPrimary : AppColors.textMuted),
                  decoration: _inputDeco(hint: f.hintText).copyWith(
                    suffixIcon: f.suffixIcon,
                  ),
                ),
              if (f.helpText != null) ...[
                const SizedBox(height: 4),
                Text(f.helpText!, style: const TextStyle(fontSize: 11, color: AppColors.textHint)),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ChipInputField extends StatefulWidget {
  final TextEditingController ctrl;
  final String hintText;
  const _ChipInputField({required this.ctrl, required this.hintText});

  @override
  State<_ChipInputField> createState() => _ChipInputFieldState();
}

class _ChipInputFieldState extends State<_ChipInputField> {
  final TextEditingController _textCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isFocused = _focusNode.hasFocus;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  List<String> get _items {
    return widget.ctrl.text.split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && e.toLowerCase() != 'not specified')
        .toList();
  }

  void _addItem(String value) {
    final clean = value.trim();
    if (clean.isEmpty) return;
    final current = _items;
    if (current.length >= 4) {
      Get.snackbar(
        'Limit Exceeded',
        'Maximum 4 preferred locations allowed.',
        snackPosition: SnackPosition.top,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }
    if (clean.length < 2 || clean.length > 50) {
      Get.snackbar(
        'Invalid Input',
        'Location must be between 2 and 50 characters.',
        snackPosition: SnackPosition.top,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }
    if (!current.contains(clean)) {
      current.add(clean);
      widget.ctrl.text = current.join(', ');
      setState(() {});
    }
    _textCtrl.clear();
  }

  void _removeItem(String item) {
    final current = _items;
    current.remove(item);
    widget.ctrl.text = current.isEmpty ? '' : current.join(', ');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentItems = _items;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _isFocused ? AppColors.darkRed : const Color(0xFFE0E0E0),
          width: _isFocused ? 1.5 : 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (currentItems.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: currentItems.map((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF0369A1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => _removeItem(item),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: Color(0xFF0369A1),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textCtrl,
                  focusNode: _focusNode,
                  style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(fontSize: 13, color: AppColors.textHint),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onSubmitted: _addItem,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _addItem(_textCtrl.text),
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFBAE6FD),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: Color(0xFF0369A1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.darkRed.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: AppColors.darkRed.withOpacity(0.2), width: 1),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,
              color: AppColors.darkRed)),
    );
  }
}

// ── Avatar Header ─────────────────────────────────────────────────────────────

class _AvatarHeader extends StatelessWidget {
  final String name;
  const _AvatarHeader({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: AppColors.darkRed),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      width: 55, height: 55,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.darkRed,
                      ),
                      child: Center(
                        child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'U',
                            style: const TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w600, fontSize: 20)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(name.toUpperCase(),
                        style: const TextStyle(color: Colors.black,
                            fontWeight: FontWeight.w800, fontSize: 16)),
                    const SizedBox(height: 4),
                    const Text('View and manage your professional information',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12, )),
                    const SizedBox(height: 12),
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

// ── Footer ────────────────────────────────────────────────────────────────────

class _FooterLink extends StatelessWidget {
  final String text;
  const _FooterLink(this.text);
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      if (text.contains('Privacy')) {
        launchUrl(Uri.parse('https://www.aimjobs.ai/Home/Privacy'));
      } else if (text.contains('Terms')) {
        launchUrl(Uri.parse('https://www.aimjobs.ai/Home/Terms'));
      }
    },
    child: Text(text,
        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
  );
}

class _FooterDivider extends StatelessWidget {
  const _FooterDivider();
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Text('|',
        style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
  );
}