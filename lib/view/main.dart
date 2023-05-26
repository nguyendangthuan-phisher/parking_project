import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parking_project/service/authentication_service.dart';
import 'package:parking_project/view/card_page.dart';
import 'package:parking_project/view/card_register.dart';
import '../service/card_service.dart';
import 'login_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      home: LoginPage()
  ));
  //  FlutterSecureStorage storage = const FlutterSecureStorage();
  //
  // String? token = await storage.read(key: 'Token');
  // print(token);
  // var card = await CardService.getList();
  // print("size: "+ card.length.toString());
  // String? msg = await AuthenticatorServices.registerService("N D Thuan", "thuantest@gmail.com", "0123456789", "Thuan7", 1, "2001-09-30");
  // print(msg);
}
