// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

List<CardModel> cardModelFromJson(String str) => List<CardModel>.from(json.decode(str).map((x) => CardModel.fromJson(x)));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  int ticketId;
  DateTime startDate;
  DateTime endDate;
  String cardId;
  dynamic price;
  Postion postion;
  bool delete;

  CardModel({
    required this.ticketId,
    required this.startDate,
    required this.endDate,
    required this.cardId,
    this.price,
    required this.postion,
    required this.delete,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    ticketId: json["ticketId"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    cardId: json["cardID"],
    price: json["price"],
    postion: Postion.fromJson(json["postion"]),
    delete: json["delete"],
  );

  Map<String, dynamic> toJson() => {
    "ticketId": ticketId,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "cardID": cardId,
    "price": price,
    "postion": postion.toJson(),
    "delete": delete,
  };
}

class Postion {
  int positionId;
  String positionName;
  String description;
  String status;
  String condition;
  List<dynamic> parkings;

  Postion({
    required this.positionId,
    required this.positionName,
    required this.description,
    required this.status,
    required this.condition,
    required this.parkings,
  });

  factory Postion.fromJson(Map<String, dynamic> json) => Postion(
    positionId: json["positionId"],
    positionName: json["positionName"],
    description: json["description"],
    status: json["status"],
    condition: json["condition"],
    parkings: List<dynamic>.from(json["parkings"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "positionId": positionId,
    "positionName": positionName,
    "description": description,
    "status": status,
    "condition": condition,
    "parkings": List<dynamic>.from(parkings.map((x) => x)),
  };
}
