import 'package:flutter/material.dart';
import 'package:parking_project/view/Navigation.dart';

import 'Navigation.dart';
import 'card_page.dart';

class ParkingDetail extends StatefulWidget {
  const ParkingDetail({Key? key}) : super(key: key);

  @override
  State<ParkingDetail> createState() => _ParkingDetailState();
}

class _ParkingDetailState extends State<ParkingDetail> {
  Color clr = Color.fromRGBO(31, 192, 176, 1);
  Color blur = Color.fromRGBO(241, 242, 245, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blur,
      drawer: Navigation(),
      appBar: AppBar(
        backgroundColor: clr,
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Car Parking Detail"),
          ],
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,right: 10),
                  child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MonthlyCardPage()));
                      },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: clr,
                      ),
                      child: Center(
                          child: Icon(Icons.close,color: Colors.white,)),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                  height: 400,
                  child: Image.asset("assets/image/car.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("B3 - 05",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 10),
              child: Text("Floor 3 - Block 05",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 10),
              child: Text("1.500.000 VND / month",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 10),
              child: Text("75A - 739.27",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 10),
              child: Text("Honda City",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Colors.white
                    ),
                    child: Center(
                      child: Text("Color: ",style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.grey
                    ),
                    child: Center(
                      child: Text("Silver",style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
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
