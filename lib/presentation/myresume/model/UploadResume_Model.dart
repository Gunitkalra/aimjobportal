class UploadResumeResponseModel {
  UploadResumeResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.errorCode,
  });

  final int? statusCode;
  final bool? success;
  final String? message;
  final dynamic errorCode;

  factory UploadResumeResponseModel.fromJson(Map<String, dynamic> json){
    return UploadResumeResponseModel(
      statusCode: json["statusCode"],
      success: json["success"],
      message: json["message"],
      errorCode: json["errorCode"],
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "errorCode": errorCode,
  };

}
