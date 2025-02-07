import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfrim; // This will hold the JWT token

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfrim,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      passwordConfrim: json['passwordConfrim'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfrim,
    };
  }

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}
