import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parking_project/models/month_card_model.dart';
import 'package:parking_project/models/user_model.dart';
import 'package:parking_project/service/authentication_service.dart';
import 'package:parking_project/service/card_service.dart';
import 'package:parking_project/view/Navigation.dart';
import 'package:parking_project/view/card_register.dart';
import 'package:parking_project/view/card_show_2.dart';
import 'package:parking_project/view/qr_dialog.dart';

class CardListPage extends StatefulWidget {
  const CardListPage({Key? key}) : super(key: key);

  @override
  State<CardListPage> createState() => _MonthlyCardPageState();
}

class _MonthlyCardPageState extends State<CardListPage> {
  Color clr = Color.fromRGBO(31, 192, 176, 1);
  Color blur = Color.fromRGBO(241, 242, 245, 1);
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String cardNumFormat(str)
  {
    return str[0]+str[1]+str[2]+str[3]+" "
        +str[4]+str[5]+str[6]+str[7]+" "
        +str[8]+str[9]+str[10]+str[11]+" "
        +str[12]+str[13]+str[14]+str[15]+" ";
  }
  String cardDateFormat(str)
  {
    String ans = "";
    for(int i=0;i<10;i++)
      ans+=str[i];
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
      body: CardListShow2(),
    );
  }
}
