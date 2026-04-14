// class JobModel {
//   final String id;
//   final String title;
//   final String company;
//   final String location;
//   final String experience;
//   final String jobType;       // Full-Time, Part-Time, etc.
//   final String workLocation;  // Remote, Hybrid, On-site
//   final String level;         // Entry Level, Mid Level, Senior, etc.
//   final String industry;
//   final String salary;
//   final String postedDate;
//   final String description;
//   final List<String> skills;
//   final List<String> tags;
//   final String education;
//   final String logoText;      // initials for avatar
//
//   const JobModel({
//     required this.id,
//     required this.title,
//     required this.company,
//     required this.location,
//     required this.experience,
//     required this.jobType,
//     required this.workLocation,
//     required this.level,
//     required this.industry,
//     required this.salary,
//     required this.postedDate,
//     required this.description,
//     required this.skills,
//     required this.tags,
//     required this.education,
//     required this.logoText,
//   });
//
//   factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
//     id: json['id']?.toString() ?? '',
//     title: json['title']?.toString() ?? '',
//     company: json['company']?.toString() ?? '',
//     location: json['location']?.toString() ?? '',
//     experience: json['experience']?.toString() ?? '',
//     jobType: json['jobType']?.toString() ?? '',
//     workLocation: json['workLocation']?.toString() ?? '',
//     level: json['level']?.toString() ?? '',
//     industry: json['industry']?.toString() ?? '',
//     salary: json['salary']?.toString() ?? '',
//     postedDate: json['postedDate']?.toString() ?? '',
//     description: json['description']?.toString() ?? '',
//     skills: List<String>.from(json['skills'] ?? []),
//     tags: List<String>.from(json['tags'] ?? []),
//     education: json['education']?.toString() ?? '',
//     logoText: json['logoText']?.toString() ?? '',
//   );
// }
class JobModel {
  final String id;
  final String title;
  final String company;
  final String companyUrl;
  final String jobUrl;
  final List<String> locationNames;
  final String rawPostedDate;
  final List<String> jobTypes;
  final String locationType;
  final String companyType;
  final List<String> requiredSkills;
  final List<String> industrysectors;
  final String seniorityLevel;
  final String jobFunction;
  final int? minExperience;
  final int? maxExperience;
  final List<String> requiredEducation;
  final String? salaryCurrency;   // ✅ nullable
  final String? salaryPeriod;     // ✅ nullable
  final String highlight;
  final String location;
  final String employmentType;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.companyUrl,
    required this.jobUrl,
    required this.locationNames,
    required this.rawPostedDate,
    required this.jobTypes,
    required this.locationType,
    required this.companyType,
    required this.requiredSkills,
    required this.industrysectors,
    required this.seniorityLevel,
    required this.jobFunction,
    this.minExperience,
    this.maxExperience,
    required this.requiredEducation,
    this.salaryCurrency,
    this.salaryPeriod,
    required this.highlight,
    required this.location,
    required this.employmentType,
  });

  // ── Computed getters used by JobCard ──────────────────────────────────────

  /// First letter of company name shown in avatar
  String get logoText =>
      company.isNotEmpty ? company[0].toUpperCase() : 'J';

  /// "5-10 Yrs" or "10+ Yrs"
  String get experience {
    if (minExperience != null && maxExperience != null) {
      return '$minExperience-$maxExperience Yrs';
    } else if (minExperience != null) {
      return '$minExperience+ Yrs';
    }
    return 'Not specified';
  }

  /// Highlight text used as description in JobCard
  String get description => highlight;

  /// First 5 required skills shown as tags
  List<String> get tags => requiredSkills.toList();
  List<String> get indsector => industrysectors.toList();

  /// Formatted date: "06 Mar 2026"
  String get postedDate {
    try {
      final dt = DateTime.parse(rawPostedDate);
      const months = [
        'Jan','Feb','Mar','Apr','May','Jun',
        'Jul','Aug','Sep','Oct','Nov','Dec'
      ];
      return '${dt.day.toString().padLeft(2,'0')} ${months[dt.month - 1]} ${dt.year}';
    } catch (_) {
      return rawPostedDate;
    }
  }

  // ── fromJson ──────────────────────────────────────────────────────────────

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id:             json['_id']           as String? ?? '',
      title:          json['job_title']     as String? ?? '',
      company:        json['company_name']  as String? ?? '',
      companyUrl:     json['company_url']   as String? ?? '',
      jobUrl:         json['job_url']       as String? ?? '',
      locationNames:  _toStringList(json['location_names']),
      rawPostedDate:  json['posted_date']   as String? ?? '',
      jobTypes:       _toStringList(json['job_types']),
      locationType:   json['location_type'] as String? ?? '',
      companyType:    json['company_type']  as String? ?? '',

      requiredSkills: _toStringList(json['required_skills']),
      industrysectors: _toStringList(json['industry_sectors']),
      seniorityLevel: json['seniority_level'] as String? ?? '',
      jobFunction:    json['job_function']    as String? ?? '',
      minExperience:  json['min_required_experience'] as int?,
      maxExperience:  json['max_required_experience'] as int?,
      requiredEducation: _toStringList(json['required_education']),
      salaryCurrency: json['salary_currency'] as String?,  // ✅ nullable — no cast error
      salaryPeriod:   json['salary_period']   as String?,  // ✅ nullable
      highlight:      json['highlight']       as String? ?? '',
      location:       json['location']        as String? ?? '',
      employmentType: json['employment_type'] as String? ?? '',
    );
  }

  static List<String> _toStringList(dynamic value) {
    if (value == null) return [];
    return (value as List<dynamic>).map((e) => e.toString()).toList();
  }
}