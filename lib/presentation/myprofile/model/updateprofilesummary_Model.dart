class UpdateProfileSummaryResponseModel {
  UpdateProfileSummaryResponseModel({
    required this.statusCode,
    required this.success,
    required this.data,
    required this.message,
    required this.errorCode,
  });

  final int? statusCode;
  final bool? success;
  final String? data;
  final String? message;
  final dynamic errorCode;

  factory UpdateProfileSummaryResponseModel.fromJson(Map<String, dynamic> json){
    return UpdateProfileSummaryResponseModel(
      statusCode: json["statusCode"],
      success: json["success"],
      data: json["data"],
      message: json["message"],
      errorCode: json["errorCode"],
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "data": data,
    "message": message,
    "errorCode": errorCode,
  };

}
