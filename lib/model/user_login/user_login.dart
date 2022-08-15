// To parse this JSON local_data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

import 'package:ex6/api/decodable.dart';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin implements Decodable<UserLogin>{
  UserLogin({
    required this.username,
    required this.password,
    required this.requestToken,
  });

  String username;
  String password;
  String requestToken;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    username: json["username"],
    password: json["password"],
    requestToken: json["request_token"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "request_token": requestToken,
  };

  @override
  UserLogin decode(json) {
    username= json["username"];
    password= json["password"];
    requestToken= json["request_token"];
    return this;
    // TODO: implement decode
  }
}
