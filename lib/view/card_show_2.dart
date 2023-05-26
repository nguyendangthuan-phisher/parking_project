import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parking_project/service/authentication_service.dart';
import 'package:parking_project/service/card_service.dart';
import 'package:parking_project/view/qr_dialog.dart';

import '../models/month_card_model.dart';
import '../models/user_model.dart';
import 'card_register.dart';
import 'loading_dialog.dart';

class CardListShow2 extends StatefulWidget {
  String? userName;
  CardListShow2({this.userName});

  @override
  State<CardListShow2> createState() => _CardListShow2State();
}

class _CardListShow2State extends State<CardListShow2> {
  late Future<List<CardModel>> list;
  Color clr = Color.fromRGBO(31, 192, 176, 1);
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
  UserModel user = new UserModel(id: 0, fullName: "INVALID FULLNAME", email: "MAIL", dob: '2001-01-01', gender: true, phone: '0123456789', createdUser: DateTime.parse('2001-01-01'));

  @override
  void initState() {
    // TODO: implement initState
    list = CardService.getList();
    AuthenticatorServices.getInfomation().then((value) {
      user = value!;
      setState(() {

      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: list,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 250,
                          child:
                          Image.asset("assets/image/credit_card.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              children: [
                                Text(
                                  "MONTHLY CARD",
                                  style: TextStyle(
                                    color: Color.alphaBlend(
                                        Colors.grey, Colors.white),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 110,
                                ),
                                Text(
                                  "Pos:  ",
                                  style: TextStyle(
                                    color: Color.alphaBlend(
                                        Colors.grey, Colors.white),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${data[index].postion.positionName}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 230),
                              child: TextButton(
                                  onPressed: () async {
                                    FlutterSecureStorage storage =
                                    const FlutterSecureStorage();

                                    String? token =
                                    await storage.read(key: 'Token');
                                    showDialog(
                                        context: context,
                                        builder: (c) {
                                          return QRCodeDialog(
                                              Title: 'QR Code đỗ xe',
                                              Message:
                                              'Đưa mã QR này cho nhân viên bãi đỗ xe khi muốn check in/out',
                                              Content: token! +
                                                  ";" +
                                                  "${data[index].cardId}");
                                        });
                                  },
                                  child: Icon(
                                    Icons.qr_code_2_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              cardNumFormat("${data[index].cardId}"),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${user.fullName.toUpperCase()}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Exp:  ",
                                  style: TextStyle(
                                    color: Color.alphaBlend(
                                        Colors.grey, Colors.white),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  cardDateFormat("${data[index].endDate}"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                // TextButton(
                                //   onPressed: () {},
                                //   child: Container(
                                //     height: 20,
                                //     width: 70,
                                //     decoration: BoxDecoration(
                                //       borderRadius:
                                //       BorderRadius.circular(20),
                                //       color: Colors.grey,
                                //     ),
                                //     child: Center(
                                //       child: Text(
                                //         "Gia hạn",
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: 10,
                                //             fontWeight: FontWeight.bold),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                });
          } else
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20,),
                    Text("Đang tải tất cả thẻ tháng, vui lòng chờ"),
                  ],
                ));
        });
  }
}
