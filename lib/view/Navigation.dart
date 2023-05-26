import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking_project/view/card_list_page.dart';
import 'package:parking_project/view/card_register.dart';
import 'package:parking_project/view/parking%20detail.dart';
import 'package:parking_project/view/profile.dart';

import 'card_page.dart';
import 'login_page.dart';

class Navigation extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  Color clr = Color.fromRGBO(31, 192, 176, 1);
  int inbox = 5;
  String inboxText(){
    return " [ "+ inbox.toString() +" ]";
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: clr,
        child: ListView(
          children: <Widget>[
            buildHeader(context),
            Divider(color: Colors.white70,endIndent: 20,indent: 20,),
            buildMenuItem(
              text: "Home",
              icon: Icons.home,
              onClicked: () => selectedItem(context, 9),
            ),
            buildMenuItem(
              text: "Thông tin tài khoản",
              icon: Icons.person,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: "Xem thông tin xe",
              icon: Icons.car_crash,
              onClicked: () => selectedItem(context, 1),
            ),
            buildMenuItem(
              text: "Đăng ký vé tháng",
              icon: Icons.credit_card,
              onClicked: () => selectedItem(context, 2),
            ),
            buildMenuItem(
              text: "Xem danh sách thẻ tháng",
              icon: Icons.add_card,
              onClicked: () => selectedItem(context, 10),
            ),
            buildMenuItem(
                text: "Đăng xuất",
                icon: Icons.logout,
                onClicked: () => selectedItem(context, 6)
            ),
            const SizedBox( height: 8,),
            Divider(color: Colors.white70,endIndent: 20,indent: 20,),
            const SizedBox( height: 8,),
            buildMenuItem(
                text: "Cài đặt",
                icon: Icons.settings,
                onClicked: () => selectedItem(context, 7)
            ),
            buildMenuItem(
                text: "About us",
                icon: Icons.info,
                onClicked: () => selectedItem(context, 8)
            ),
          ],
        ),
      ),
    );
  }
}
Widget buildMenuItem( {
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
})
{
  return ListTile(
    minVerticalPadding: 10,
    hoverColor: Color.fromRGBO(0, 0, 0, 0.4),
    leading: Icon(icon,color: Colors.white,),
    title: Text(text,style:
    TextStyle(
        fontSize: 15,
        color: Colors.white
    ),),
    onTap: onClicked,
  );
}
void selectedItem(BuildContext context,int index) {
  switch (index) {
    case 0:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ));
        break;
      }
    case 1:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ParkingDetail(),
        ));
        break;
      }
    case 2:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CardRegisterPage(),
        ));
        break;
      }
    // case 3:
    //   {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => Message(),
        // ));
        // break;
    //   }
    // case 4:
    //   {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => LoginPage(),
        // ));
        // break;
    //   }
    // case 5:
    //   {
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => Settings(),
      //   ));
      //  break;
      // }
    case 6:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
        break;
      }
    // case 7:
    //   {
    //     Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => AboutUs(),
    //     ));
    //     break;
    //   }
    // case 8:
    //   {
    //     Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => LoginPage(),
    //     ));
    //     break;
    //   }
    case 9:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MonthlyCardPage(),
        ));
        break;
      }
    case 10:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CardListPage(),
        ));
        break;
      }
  }
}
Widget buildHeader(BuildContext context) => Material(
    color: Color.fromRGBO(31, 192, 176, 1),
    child: InkWell(
      hoverColor: Color.fromRGBO(0, 0, 0, 0.2),
      onTap: (){
        //close navigation
        Navigator.pop(context);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MonthlyCardPage()
        )
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 12 + MediaQuery.of (context) .padding. top,
          bottom: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg'),
            ),
            SizedBox(
              height: 24,
            ),
            Text("Nguyễn Đăng Thuận",style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("ndthuan.husc@gmail.com",style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    )
);
