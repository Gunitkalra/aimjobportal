class GetAllSavedJobsResponseModel {
  GetAllSavedJobsResponseModel({
    required this.statusCode,
    required this.success,
    required this.data,
    required this.message,
    required this.errorCode,
  });

  final int? statusCode;
  final bool? success;
  final List<Datum> data;
  final String? message;
  final dynamic errorCode;

  factory GetAllSavedJobsResponseModel.fromJson(Map<String, dynamic> json){
    return GetAllSavedJobsResponseModel(
      statusCode: json["statusCode"],
      success: json["success"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      message: json["message"],
      errorCode: json["errorCode"],
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "data": data.map((x) => x?.toJson()).toList(),
    "message": message,
    "errorCode": errorCode,
  };

}

class Datum {
  Datum({
    required this.jobId,
    required this.jobTitle,
    required this.companyName,
    required this.locations,
    required this.requiredSkills,
    required this.minSalary,
    required this.maxSalary,
    required this.salaryCurrency,
    required this.salaryPeriod,
    required this.jobUrl,
    required this.savedAt,
  });

  final String? jobId;
  final String? jobTitle;
  final String? companyName;
  final List<String> locations;
  final List<String> requiredSkills;
  final dynamic minSalary;
  final dynamic maxSalary;
  final dynamic salaryCurrency;
  final String? salaryPeriod;
  final String? jobUrl;
  final DateTime? savedAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      jobId: json["jobId"],
      jobTitle: json["jobTitle"],
      companyName: json["companyName"],
      locations: json["locations"] == null ? [] : List<String>.from(json["locations"]!.map((x) => x)),
      requiredSkills: json["requiredSkills"] == null ? [] : List<String>.from(json["requiredSkills"]!.map((x) => x)),
      minSalary: json["minSalary"],
      maxSalary: json["maxSalary"],
      salaryCurrency: json["salaryCurrency"],
      salaryPeriod: json["salaryPeriod"],
      jobUrl: json["jobUrl"],
      savedAt: DateTime.tryParse(json["savedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "jobId": jobId,
    "jobTitle": jobTitle,
    "companyName": companyName,
    "locations": locations.map((x) => x).toList(),
    "requiredSkills": requiredSkills.map((x) => x).toList(),
    "minSalary": minSalary,
    "maxSalary": maxSalary,
    "salaryCurrency": salaryCurrency,
    "salaryPeriod": salaryPeriod,
    "jobUrl": jobUrl,
    "savedAt": savedAt?.toIso8601String(),
  };

}
