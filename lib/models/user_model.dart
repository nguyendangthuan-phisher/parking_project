// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String fullName;
  String email;
  String dob;
  bool gender;
  String phone;
  DateTime createdUser;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.createdUser,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    dob: json["dob"],
    gender: json["gender"],
    phone: json["phone"],
    createdUser: DateTime.parse(json["createdUser"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "dob": dob,
    "gender": gender,
    "phone": phone,
    "createdUser": createdUser.toIso8601String(),
  };
}
