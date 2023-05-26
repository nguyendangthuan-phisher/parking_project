import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parking_project/models/month_card_model.dart';

import '../models/car_model.dart';

class CardService {
  static FlutterSecureStorage storage = const FlutterSecureStorage();
  static String baseURL = 'https://ab77-118-69-73-134.ngrok-free.app';
  static Future<void> addCard (positionId)
  async {
    var client = http.Client();
    String? token = await storage.read(key: 'Token');
    print(token);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token!}'
    };
    var response = await client.post(Uri.parse("$baseURL/api/card/addCard"),
        headers: headers,
        body: json.encode({
          'positionID': positionId
        } )
    );
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result['status']);
      print(result['msg']);
    }
  }

  static Future<List<CardModel>> getList() async{
    String? token = await storage.read(key: 'Token');
    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token!}'
    };
    var response = await client.post(Uri.parse("$baseURL/api/card/list"),
        headers: headers);
    List<CardModel> ls = [];
    if (response.statusCode == 200) {
      print('Tai du lieu thanh cong');
      var result = json.decode(response.body);
      ls = cardModelFromJson(json.encode(result['data']));
      // print(ls[1].postion.positionName);
      return ls;
    } else {
      print('Tai du lieu that bai');
      throw Exception("Loi lay du lieu. Chi tiết: ${response.statusCode}");
    }
}
}