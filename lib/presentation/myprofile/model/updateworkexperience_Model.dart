class UpdateWorkExperiencesResponseModel {
  UpdateWorkExperiencesResponseModel({
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

  factory UpdateWorkExperiencesResponseModel.fromJson(Map<String, dynamic> json){
    return UpdateWorkExperiencesResponseModel(
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

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
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
