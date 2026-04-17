class GetDashboardResponseModel {
  GetDashboardResponseModel({
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

  factory GetDashboardResponseModel.fromJson(Map<String, dynamic> json){
    return GetDashboardResponseModel(
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
    required this.userId,
    required this.fullName,
    required this.email,
    required this.profilePictureUrl,
    required this.profileCompletionPercentage,
    required this.completionStatus,
    required this.missingFields,
    required this.savedJobsCount,
    required this.applicationsCount,
    required this.profileViewsThisWeek,
    required this.jobMatchesCount,
    required this.lastProfileUpdate,
    required this.cvUploadStatus,
    required this.recentActivities,
    required this.recommendedJobs,
  });

  final String? userId;
  final String? fullName;
  final String? email;
  final dynamic profilePictureUrl;
  final int? profileCompletionPercentage;
  final CompletionStatus? completionStatus;
  final List<MissingField> missingFields;
  final int? savedJobsCount;
  final int? applicationsCount;
  final int? profileViewsThisWeek;
  final int? jobMatchesCount;
  final DateTime? lastProfileUpdate;
  final CvUploadStatus? cvUploadStatus;
  final List<RecentActivity> recentActivities;
  final dynamic recommendedJobs;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      userId: json["userId"],
      fullName: json["fullName"],
      email: json["email"],
      profilePictureUrl: json["profilePictureUrl"],
      profileCompletionPercentage: json["profileCompletionPercentage"],
      completionStatus: json["completionStatus"] == null ? null : CompletionStatus.fromJson(json["completionStatus"]),
      missingFields: json["missingFields"] == null ? [] : List<MissingField>.from(json["missingFields"]!.map((x) => MissingField.fromJson(x))),
      savedJobsCount: json["savedJobsCount"],
      applicationsCount: json["applicationsCount"],
      profileViewsThisWeek: json["profileViewsThisWeek"],
      jobMatchesCount: json["jobMatchesCount"],
      lastProfileUpdate: DateTime.tryParse(json["lastProfileUpdate"] ?? ""),
      cvUploadStatus: json["cvUploadStatus"] == null ? null : CvUploadStatus.fromJson(json["cvUploadStatus"]),
      recentActivities: json["recentActivities"] == null ? [] : List<RecentActivity>.from(json["recentActivities"]!.map((x) => RecentActivity.fromJson(x))),
      recommendedJobs: json["recommendedJobs"],
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "email": email,
    "profilePictureUrl": profilePictureUrl,
    "profileCompletionPercentage": profileCompletionPercentage,
    "completionStatus": completionStatus?.toJson(),
    "missingFields": missingFields.map((x) => x?.toJson()).toList(),
    "savedJobsCount": savedJobsCount,
    "applicationsCount": applicationsCount,
    "profileViewsThisWeek": profileViewsThisWeek,
    "jobMatchesCount": jobMatchesCount,
    "lastProfileUpdate": lastProfileUpdate?.toIso8601String(),
    "cvUploadStatus": cvUploadStatus?.toJson(),
    "recentActivities": recentActivities.map((x) => x?.toJson()).toList(),
    "recommendedJobs": recommendedJobs,
  };

}

class CompletionStatus {
  CompletionStatus({
    required this.personalInfoPercentage,
    required this.jobDetailsPercentage,
    required this.profileSummaryPercentage,
    required this.skillsLanguagesPercentage,
    required this.workExperiencePercentage,
    required this.educationPercentage,
    required this.isPersonalInfoComplete,
    required this.isJobDetailsComplete,
    required this.isProfileSummaryComplete,
    required this.isSkillsLanguagesComplete,
    required this.isWorkExperienceComplete,
    required this.isEducationComplete,
  });

  final int? personalInfoPercentage;
  final int? jobDetailsPercentage;
  final int? profileSummaryPercentage;
  final int? skillsLanguagesPercentage;
  final int? workExperiencePercentage;
  final int? educationPercentage;
  final bool? isPersonalInfoComplete;
  final bool? isJobDetailsComplete;
  final bool? isProfileSummaryComplete;
  final bool? isSkillsLanguagesComplete;
  final bool? isWorkExperienceComplete;
  final bool? isEducationComplete;

  factory CompletionStatus.fromJson(Map<String, dynamic> json){
    return CompletionStatus(
      personalInfoPercentage: json["personalInfoPercentage"],
      jobDetailsPercentage: json["jobDetailsPercentage"],
      profileSummaryPercentage: json["profileSummaryPercentage"],
      skillsLanguagesPercentage: json["skillsLanguagesPercentage"],
      workExperiencePercentage: json["workExperiencePercentage"],
      educationPercentage: json["educationPercentage"],
      isPersonalInfoComplete: json["isPersonalInfoComplete"],
      isJobDetailsComplete: json["isJobDetailsComplete"],
      isProfileSummaryComplete: json["isProfileSummaryComplete"],
      isSkillsLanguagesComplete: json["isSkillsLanguagesComplete"],
      isWorkExperienceComplete: json["isWorkExperienceComplete"],
      isEducationComplete: json["isEducationComplete"],
    );
  }

  Map<String, dynamic> toJson() => {
    "personalInfoPercentage": personalInfoPercentage,
    "jobDetailsPercentage": jobDetailsPercentage,
    "profileSummaryPercentage": profileSummaryPercentage,
    "skillsLanguagesPercentage": skillsLanguagesPercentage,
    "workExperiencePercentage": workExperiencePercentage,
    "educationPercentage": educationPercentage,
    "isPersonalInfoComplete": isPersonalInfoComplete,
    "isJobDetailsComplete": isJobDetailsComplete,
    "isProfileSummaryComplete": isProfileSummaryComplete,
    "isSkillsLanguagesComplete": isSkillsLanguagesComplete,
    "isWorkExperienceComplete": isWorkExperienceComplete,
    "isEducationComplete": isEducationComplete,
  };

}

class CvUploadStatus {
  CvUploadStatus({
    required this.fileName,
    required this.uploadedAt,
    required this.status,
    required this.progressPercentage,
  });

  final String? fileName;
  final DateTime? uploadedAt;
  final String? status;
  final int? progressPercentage;

  factory CvUploadStatus.fromJson(Map<String, dynamic> json){
    return CvUploadStatus(
      fileName: json["fileName"],
      uploadedAt: DateTime.tryParse(json["uploadedAt"] ?? ""),
      status: json["status"],
      progressPercentage: json["progressPercentage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "fileName": fileName,
    "uploadedAt": uploadedAt?.toIso8601String(),
    "status": status,
    "progressPercentage": progressPercentage,
  };

}

class MissingField {
  MissingField({
    required this.fieldName,
    required this.section,
    required this.whyItMatters,
    required this.priority,
    required this.estimatedTime,
    required this.actionLink,
  });

  final String? fieldName;
  final String? section;
  final String? whyItMatters;
  final int? priority;
  final String? estimatedTime;
  final String? actionLink;

  factory MissingField.fromJson(Map<String, dynamic> json){
    return MissingField(
      fieldName: json["fieldName"],
      section: json["section"],
      whyItMatters: json["whyItMatters"],
      priority: json["priority"],
      estimatedTime: json["estimatedTime"],
      actionLink: json["actionLink"],
    );
  }

  Map<String, dynamic> toJson() => {
    "fieldName": fieldName,
    "section": section,
    "whyItMatters": whyItMatters,
    "priority": priority,
    "estimatedTime": estimatedTime,
    "actionLink": actionLink,
  };

}

class RecentActivity {
  RecentActivity({
    required this.activityType,
    required this.description,
    required this.timestamp,
    required this.icon,
  });

  final String? activityType;
  final String? description;
  final DateTime? timestamp;
  final String? icon;

  factory RecentActivity.fromJson(Map<String, dynamic> json){
    return RecentActivity(
      activityType: json["activityType"],
      description: json["description"],
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() => {
    "activityType": activityType,
    "description": description,
    "timestamp": timestamp?.toIso8601String(),
    "icon": icon,
  };

}
