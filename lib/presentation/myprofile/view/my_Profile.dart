import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/colors.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  // ── Personal Info ──────────────────────────────────────────────
  final _nameCtrl       = TextEditingController(text: 'Arpan Bhattacharjee');
  final _mobileCtrl     = TextEditingController(text: '7679330631');
  final _genderCtrl     = TextEditingController(text: 'Male');
  final _dobCtrl        = TextEditingController(text: 'Not specified');
  final _emailCtrl      = TextEditingController(text: 'targetyou@gmail.com');

  // ── Job Details ────────────────────────────────────────────────
  final _designationCtrl  = TextEditingController(text: 'BPO L2 Agent');
  final _ctcCtrl          = TextEditingController(text: 'Not specified');
  final _expCtrl          = TextEditingController(text: '11 Years');
  final _locationCtrl     = TextEditingController(text: 'Asansol, India');
  final _noticePeriodCtrl = TextEditingController(text: 'Not specified');
  final _industryCtrl     = TextEditingController(text: 'Not specified');
  final _departmentCtrl   = TextEditingController(text: 'Not specified');
  final _jobTypeCtrl      = TextEditingController(text: 'Not specified');

  // ── Profile Summary ────────────────────────────────────────────
  final _summaryCtrl = TextEditingController(
    text: 'Quality-focused professional with a career in ensuring product and process excellence. Skilled in identifying defects, improving processes, and collaborating with cross-functional teams to enhance quality standards. Committed to delivering reliable and high-quality outcomes through rigorous testing and analysis.',
  );

  // ── Skills ─────────────────────────────────────────────────────
  final _skillsCtrl    = TextEditingController(text: 'Quality Monitoring & Auditing, Analytical Thinking, Attention to Detail, Communication Skills');
  final _languagesCtrl = TextEditingController(text: 'Not specified');

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

  @override
  void initState() {
    super.initState();
    _workEntries = [
      WorkExpEntry(
        company:  'Startek (Aegis)',
        position: 'BPO L2 Agent',
        duration: 'Jun 2021 – Jul 2022',
        description: 'As a BPO L2 agent worked with a client like Zomato, responsibilities included handling inbound customer queries, managing sensitive cases, and coordinating with internal teams.',
      ),
    ];
    _eduEntries = [
      EduEntry(degree: '10th',       institute: 'State Board',                                      level: '10th'),
      EduEntry(degree: '12th',       institute: 'State Board',                                      level: '12th'),
      EduEntry(degree: 'Graduation', institute: 'Narula Institute of technology and engineering',   level: 'Graduation'),
    ];
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl, _mobileCtrl, _genderCtrl, _dobCtrl, _emailCtrl,
      _designationCtrl, _ctcCtrl, _expCtrl, _locationCtrl,
      _noticePeriodCtrl, _industryCtrl, _departmentCtrl, _jobTypeCtrl,
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
        title: const Text('My Profile',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,
                color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: 16),
        child: Column(
          children: [
            _AvatarHeader(),
            const SizedBox(height: 16),

            // Personal Information
            _ProfileCard(
              icon: Icons.person_outline_rounded,
              title: 'Personal Information',
              isEditing: _editPersonal,
              onEdit: () => _startEdit((v) => _editPersonal = v,
                  [_nameCtrl, _mobileCtrl, _genderCtrl, _dobCtrl, _emailCtrl]),
              onCancel: () => _cancelEdit((v) => _editPersonal = v,
                  [_nameCtrl, _mobileCtrl, _genderCtrl, _dobCtrl, _emailCtrl]),
              onSave: () => _saveEdit((v) => _editPersonal = v),
              viewChild: _InfoGrid(rows: [
                _InfoRow('Full Name',      _nameCtrl.text),
                _InfoRow('Mobile Number',  _mobileCtrl.text),
                _InfoRow('Gender',         _genderCtrl.text),
                _InfoRow('Date of Birth',  _dobCtrl.text),
                _InfoRow('Email Address',  _emailCtrl.text, isVerified: true),
              ]),
              editChild: _EditGrid(fields: [
                _EditField('Full Name',      _nameCtrl),
                _EditField('Mobile Number',  _mobileCtrl, inputType: TextInputType.phone),
                _EditField('Gender',         _genderCtrl),
                _EditField('Date of Birth',  _dobCtrl),
                _EditField('Email Address',  _emailCtrl, inputType: TextInputType.emailAddress),
              ]),
            ),
            const SizedBox(height: 12),

            // Job Details
            _ProfileCard(
              icon: Icons.work_outline_rounded,
              title: 'Job Details',
              isEditing: _editJob,
              onEdit: () => _startEdit((v) => _editJob = v, [
                _designationCtrl, _ctcCtrl, _expCtrl, _locationCtrl,
                _noticePeriodCtrl, _industryCtrl, _departmentCtrl, _jobTypeCtrl,
              ]),
              onCancel: () => _cancelEdit((v) => _editJob = v, [
                _designationCtrl, _ctcCtrl, _expCtrl, _locationCtrl,
                _noticePeriodCtrl, _industryCtrl, _departmentCtrl, _jobTypeCtrl,
              ]),
              onSave: () => _saveEdit((v) => _editJob = v),
              viewChild: _InfoGrid(rows: [
                _InfoRow('Designation',        _designationCtrl.text),
                _InfoRow('Current CTC',        _ctcCtrl.text),
                _InfoRow('Total Experience',   _expCtrl.text),
                _InfoRow('Current Location',   _locationCtrl.text),
                _InfoRow('Notice Period',      _noticePeriodCtrl.text),
                _InfoRow('Preferred Locations','Not specified'),
                _InfoRow('Industry',           _industryCtrl.text),
                _InfoRow('Department',         _departmentCtrl.text),
                _InfoRow('Job Type',           _jobTypeCtrl.text),
              ]),
              editChild: _EditGrid(fields: [
                _EditField('Designation',      _designationCtrl),
                _EditField('Current CTC',      _ctcCtrl),
                _EditField('Total Experience', _expCtrl),
                _EditField('Current Location', _locationCtrl),
                _EditField('Notice Period',    _noticePeriodCtrl),
                _EditField('Industry',         _industryCtrl),
                _EditField('Department',       _departmentCtrl),
                _EditField('Job Type',         _jobTypeCtrl),
              ]),
            ),
            const SizedBox(height: 12),

            // Profile Summary
            _ProfileCard(
              icon: Icons.article_outlined,
              title: 'Profile Summary',
              isEditing: _editSummary,
              onEdit: () => _startEdit((v) => _editSummary = v, [_summaryCtrl]),
              onCancel: () => _cancelEdit((v) => _editSummary = v, [_summaryCtrl]),
              onSave: () => _saveEdit((v) => _editSummary = v),
              viewChild: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(_summaryCtrl.text,
                    style: const TextStyle(fontSize: 13,
                        color: AppColors.textSecondary, height: 1.6)),
              ),
              editChild: _buildTextField(_summaryCtrl,
                  label: 'Professional Summary', maxLines: 6),
            ),
            const SizedBox(height: 12),

            // Skills & Languages
            _ProfileCard(
              icon: Icons.lightbulb_outline_rounded,
              title: 'Skills & Languages',
              isEditing: _editSkills,
              onEdit: () => _startEdit(
                      (v) => _editSkills = v, [_skillsCtrl, _languagesCtrl]),
              onCancel: () => _cancelEdit(
                      (v) => _editSkills = v, [_skillsCtrl, _languagesCtrl]),
              onSave: () => _saveEdit((v) => _editSkills = v),
              viewChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Skills',
                      style: TextStyle(fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: _skillsCtrl.text.split(',')
                        .map((s) => _SkillChip(label: s.trim())).toList(),
                  ),
                  const SizedBox(height: 14),
                  const Text('Languages',
                      style: TextStyle(fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(_languagesCtrl.text,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textSecondary)),
                ],
              ),
              editChild: Column(
                children: [
                  _buildTextField(_skillsCtrl,
                      label: 'Skills (comma separated)', maxLines: 3),
                  const SizedBox(height: 12),
                  _buildTextField(_languagesCtrl, label: 'Languages'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Work Experience ──────────────────────────────────────
            _MultiEntryCard(
              icon: Icons.business_center_outlined,
              title: 'Work Experience',
              isEditing: _editWork,
              onEdit: _startWorkEdit,
              onCancel: _cancelWorkEdit,
              onSave: _saveWorkEdit,
              onAdd: _addWorkEntry,
              addLabel: '+ Add Work Experience',
              viewChild: Column(
                children: _workEntries.asMap().entries.map((e) {
                  final entry = e.value;
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: e.key < _workEntries.length - 1 ? 10 : 0),
                    child: _WorkExpViewCard(
                      company:     entry.companyCtrl.text,
                      position:    entry.positionCtrl.text,
                      duration:    entry.durationCtrl.text,
                      description: entry.descCtrl.text,
                    ),
                  );
                }).toList(),
              ),
              editChild: Column(
                children: _workEntries.asMap().entries.map((e) {
                  final i     = e.key;
                  final entry = e.value;
                  return _WorkExpEditCard(
                    entry: entry,
                    index: i,
                    total: _workEntries.length,
                    onRemove: () => _removeWorkEntry(i),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // ── Education ────────────────────────────────────────────
            _MultiEntryCard(
              icon: Icons.school_outlined,
              title: 'Education',
              isEditing: _editEdu,
              onEdit: _startEduEdit,
              onCancel: _cancelEduEdit,
              onSave: _saveEduEdit,
              onAdd: _addEduEntry,
              addLabel: '+ Add Education',
              viewChild: Column(
                children: _eduEntries.asMap().entries.map((e) {
                  final entry = e.value;
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: e.key < _eduEntries.length - 1 ? 10 : 0),
                    child: _EduViewCard(
                      degree:    entry.degreeCtrl.text,
                      institute: entry.instCtrl.text,
                      level:     entry.levelCtrl.text,
                    ),
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
            const Text('© 2026 Aim Job Techno. All Rights Reserved.',
                style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
            const SizedBox(height: 16),
          ],
        ),
      ),
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
  final TextEditingController durationCtrl;
  final TextEditingController descCtrl;

  WorkExpEntry({
    String company = '', String position = '',
    String duration = '', String description = '',
  })  : companyCtrl  = TextEditingController(text: company),
        positionCtrl = TextEditingController(text: position),
        durationCtrl = TextEditingController(text: duration),
        descCtrl     = TextEditingController(text: description);

  WorkExpEntry clone() => WorkExpEntry(
    company:     companyCtrl.text,
    position:    positionCtrl.text,
    duration:    durationCtrl.text,
    description: descCtrl.text,
  );

  void dispose() {
    companyCtrl.dispose();
    positionCtrl.dispose();
    durationCtrl.dispose();
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
  final IconData icon;
  final String title;
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final VoidCallback onAdd;
  final String addLabel;
  final Widget viewChild;
  final Widget editChild;

  const _MultiEntryCard({
    required this.icon, required this.title,
    required this.isEditing,
    required this.onEdit, required this.onCancel, required this.onSave,
    required this.onAdd, required this.addLabel,
    required this.viewChild, required this.editChild,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isEditing
            ? Border.all(color: AppColors.darkRed.withOpacity(0.3), width: 1.5)
            : Border.all(color: Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: isEditing
                ? AppColors.darkRed.withOpacity(0.08)
                : Colors.black.withOpacity(0.04),
            blurRadius: isEditing ? 16 : 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 34, height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.darkRed.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(icon, color: AppColors.darkRed, size: 18),
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.darkRed.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined,
                              size: 13, color: AppColors.darkRed),
                          const SizedBox(width: 4),
                          Text('Edit',
                              style: TextStyle(fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkRed)),
                        ],
                      ),
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
                  GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.darkRed.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.darkRed.withOpacity(0.25),
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_outline_rounded,
                              size: 18, color: AppColors.darkRed),
                          const SizedBox(width: 6),
                          Text(addLabel,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkRed)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Cancel / Save ────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onCancel,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: AppColors.darkRed, width: 1.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text('Cancel',
                              style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkRed)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: AppColors.blueGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton(
                            onPressed: onSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Save Changes',
                                style: TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
    final initial = company.isNotEmpty ? company[0].toUpperCase() : 'C';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                    color: AppColors.darkRed,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(initial,
                        style: const TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w800, fontSize: 16))),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(company.isEmpty ? 'Company' : company,
                        style: const TextStyle(fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary)),
                    Text(position.isEmpty ? 'Position' : position,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          if (duration.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 13, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Text(duration,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ],
          if (description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(description,
                style: const TextStyle(fontSize: 12,
                    color: AppColors.textSecondary, height: 1.5)),
          ],
        ],
      ),
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Entry header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: AppColors.blueGradient,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Experience ${index + 1}',
                    style: const TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w700, color: Colors.white)),
              ),
              const Spacer(),
              if (total > 1)
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: Colors.red.shade200, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline_rounded,
                            size: 13, color: Colors.red.shade600),
                        const SizedBox(width: 4),
                        Text('Remove',
                            style: TextStyle(fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.red.shade600)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _labeledField('Company',     entry.companyCtrl,  hint: 'e.g. Tata Consultancy'),
          const SizedBox(height: 10),
          _labeledField('Position',    entry.positionCtrl, hint: 'e.g. Software Engineer'),
          const SizedBox(height: 10),
          _labeledField('Duration',    entry.durationCtrl, hint: 'e.g. Jan 2020 – Mar 2022'),
          const SizedBox(height: 10),
          _labeledField('Description', entry.descCtrl,     hint: 'Describe your role...', maxLines: 3),
        ],
      ),
    );
  }

  Widget _labeledField(String label, TextEditingController ctrl,
      {String? hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                color: AppColors.textSecondary)),
        const SizedBox(height: 5),
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
          decoration: _inputDeco(hint: hint),
        ),
      ],
    );
  }
}

// ── Education – view card ─────────────────────────────────────────────────────

class _EduViewCard extends StatelessWidget {
  final String degree, institute, level;
  const _EduViewCard(
      {required this.degree, required this.institute, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: AppColors.darkRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.school_outlined,
                color: AppColors.darkRed, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(degree.isEmpty ? 'Degree' : degree,
                    style: const TextStyle(fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(institute.isEmpty ? 'Institution / Board' : institute,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          if (level.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.darkRed.withOpacity(0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(level,
                  style: TextStyle(fontSize: 11,
                      fontWeight: FontWeight.w600, color: AppColors.darkRed)),
            ),
        ],
      ),
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
    required this.entry, required this.index,
    required this.total, required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: AppColors.blueGradient,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Education ${index + 1}',
                    style: const TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w700, color: Colors.white)),
              ),
              const Spacer(),
              if (total > 1)
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: Colors.red.shade200, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline_rounded,
                            size: 13, color: Colors.red.shade600),
                        const SizedBox(width: 4),
                        Text('Remove',
                            style: TextStyle(fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.red.shade600)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _labeledField('Degree / Level', entry.degreeCtrl,
              hint: 'e.g. B.Tech, 10th, MBA'),
          const SizedBox(height: 10),
          _labeledField('Institution / Board', entry.instCtrl,
              hint: 'e.g. State Board, IIT Delhi'),
          const SizedBox(height: 10),
          _labeledField('Label (shown as badge)', entry.levelCtrl,
              hint: 'e.g. Graduation, 12th'),
        ],
      ),
    );
  }

  Widget _labeledField(String label, TextEditingController ctrl,
      {String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                color: AppColors.textSecondary)),
        const SizedBox(height: 5),
        TextFormField(
          controller: ctrl,
          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
          decoration: _inputDeco(hint: hint),
        ),
      ],
    );
  }
}

// ── Standard profile card (for non-list sections) ─────────────────────────────

class _ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isEditing;
  final VoidCallback onEdit, onCancel, onSave;
  final Widget viewChild, editChild;

  const _ProfileCard({
    required this.icon, required this.title,
    required this.isEditing,
    required this.onEdit, required this.onCancel, required this.onSave,
    required this.viewChild, required this.editChild,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isEditing
            ? Border.all(color: AppColors.darkRed.withOpacity(0.3), width: 1.5)
            : Border.all(color: Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: isEditing
                ? AppColors.darkRed.withOpacity(0.08)
                : Colors.black.withOpacity(0.04),
            blurRadius: isEditing ? 16 : 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 34, height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.darkRed.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(icon, color: AppColors.darkRed, size: 18),
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.darkRed.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined,
                              size: 13, color: AppColors.darkRed),
                          const SizedBox(width: 4),
                          Text('Edit',
                              style: TextStyle(fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkRed)),
                        ],
                      ),
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
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onCancel,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: AppColors.darkRed, width: 1.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text('Cancel',
                              style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkRed)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: AppColors.blueGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton(
                            onPressed: onSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Save Changes',
                                style: TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info display helpers ──────────────────────────────────────────────────────

class _InfoRow {
  final String label, value;
  final bool isVerified;
  _InfoRow(this.label, this.value, {this.isVerified = false});
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
              width: 140,
              child: Text(r.label,
                  style: const TextStyle(fontSize: 12,
                      color: AppColors.textMuted, fontWeight: FontWeight.w500)),
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(child: Text(r.value,
                      style: const TextStyle(fontSize: 13,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500))),
                  if (r.isVerified) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Verified',
                          style: TextStyle(fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2E7D32))),
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
  _EditField(this.label, this.ctrl, {this.inputType = TextInputType.text});
}

class _EditGrid extends StatelessWidget {
  final List<_EditField> fields;
  const _EditGrid({required this.fields});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fields.map((f) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(f.label,
                style: const TextStyle(fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary)),
            const SizedBox(height: 6),
            TextFormField(
              controller: f.ctrl,
              keyboardType: f.inputType,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textPrimary),
              decoration: _inputDeco(),
            ),
          ],
        ),
      )).toList(),
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
        borderRadius: BorderRadius.circular(6),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.25),
              border: Border.all(
                  color: Colors.white.withOpacity(0.5), width: 2.5),
            ),
            child: const Center(
              child: Text('A',
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w800, fontSize: 30)),
            ),
          ),
          const SizedBox(height: 12),
          const Text('My Profile',
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w800, fontSize: 20)),
          const SizedBox(height: 4),
          const Text('View and manage your professional information',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
        ],
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
    onTap: () {},
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