// ── Response model ────────────────────────────────────────────────────────────

class GetJobsResponseModel {
  final List<Job> jobs;
  final int totalResults;
  final int totalPages;
  final int currentPage;
  final dynamic locationHighlight;
  final dynamic countryName;

  GetJobsResponseModel({
    required this.jobs,
    required this.totalResults,
    required this.totalPages,
    required this.currentPage,
    this.locationHighlight,
    this.countryName,
  });

  factory GetJobsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetJobsResponseModel(
      jobs: (json['jobs'] as List<dynamic>? ?? [])
          .map((j) => Job.fromJson(j as Map<String, dynamic>))
          .toList(),
      totalResults: json['totalResults'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      currentPage: json['currentPage'] as int? ?? 1,
      locationHighlight: json['locationHighlight'],
      countryName: json['countryName'],
    );
  }
}

// ── Job model ─────────────────────────────────────────────────────────────────

class Job {
  final String id;
  final String jobTitle;
  final String companyName;
  final String companyUrl;
  final String jobUrl;
  final List<String> locationNames;
  final String postedDate;
  final List<String> jobTypes;
  final String locationType;
  final String companyType;
  final List<dynamic> jobAttributes;
  final dynamic companySummary;
  final List<String> industrySectors;
  final String closingDate;
  final List<String> requiredSkills;
  final String seniorityLevel;
  final String jobFunction;
  final int minRequiredExperience;
  final int maxRequiredExperience;
  final List<String> requiredEducation;
  final List<dynamic> certifications;
  final List<String> languages;
  final dynamic minSalary;
  final dynamic maxSalary;
  final String? salaryCurrency;
  final String? salaryPeriod;
  final String highlight;
  final String location;
  final String employmentType;

  Job({
    required this.id,
    required this.jobTitle,
    required this.companyName,
    required this.companyUrl,
    required this.jobUrl,
    required this.locationNames,
    required this.postedDate,
    required this.jobTypes,
    required this.locationType,
    required this.companyType,
    required this.jobAttributes,
    required this.companySummary,
    required this.industrySectors,
    required this.closingDate,
    required this.requiredSkills,
    required this.seniorityLevel,
    required this.jobFunction,
    required this.minRequiredExperience,
    required this.maxRequiredExperience,
    required this.requiredEducation,
    required this.certifications,
    required this.languages,
    required this.minSalary,
    required this.maxSalary,
    required this.salaryCurrency,
    required this.salaryPeriod,
    required this.highlight,
    required this.location,
    required this.employmentType,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse list of strings
    List<String> toStringList(dynamic val) {
      if (val == null) return [];
      if (val is List) return val.map((e) => e?.toString() ?? '').toList();
      return [];
    }

    return Job(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      jobTitle: json['job_title']?.toString() ?? json['jobTitle']?.toString() ?? '',
      companyName: json['company_name']?.toString() ?? json['companyName']?.toString() ?? '',
      companyUrl: json['company_url']?.toString() ?? json['companyUrl']?.toString() ?? '',
      jobUrl: json['job_url']?.toString() ?? json['jobUrl']?.toString() ?? '',
      locationNames: toStringList(json['location_names'] ?? json['locationNames']),
      postedDate: json['posted_date']?.toString() ?? json['postedDate']?.toString() ?? '',
      jobTypes: toStringList(json['job_types'] ?? json['jobTypes']),
      locationType: json['location_type']?.toString() ?? json['locationType']?.toString() ?? '',
      companyType: json['company_type']?.toString() ?? json['companyType']?.toString() ?? '',
      jobAttributes: (json['job_attributes'] ?? json['jobAttributes']) as List<dynamic>? ?? [],
      companySummary: json['company_summary'] ?? json['companySummary'],
      industrySectors: toStringList(json['industry_sectors'] ?? json['industrySectors']),
      closingDate: json['closing_date']?.toString() ?? json['closingDate']?.toString() ?? '',
      requiredSkills: toStringList(json['required_skills'] ?? json['requiredSkills']),
      seniorityLevel: json['seniority_level']?.toString() ?? json['seniorityLevel']?.toString() ?? '',
      jobFunction: json['job_function']?.toString() ?? json['jobFunction']?.toString() ?? '',
      minRequiredExperience:
      ((json['min_required_experience'] ?? json['minRequiredExperience']) as num?)?.toInt() ?? 0,
      maxRequiredExperience:
      ((json['max_required_experience'] ?? json['maxRequiredExperience']) as num?)?.toInt() ?? 0,
      requiredEducation: toStringList(json['required_education'] ?? json['requiredEducation']),
      certifications: json['certifications'] as List<dynamic>? ?? [],
      languages: toStringList(json['languages']),
      minSalary: json['min_salary'] ?? json['minSalary'],
      maxSalary: json['max_salary'] ?? json['maxSalary'],
      salaryCurrency: json['salary_currency']?.toString() ?? json['salaryCurrency']?.toString(),
      salaryPeriod: json['salary_period']?.toString() ?? json['salaryPeriod']?.toString(),
      highlight: json['highlight']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      employmentType: json['employment_type']?.toString() ?? json['employmentType']?.toString() ?? '',
    );
  }
}