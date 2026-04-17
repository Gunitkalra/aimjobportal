class RefreshTokenResponseModel {
  RefreshTokenResponseModel({
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

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json){
    return RefreshTokenResponseModel(
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
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;
  final int? expiresIn;
  final User? user;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      tokenType: json["tokenType"],
      expiresIn: json["expiresIn"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "tokenType": tokenType,
    "expiresIn": expiresIn,
    "user": user?.toJson(),
  };

}

class User {
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.picture,
    required this.provider,
    required this.isProfileComplete,
  });

  final String? id;
  final String? email;
  final String? name;
  final dynamic picture;
  final String? provider;
  final bool? isProfileComplete;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      picture: json["picture"],
      provider: json["provider"],
      isProfileComplete: json["isProfileComplete"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "picture": picture,
    "provider": provider,
    "isProfileComplete": isProfileComplete,
  };

}
