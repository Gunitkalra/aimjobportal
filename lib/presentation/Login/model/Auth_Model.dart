class AuthModel {
  final String userId;
  final String name;
  final String email;
  final String token;

  const AuthModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    userId: json['id']?.toString()    ?? '',
    name:   json['name']?.toString()  ?? '',
    email:  json['email']?.toString() ?? '',
    token:  json['token']?.toString() ?? '',
  );
}