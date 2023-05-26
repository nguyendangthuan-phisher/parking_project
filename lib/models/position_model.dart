// To parse this JSON data, do
//
//     final positionModel = positionModelFromJson(jsonString);

import 'dart:convert';

List<PositionModel> positionModelFromJson(String str) => List<PositionModel>.from(json.decode(str).map((x) => PositionModel.fromJson(x)));

String positionModelToJson(PositionModel data) => json.encode(data.toJson());

class PositionModel {
  int positionId;
  String positionName;
  String description;
  dynamic status;
  String condition;
  dynamic parking;
  dynamic position;

  PositionModel({
    required this.positionId,
    required this.positionName,
    required this.description,
    this.status,
    required this.condition,
    this.parking,
    this.position,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) => PositionModel(
    positionId: json["positionId"],
    positionName: json["positionName"],
    description: json["description"],
    status: json["status"],
    condition: json["condition"],
    parking: json["parking"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "positionId": positionId,
    "positionName": positionName,
    "description": description,
    "status": status,
    "condition": condition,
    "parking": parking,
    "position": position,
  };
}
