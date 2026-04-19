class UpdateEducationResponseModel {
  UpdateEducationResponseModel({
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

  factory UpdateEducationResponseModel.fromJson(Map<String, dynamic> json){
    return UpdateEducationResponseModel(
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
    required this.level,
    required this.institutionName,
    required this.degree,
  });

  final String? level;
  final String? institutionName;
  final String? degree;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
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
