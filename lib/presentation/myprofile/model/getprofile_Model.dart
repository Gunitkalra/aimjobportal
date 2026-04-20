class GetProfileResponseModel {
  GetProfileResponseModel({
    required this.statusCode,
    required this.success,
    required this.data,
    required this.message,
    required this.errorCode,
  });

  final int? statusCode;
  final bool? success;
  final Data? data;
  final String? message;
  final dynamic errorCode;

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json){
    return GetProfileResponseModel(
      statusCode: json["statusCode"],
      success: json["success"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"],
      errorCode: json["errorCode"],
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "errorCode": errorCode,
  };

}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.profilePictureUrl,
    required this.authProvider,
    required this.isProfileComplete,
    required this.createdAt,
    required this.updatedAt,
    required this.personalInfo,
    required this.jobDetails,
    required this.profileSummary,
    required this.skillsLanguages,
    required this.workExperience,
    required this.education,
    required this.cvFileName,
    required this.cvUploadedAt,
    required this.cvParsingStatus,
  });

  final String? id;
  final String? email;
  final dynamic profilePictureUrl;
  final String? authProvider;
  final bool? isProfileComplete;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PersonalInfo? personalInfo;
  final JobDetails? jobDetails;
  final String? profileSummary;
  final SkillsLanguages? skillsLanguages;
  final List<WorkExperience> workExperience;
  final List<Education> education;
  final String? cvFileName;
  final DateTime? cvUploadedAt;
  final String? cvParsingStatus;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      email: json["email"],
      profilePictureUrl: json["profilePictureUrl"],
      authProvider: json["authProvider"],
      isProfileComplete: json["isProfileComplete"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      personalInfo: json["personalInfo"] == null ? null : PersonalInfo.fromJson(json["personalInfo"]),
      jobDetails: json["jobDetails"] == null ? null : JobDetails.fromJson(json["jobDetails"]),
      profileSummary: json["profileSummary"],
      skillsLanguages: json["skillsLanguages"] == null ? null : SkillsLanguages.fromJson(json["skillsLanguages"]),
      workExperience: json["workExperience"] == null ? [] : List<WorkExperience>.from(json["workExperience"]!.map((x) => WorkExperience.fromJson(x))),
      education: json["education"] == null ? [] : List<Education>.from(json["education"]!.map((x) => Education.fromJson(x))),
      cvFileName: json["cvFileName"],
      cvUploadedAt: DateTime.tryParse(json["cvUploadedAt"] ?? ""),
      cvParsingStatus: json["cvParsingStatus"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "profilePictureUrl": profilePictureUrl,
    "authProvider": authProvider,
    "isProfileComplete": isProfileComplete,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "personalInfo": personalInfo?.toJson(),
    "jobDetails": jobDetails?.toJson(),
    "profileSummary": profileSummary,
    "skillsLanguages": skillsLanguages?.toJson(),
    "workExperience": workExperience.map((x) => x?.toJson()).toList(),
    "education": education.map((x) => x?.toJson()).toList(),
    "cvFileName": cvFileName,
    "cvUploadedAt": cvUploadedAt?.toIso8601String(),
    "cvParsingStatus": cvParsingStatus,
  };

}

class Education {
  Education({
    required this.level,
    required this.institutionName,
    required this.degree,
  });

  final String? level;
  final String? institutionName;
  final String? degree;

  factory Education.fromJson(Map<String, dynamic> json){
    return Education(
      level: json["level"],
      institutionName: json["institutionName"],
      degree: json["degree"],
    );
  }

  Map<String, dynamic> toJson() => {
    "level": level,
    "institutionName": institutionName,
    "degree": degree,
  };

}

class JobDetails {
  JobDetails({
    required this.currentDesignation,
    required this.ctc,
    required this.totalExperience,
    required this.noticePeriod,
    required this.preferredLocations,
    required this.currentLocation,
    required this.industry,
    required this.department,
    required this.jobTypes,
  });

  final String? currentDesignation;
  final int? ctc;
  final int? totalExperience;
  final int? noticePeriod;
  final List<String> preferredLocations;
  final String? currentLocation;
  final String? industry;
  final String? department;
  final List<String> jobTypes;

  factory JobDetails.fromJson(Map<String, dynamic> json){
    return JobDetails(
      currentDesignation: json["currentDesignation"],
      ctc: json["ctc"] != null ? (json["ctc"] as num).toInt() : null,
      totalExperience: json["totalExperience"] != null ? (json["totalExperience"] as num).toInt() : null,
      noticePeriod: json["noticePeriod"] != null ? (json["noticePeriod"] as num).toInt() : null,
      preferredLocations: json["preferredLocations"] == null ? [] : List<String>.from(json["preferredLocations"]!.map((x) => x)),
      currentLocation: json["currentLocation"],
      industry: json["industry"],
      department: json["department"],
      jobTypes: json["jobTypes"] == null ? [] : List<String>.from(json["jobTypes"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "currentDesignation": currentDesignation,
    "ctc": ctc,
    "totalExperience": totalExperience,
    "noticePeriod": noticePeriod,
    "preferredLocations": preferredLocations.map((x) => x).toList(),
    "currentLocation": currentLocation,
    "industry": industry,
    "department": department,
    "jobTypes": jobTypes.map((x) => x).toList(),
  };

}

class PersonalInfo {
  PersonalInfo({
    required this.fullName,
    required this.mobileNumber,
    required this.gender,
    required this.dateOfBirth,
  });

  final String? fullName;
  final String? mobileNumber;
  final String? gender;
  final DateTime? dateOfBirth;

  factory PersonalInfo.fromJson(Map<String, dynamic> json){
    return PersonalInfo(
      fullName: json["fullName"],
      mobileNumber: json["mobileNumber"],
      gender: json["gender"],
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "mobileNumber": mobileNumber,
    "gender": gender,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
  };

}

class SkillsLanguages {
  SkillsLanguages({
    required this.skills,
    required this.languages,
  });

  final List<String> skills;
  final List<String> languages;

  factory SkillsLanguages.fromJson(Map<String, dynamic> json){
    return SkillsLanguages(
      skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
      languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "skills": skills.map((x) => x).toList(),
    "languages": languages.map((x) => x).toList(),
  };

}

class WorkExperience {
  WorkExperience({
    required this.company,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.isCurrentJob,
  });

  final String? company;
  final String? position;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  final bool? isCurrentJob;

  factory WorkExperience.fromJson(Map<String, dynamic> json){
    return WorkExperience(
      company: json["company"],
      position: json["position"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      description: json["description"],
      isCurrentJob: json["isCurrentJob"],
    );
  }

  Map<String, dynamic> toJson() => {
    "company": company,
    "position": position,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "description": description,
    "isCurrentJob": isCurrentJob,
  };

}
