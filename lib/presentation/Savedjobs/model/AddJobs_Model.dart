class AddJobResponseModel {
  AddJobResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.errorCode,
  });

  final int? statusCode;
  final bool? success;
  final String? message;
  final dynamic errorCode;

  factory AddJobResponseModel.fromJson(Map<String, dynamic> json){
    return AddJobResponseModel(
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
