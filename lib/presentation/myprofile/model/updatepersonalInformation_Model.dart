class UpdatePersonalInformationResponseModel {
  UpdatePersonalInformationResponseModel({
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

  factory UpdatePersonalInformationResponseModel.fromJson(Map<String, dynamic> json){
    return UpdatePersonalInformationResponseModel(
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
    required this.fullName,
    required this.mobileNumber,
    required this.gender,
    required this.dateOfBirth,
  });

  final String? fullName;
  final String? mobileNumber;
  final String? gender;
  final DateTime? dateOfBirth;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
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
