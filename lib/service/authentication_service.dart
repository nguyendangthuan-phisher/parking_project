import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:parking_project/models/user_model.dart';

class AuthenticatorServices {
  static FlutterSecureStorage storage = const FlutterSecureStorage();
  static String baseURL = 'https://ab77-118-69-73-134.ngrok-free.app';
  static Future<UserModel?> loginServices(username, password) async {
    var client = http.Client();
    print(baseURL);
    Map<String, String> headers = {"Content-type": "application/json","Access-Control_Allow_Origin": "*"
    };
    var response = await http.post(
      Uri.parse("$baseURL/api/auth/authenticate"),
      headers: headers,
      body: json.encode({
        'email': username,
        'password': password,
      }),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      await storage.write(key: 'Token', value: result['token']);
      print(result['token']);

      UserModel u = userModelFromJson(json.encode(result['data']));
      print(u.fullName);
      return u;
    }
    return null;
  }

  static String _convertDOB(dob) {
    final splitted = dob.split('/');
    return splitted[2] + '-' + splitted[1] + '-' + splitted[0];
  }

  static Future<void> updateService(name, email, phone, address, idCard,
      password, File frontCard, File backCard, File avatar) async {
    String? token = await storage.read(key: 'Token');
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse("$baseURL/api/driver/updateDriver"))
      ..headers.addAll(headers)
      ..fields['name'] = name
      ..fields['email'] = email
      ..fields['phone'] = phone
      ..fields['password'] = password;
  }

  static Future<String?> registerService(fullName, email, phone, password,
      gender, birthday ) async {

    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    var response = await http.post(
      Uri.parse("$baseURL/api/auth/register"),
      headers: headers,
      body: json.encode({
        'email': email,
        'fullname': fullName,
        'dob': birthday,
        'gender': gender==1,
        'phone': phone,
        'password': password
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);

      if (result['status'] == "Success") {
        print(result['msg']);
        return null;
      } else {
        print("lỗi");
        return result['msg'];
      }
    }
  }

  static Future<UserModel?> getInfomation() async {
    String? token = await storage.read(key: 'Token');
    var client = http.Client();

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token}'
    };
    var response =
    await client.post(Uri.parse("$baseURL/api/auth/me"), headers: headers);
    UserModel? u;

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      u = userModelFromJson(json.encode(result['data']));
      print(u.fullName);
    }
    return u;
  }

  static Future<void> logOut() async {
    var client = http.Client();
    String? token = await storage.read(key: 'Token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token!}'
    };
    var response = await client.post(Uri.parse("$baseURL/api/driver/logout"),
        headers: headers);
    storage.delete(key: 'Token');
    if (response.statusCode == 200) {
    } else {}
  }

  static Future<void> updateLocation(lat, long) async {
    var client = http.Client();
    String? token = await storage.read(key: 'Token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": 'Bearer ${token!}'
    };
    var response = await client.post(
      Uri.parse("$baseURL/api/driver/upLoc"),
      headers: headers,
      body: json.encode({
        'lat': lat,
        'long': long,
      }),
    );
  }
}