class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String experience;
  final String jobType;       // Full-Time, Part-Time, etc.
  final String workLocation;  // Remote, Hybrid, On-site
  final String level;         // Entry Level, Mid Level, Senior, etc.
  final String industry;
  final String salary;
  final String postedDate;
  final String description;
  final List<String> skills;
  final List<String> tags;
  final String education;
  final String logoText;      // initials for avatar

  const JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.experience,
    required this.jobType,
    required this.workLocation,
    required this.level,
    required this.industry,
    required this.salary,
    required this.postedDate,
    required this.description,
    required this.skills,
    required this.tags,
    required this.education,
    required this.logoText,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    id: json['id']?.toString() ?? '',
    title: json['title']?.toString() ?? '',
    company: json['company']?.toString() ?? '',
    location: json['location']?.toString() ?? '',
    experience: json['experience']?.toString() ?? '',
    jobType: json['jobType']?.toString() ?? '',
    workLocation: json['workLocation']?.toString() ?? '',
    level: json['level']?.toString() ?? '',
    industry: json['industry']?.toString() ?? '',
    salary: json['salary']?.toString() ?? '',
    postedDate: json['postedDate']?.toString() ?? '',
    description: json['description']?.toString() ?? '',
    skills: List<String>.from(json['skills'] ?? []),
    tags: List<String>.from(json['tags'] ?? []),
    education: json['education']?.toString() ?? '',
    logoText: json['logoText']?.toString() ?? '',
  );
}