import 'package:flutter/material.dart';
import 'package:parking_project/service/card_service.dart';
import 'package:parking_project/service/position_service.dart';
import 'package:parking_project/view/Navigation.dart';
import 'package:parking_project/view/card_page.dart';

import '../models/position_model.dart';

// https://fakestoreapi.com/products

class CardRegisterPage extends StatefulWidget {
  const CardRegisterPage({Key? key}) : super(key: key);

  @override
  State<CardRegisterPage> createState() => _CardRegisterPageState();
}

class _CardRegisterPageState extends State<CardRegisterPage> {
  bool checkBKS(String str) {
    str = str.trim();
    RegExp regex = RegExp(r'^\d');
    return !regex.hasMatch(str[0]) &&
        !regex.hasMatch(str[1]) &&
        regex.hasMatch(str[2]) &&
        !regex.hasMatch(str[3]) &&
        !regex.hasMatch(str[4]) &&
        !regex.hasMatch(str[5]) &&
        !regex.hasMatch(str[6]) &&
        str[3] != '-';
  }

  final _floorList = ["1", "2", "3", "4", "5", "6", "7", "8"];
  String _value = "1",_valueBank = "Vietinbank";
  var bankNumberControler = TextEditingController();
  final _bankList = ["Vietinbank", "Sacombank","Vietcombank","Agribank","BIDV","DongA Bank","ACB","VietA Bank"];
  int _currentStep = 0;
  String? selectedID, selectedName;
  int curStep = 0;
  var numberPlatesController,
      carNameController,
      carColorController,
      carDescriptionController = TextEditingController();
  late Future<List<PositionModel>> position;
  var _formKey = GlobalKey<FormState>();
  String src = 'assets/image/logo2.png';
  Color clrsrc = Color.fromRGBO(31, 192, 176, 1);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    position = PositionService.getList();
  }

  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrsrc,
        title: TextButton(
            onPressed: () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MonthlyCardPage()));
              });
            },
            child: Text(
              "Đăng ký vé tháng bãi gửi xe",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Stepper(
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: <Widget>[
                      Container(),
                    ],
                  ),
                );
              },
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: curStep,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  curStep > 0
                      ? TextButton(
                      onPressed: () {
                        setState(() {
                          curStep--;
                        });
                      },
                      child: Text("Trở lại",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)))
                      : TextButton(onPressed: null, child: Text("Trở lại")),
                  curStep < getSteps().length - 1
                      ? TextButton(
                      onPressed: () {
                        setState(() {
                          if(selectedID!=null){
                            curStep++;
                          }
                        });
                      },
                      child: Text("Tiếp tục",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),)
                  )
                      : TextButton(
                      onPressed: () {
                        var card = CardService.addCard(selectedID);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MonthlyCardPage()));
                      },
                      child: Text('Submit'))
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  List<Step> getSteps()=> [
    Step(
      isActive: curStep == 0,
      title: Text("Parking Position"),
      content: FutureBuilder(
          future: position,
          builder:
              (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.car_crash,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Vị trí hỏng",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.car_crash,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Vị trí đã đặt",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.car_crash,
                        size: 20,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Vị trí còn trống",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.car_crash,
                        size: 20,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Vị trí đang chọn",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),

                  GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      // return PositionView(
                      //   pos: data[index],
                      //   floor: _value,
                      // );
                      return data[index].positionName[1] == _value
                          ? (data[index].condition == "ACTIVE"
                          ? (data[index].status != "BOOKED"
                          ? TextButton(
                        onPressed: () {
                          setState(() {
                            selectedID =
                                data[index].positionId.toString();
                            selectedName = data[index].positionName.toString();
                          });
                        },
                        child: Column(
                          children: [
                            Icon(Icons.car_crash,
                                size: 70,
                                color: selectedID ==
                                    data[index]
                                        .positionId.toString()
                                    ? Colors.blue
                                    : Colors.green),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              data[index].positionName,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )
                          : Column(
                        children: [
                          Icon(Icons.car_crash,
                              size: 70,
                              color: Colors.black),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            data[index].positionName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ))
                          : Column(
                        children: [
                          Icon(Icons.car_crash,
                              size: 70, color: Colors.red),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            data[index].positionName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ))
                          : SizedBox(
                        height: 5,
                      );
                    },
                  ),
                  SizedBox(height: 300,),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    ),
    Step(
      isActive: curStep >= 1,
      title: Text("Payment"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Vị trí đỗ: " + selectedName.toString(), style: TextStyle(
            fontSize: 20,
          ),),
          SizedBox(height: 15,),
          Text("Số tiền: 1.500.000 VND", style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
          SizedBox(height: 15,),
          Row(
            children: [
              Text("Ngân hàng:  ", style: TextStyle(fontSize: 18),),
              DropdownButton<String>(
                items: _bankList.map(buildMenuItem).toList(),
                value: _valueBank,
                onChanged: (valueBank) => setState(() {
                  this._valueBank = valueBank!;
                }),
              ),
            ],
          ),
        ],
      ),
    ),
  ];
}



DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle( fontSize: 18),
      ),
    );
