class GetMyResumeResponseModel {
  GetMyResumeResponseModel({
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

  factory GetMyResumeResponseModel.fromJson(Map<String, dynamic> json){
    return GetMyResumeResponseModel(
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
    required this.fileName,
    required this.uploadedAt,
    required this.parsedAt,
    required this.downloadUrl,
  });

  final String? fileName;
  final DateTime? uploadedAt;
  final DateTime? parsedAt;
  final String? downloadUrl;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      fileName: json["fileName"],
      uploadedAt: DateTime.tryParse(json["uploadedAt"] ?? ""),
      parsedAt: DateTime.tryParse(json["parsedAt"] ?? ""),
      downloadUrl: json["downloadUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "fileName": fileName,
    "uploadedAt": uploadedAt?.toIso8601String(),
    "parsedAt": parsedAt?.toIso8601String(),
    "downloadUrl": downloadUrl,
  };

}
