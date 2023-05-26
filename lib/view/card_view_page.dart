import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parking_project/models/month_card_model.dart';
import 'package:parking_project/models/user_model.dart';
import 'package:parking_project/service/authentication_service.dart';
import 'package:parking_project/service/card_service.dart';
import 'package:parking_project/view/Navigation.dart';
import 'package:parking_project/view/card_register.dart';
import 'package:parking_project/view/card_show.dart';
import 'package:parking_project/view/qr_dialog.dart';

class MonthlyCardPage extends StatefulWidget {
  const MonthlyCardPage({Key? key}) : super(key: key);

  @override
  State<MonthlyCardPage> createState() => _MonthlyCardPageState();
}

class _MonthlyCardPageState extends State<MonthlyCardPage> {
  Color clr = Color.fromRGBO(31, 192, 176, 1);
  Color blur = Color.fromRGBO(241, 242, 245, 1);
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String cardNumFormat(str) {
    return str[0] +
        str[1] +
        str[2] +
        str[3] +
        " " +
        str[4] +
        str[5] +
        str[6] +
        str[7] +
        " " +
        str[8] +
        str[9] +
        str[10] +
        str[11] +
        " " +
        str[12] +
        str[13] +
        str[14] +
        str[15] +
        " ";
  }

  String cardDateFormat(str) {
    String ans = "";
    for (int i = 0; i < 10; i++) ans += str[i];
    return ans;
  }

  UserModel user = new UserModel(
      id: 0,
      fullName: "INVALID FULLNAME",
      email: "MAIL",
      dob: '2001-01-01',
      gender: true,
      phone: '0123456789',
      createdUser: DateTime.parse('2001-01-01'));
  List<CardModel> cardList = [];
  @override
  void initState() {
    AuthenticatorServices.getInfomation().then((value) {
      user = value!;

      setState(() {});
    });
    CardService.getList().then((valueCard) {
      cardList = valueCard!;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blur,
        drawer: Navigation(),
        appBar: AppBar(
          backgroundColor: clr,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Parking Project - Card"),
            ],
          ),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${user.fullName}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
// nút đăng ký thêm
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardRegisterPage()));
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: clr,
                    ),
                    child: Center(
                      child: Text(
                        "Đăng ký thêm",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
