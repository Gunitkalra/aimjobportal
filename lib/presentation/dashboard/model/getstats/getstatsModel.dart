class GetStatsResponseModel {
  GetStatsResponseModel({
    required this.totalJobsCount,
    required this.totalCompaniesWithJobsCount,
    required this.totalTrackingCompaniesCount,
    required this.companyWiseJobCount,
    required this.countryWiseJobCount,
    required this.locationTypeDistribution,
    required this.seniorityLevelDistribution,
    required this.topSkills,
    required this.lastUpdatedOn,
  });

  final int? totalJobsCount;
  final int? totalCompaniesWithJobsCount;
  final int? totalTrackingCompaniesCount;
  final CompanyWiseJobCount? companyWiseJobCount;
  final CountryWiseJobCount? countryWiseJobCount;
  final LocationTypeDistribution? locationTypeDistribution;
  final SeniorityLevelDistribution? seniorityLevelDistribution;
  final Map<String, int> topSkills;
  final DateTime? lastUpdatedOn;

  factory GetStatsResponseModel.fromJson(Map<String, dynamic> json){
    return GetStatsResponseModel(
      totalJobsCount: json["total_jobs_count"],
      totalCompaniesWithJobsCount: json["total_companies_with_jobs_count"],
      totalTrackingCompaniesCount: json["total_tracking_companies_count"],
      companyWiseJobCount: json["company_wise_job_count"] == null ? null : CompanyWiseJobCount.fromJson(json["company_wise_job_count"]),
      countryWiseJobCount: json["country_wise_job_count"] == null ? null : CountryWiseJobCount.fromJson(json["country_wise_job_count"]),
      locationTypeDistribution: json["location_type_distribution"] == null ? null : LocationTypeDistribution.fromJson(json["location_type_distribution"]),
      seniorityLevelDistribution: json["seniority_level_distribution"] == null ? null : SeniorityLevelDistribution.fromJson(json["seniority_level_distribution"]),
      topSkills: Map.from(json["top_skills"]).map((k, v) => MapEntry<String, int>(k, v)),
      lastUpdatedOn: DateTime.tryParse(json["last_updated_on"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "total_jobs_count": totalJobsCount,
    "total_companies_with_jobs_count": totalCompaniesWithJobsCount,
    "total_tracking_companies_count": totalTrackingCompaniesCount,
    "company_wise_job_count": companyWiseJobCount?.toJson(),
    "country_wise_job_count": countryWiseJobCount?.toJson(),
    "location_type_distribution": locationTypeDistribution?.toJson(),
    "seniority_level_distribution": seniorityLevelDistribution?.toJson(),
    "top_skills": Map.from(topSkills).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "last_updated_on": lastUpdatedOn?.toIso8601String(),
  };

}

class CompanyWiseJobCount {
  CompanyWiseJobCount({
    required this.tataConsultancyServices,
    required this.marutiSuzukiIndiaLtd,
    required this.heroMotoCorpLtd,
    required this.relianceIndustriesLtd,
  });

  final int? tataConsultancyServices;
  final int? marutiSuzukiIndiaLtd;
  final int? heroMotoCorpLtd;
  final int? relianceIndustriesLtd;

  factory CompanyWiseJobCount.fromJson(Map<String, dynamic> json){
    return CompanyWiseJobCount(
      tataConsultancyServices: json["Tata Consultancy Services"],
      marutiSuzukiIndiaLtd: json["Maruti Suzuki India Ltd."],
      heroMotoCorpLtd: json["Hero MotoCorp Ltd."],
      relianceIndustriesLtd: json["Reliance Industries Ltd."],
    );
  }

  Map<String, dynamic> toJson() => {
    "Tata Consultancy Services": tataConsultancyServices,
    "Maruti Suzuki India Ltd.": marutiSuzukiIndiaLtd,
    "Hero MotoCorp Ltd.": heroMotoCorpLtd,
    "Reliance Industries Ltd.": relianceIndustriesLtd,
  };

}

class CountryWiseJobCount {
  CountryWiseJobCount({
    required this.other,
    required this.india,
  });

  final int? other;
  final int? india;

  factory CountryWiseJobCount.fromJson(Map<String, dynamic> json){
    return CountryWiseJobCount(
      other: json["Other"],
      india: json["India"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Other": other,
    "India": india,
  };

}

class LocationTypeDistribution {
  LocationTypeDistribution({
    required this.onSite,
    required this.remote,
    required this.hybrid,
  });

  final int? onSite;
  final int? remote;
  final int? hybrid;

  factory LocationTypeDistribution.fromJson(Map<String, dynamic> json){
    return LocationTypeDistribution(
      onSite: json["On-site"],
      remote: json["Remote"],
      hybrid: json["Hybrid"],
    );
  }

  Map<String, dynamic> toJson() => {
    "On-site": onSite,
    "Remote": remote,
    "Hybrid": hybrid,
  };

}

class SeniorityLevelDistribution {
  SeniorityLevelDistribution({
    required this.midLevel,
    required this.senior,
    required this.entryLevel,
    required this.executive,
  });

  final int? midLevel;
  final int? senior;
  final int? entryLevel;
  final int? executive;

  factory SeniorityLevelDistribution.fromJson(Map<String, dynamic> json){
    return SeniorityLevelDistribution(
      midLevel: json["Mid-level"],
      senior: json["Senior"],
      entryLevel: json["Entry-level"],
      executive: json["Executive"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Mid-level": midLevel,
    "Senior": senior,
    "Entry-level": entryLevel,
    "Executive": executive,
  };

}
