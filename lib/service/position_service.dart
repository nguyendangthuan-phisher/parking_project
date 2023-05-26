import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parking_project/models/position_model.dart';

class PositionService {
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String baseURL = 'https://ab77-118-69-73-134.ngrok-free.app';
  static Future<List<PositionModel>> getList() async {

    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    var response = await client.post(Uri.parse("$baseURL/api/position/all"),
        headers: headers);
    List<PositionModel> ls = [];
    if (response.statusCode == 200) {
      print('Tai du lieu thanh cong');
      var result = response.body;
      ls = positionModelFromJson(result);
      // print(ls[1].positionName);
      return ls;
    } else {
      print('Tai du lieu that bai');
      throw Exception("Loi lay du lieu. Chi tiết: ${response.statusCode}");
    }
  }
  static Future<void> loadPosition(token) async {
    String? token = await storage.read(key: 'Token');
    var client = http.Client();
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    var response = await client.post(Uri.parse("$baseURL/api/position/all"),
      headers: headers
    );
  }
}