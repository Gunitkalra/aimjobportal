class UpdateSkillsLanguageResponseModel {
  UpdateSkillsLanguageResponseModel({
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

  factory UpdateSkillsLanguageResponseModel.fromJson(Map<String, dynamic> json){
    return UpdateSkillsLanguageResponseModel(
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
    required this.skills,
    required this.languages,
  });

  final List<String> skills;
  final List<String> languages;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
      languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "skills": skills.map((x) => x).toList(),
    "languages": languages.map((x) => x).toList(),
  };

}
