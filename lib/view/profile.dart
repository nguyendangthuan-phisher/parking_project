import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parking_project/view/Navigation.dart';

import '../models/user_model.dart';
import '../service/authentication_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color clr = Color.fromRGBO(31, 192, 176, 1);
  String src = 'assets/image/avatar.jpg';

  TextStyle styleTitle =TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(31, 192, 176, 1),
  );
  TextStyle style =TextStyle(
    fontSize: 16,
  );
  Padding inforItemTittle(String text){
    return Padding(
      padding: EdgeInsets.only(left: 16,top: 5,bottom: 5),
      child: Text(text,style: styleTitle,),
    );
  }
  Padding inforItemContent(String text){
    return Padding(
      padding: EdgeInsets.only(left: 16,top: 5,bottom: 5),
      child: Text(text,style: style,),
    );
  }
  FlutterSecureStorage storage = const FlutterSecureStorage();


  UserModel user = new UserModel(id: 0, fullName: "Nguyễn Đăng Thuận", email: "MAIL", dob: '2001-01-01', gender: true, phone: '0123456789', createdUser: DateTime.parse('2001-01-01'));
  @override
  void initState() {
    AuthenticatorServices.getInfomation().then((value) {
      user = value!;
      setState(() {

      });
    });
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation(),
      appBar: AppBar(
        backgroundColor: clr,
        centerTitle: true,
        title:
        Text("Thông tin người dùng"),
        titleTextStyle:
        TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Text("${user.fullName}",style: styleTitle,),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inforItemTittle("Tên đăng nhập: "),
                      inforItemTittle("Họ và tên: "),
                      inforItemTittle("Ngày sinh: "),
                      inforItemTittle("Giới tính: "),
                      inforItemTittle("Email: "),
                      inforItemTittle("Số điện thoại: "),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inforItemContent("${user.email}"),
                      inforItemContent("${user.fullName}"),
                      inforItemContent("${user.dob}"),
                      inforItemContent("${user.gender}"=="true"?"Nam":"Nữ"),
                      inforItemContent("${user.email}"),
                      inforItemContent("${user.phone}"),
                      // Text("19T1021266",style: style,),
                      // Text("Nguyễn Đăng Thuận",style: style,),
                      // Text("19/09/2001",style: style,),
                      // Text("Nam",style: style,),
                      // Text("ndthuan.husc@gmail.com",style: style,),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

