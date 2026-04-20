class UpdateJobDetailResponseModel {
  UpdateJobDetailResponseModel({
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

  factory UpdateJobDetailResponseModel.fromJson(Map<String, dynamic> json){
    return UpdateJobDetailResponseModel(
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

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
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
