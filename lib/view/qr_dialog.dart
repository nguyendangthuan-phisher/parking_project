


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDialog extends StatelessWidget{
  String? Message = "";
  String? Title = "";
  String? Content = "";

  QRCodeDialog({ this.Title, this.Message, this.Content});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    var errorIcon = 'assets/icon/success_icon.png';

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 300,
              height: 300,
              child: QrImage(
                data: Content!,
                size: 300,
              )
          ),
          Text(Title == null ? "" : Title! ,style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
          SizedBox(height: 10,),
          Center(
            child: Text(Message == null ? "" : Message! ,style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll<Color>(Colors.green),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green)))),
              child: Text('Đóng')
          )

        ],
      ),
    );
  }

}