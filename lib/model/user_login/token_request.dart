// To parse this JSON local_data, do
//
//     final tokenRequest = tokenRequestFromJson(jsonString);

import 'dart:convert';

import 'package:ex6/api/decodable.dart';

// TokenRequest tokenRequestFromJson(String str) => TokenRequest.fromJson(json.decode(str));
//
// String tokenRequestToJson(TokenRequest local_data) => json.encode(local_data.toJson());

class TokenRequest implements Decodable<TokenRequest>{
  TokenRequest({
    this.success,
    this.expiresAt,
    this.requestToken,
  });

  bool? success;
  String? expiresAt;
  String? requestToken;

  factory TokenRequest.fromJson(Map<String, dynamic> json) => TokenRequest(
    success: json["success"],
    expiresAt: json["expires_at"],
    requestToken: json["request_token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "expires_at": expiresAt,
    "request_token": requestToken,
  };

  @override
  TokenRequest decode(json) {
    success= json["success"];
    expiresAt= json["expires_at"];
    requestToken= json["request_token"];
    return this;
  }
}
