import 'Job_Model.dart';

class GetJobsResponseModel {
  final List<JobModel> jobs;
  final int totalResults;
  final int totalPages;
  final int currentPage;

  GetJobsResponseModel({
    required this.jobs,
    required this.totalResults,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetJobsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetJobsResponseModel(
      jobs: (json['jobs'] as List<dynamic>? ?? [])
          .map((e) => JobModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: json['total_results'] as int? ?? 0,
      totalPages:   json['total_pages']   as int? ?? 0,
      currentPage:  json['current_page']  as int? ?? 0,
    );
  }
}
// class GetJobsResponseModel {
//   List<Job> jobs;
//   int totalResults;
//   int totalPages;
//   int currentPage;
//   dynamic locationHighlight;
//   dynamic countryName;
//
//   GetJobsResponseModel({
//     required this.jobs,
//     required this.totalResults,
//     required this.totalPages,
//     required this.currentPage,
//     required this.locationHighlight,
//     required this.countryName,
//   });
//
//   factory GetJobsResponseModel.fromJson(Map<String, dynamic> json) {
//     return GetJobsResponseModel(
//       jobs: (json['jobs'] as List)
//           .map((e) => Job.fromJson(e))
//           .toList(),
//       totalResults: json['totalResults'],
//       totalPages: json['totalPages'],
//       currentPage: json['currentPage'],
//       locationHighlight: json['locationHighlight'],
//       countryName: json['countryName'],
//     );
//   }
// }
//
// class Job {
//   String id;
//   String jobTitle;
//   CompanyName companyName;
//   String companyUrl;
//   String jobUrl;
//   List<String> locationNames;
//   DateTime postedDate;
//   List<Type> jobTypes;
//   LocationType locationType;
//   CompanyType companyType;
//   List<dynamic> jobAttributes;
//   dynamic companySummary;
//   List<CompanyType> industrySectors;
//   DateTime closingDate;
//   List<String> requiredSkills;
//   SeniorityLevel seniorityLevel;
//   JobFunction jobFunction;
//   int minRequiredExperience;
//   int maxRequiredExperience;
//   List<String> requiredEducation;
//   List<dynamic> certifications;
//   List<Language> languages;
//   dynamic minSalary;
//   dynamic maxSalary;
//   String? salaryCurrency;
//   String? salaryPeriod;
//   String highlight;
//   String location;
//   Type employmentType;
//
//   Job({
//     required this.id,
//     required this.jobTitle,
//     required this.companyName,
//     required this.companyUrl,
//     required this.jobUrl,
//     required this.locationNames,
//     required this.postedDate,
//     required this.jobTypes,
//     required this.locationType,
//     required this.companyType,
//     required this.jobAttributes,
//     required this.companySummary,
//     required this.industrySectors,
//     required this.closingDate,
//     required this.requiredSkills,
//     required this.seniorityLevel,
//     required this.jobFunction,
//     required this.minRequiredExperience,
//     required this.maxRequiredExperience,
//     required this.requiredEducation,
//     required this.certifications,
//     required this.languages,
//     required this.minSalary,
//     required this.maxSalary,
//     required this.salaryCurrency,
//     required this.salaryPeriod,
//     required this.highlight,
//     required this.location,
//     required this.employmentType,
//   });
//
//   factory Job.fromJson(Map<String, dynamic> json) {
//     return Job(
//       id: json['id'],
//       jobTitle: json['jobTitle'],
//       companyName: CompanyName.values.firstWhere(
//             (e) => e.name == json['companyName'],
//       ),
//       companyUrl: json['companyUrl'],
//       jobUrl: json['jobUrl'],
//       locationNames: List<String>.from(json['locationNames']),
//       postedDate: DateTime.parse(json['postedDate']),
//       jobTypes: (json['jobTypes'] as List)
//           .map((e) => Type.values.firstWhere((t) => t.name == e))
//           .toList(),
//       locationType: LocationType.values.firstWhere(
//             (e) => e.name == json['locationType'],
//       ),
//       companyType: CompanyType.values.firstWhere(
//             (e) => e.name == json['companyType'],
//       ),
//       jobAttributes: List<dynamic>.from(json['jobAttributes']),
//       companySummary: json['companySummary'],
//       industrySectors: (json['industrySectors'] as List)
//           .map((e) => CompanyType.values.firstWhere((t) => t.name == e))
//           .toList(),
//       closingDate: DateTime.parse(json['closingDate']),
//       requiredSkills: List<String>.from(json['requiredSkills']),
//       seniorityLevel: SeniorityLevel.values.firstWhere(
//             (e) => e.name == json['seniorityLevel'],
//       ),
//       jobFunction: JobFunction.values.firstWhere(
//             (e) => e.name == json['jobFunction'],
//       ),
//       minRequiredExperience: json['minRequiredExperience'],
//       maxRequiredExperience: json['maxRequiredExperience'],
//       requiredEducation: List<String>.from(json['requiredEducation']),
//       certifications: List<dynamic>.from(json['certifications']),
//       languages: (json['languages'] as List)
//           .map((e) => Language.values.firstWhere((l) => l.name == e))
//           .toList(),
//       minSalary: json['minSalary'],
//       maxSalary: json['maxSalary'],
//       salaryCurrency: json['salaryCurrency'],
//       salaryPeriod: json['salaryPeriod'],
//       highlight: json['highlight'],
//       location: json['location'],
//       employmentType: Type.values.firstWhere(
//             (e) => e.name == json['employmentType'],
//       ),
//     );
//   }
// }
//
// enum CompanyName {
//   TATA_CONSULTANCY_SERVICES
// }
//
// enum CompanyType {
//   IT_SERVICES,
//   TECHNOLOGY
// }
//
// enum Type {
//   FULL_TIME
// }
//
// enum JobFunction {
//   IT_INFRASTRUCTURE_SERVICES,
//   TECHNOLOGY
// }
//
// enum Language {
//   ENGLISH
// }
//
// enum LocationType {
//   ON_SITE
// }
//
// enum SeniorityLevel {
//   MID_LEVEL,
//   SENIOR
// }