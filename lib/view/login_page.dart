import 'package:flutter/material.dart';
import 'package:parking_project/service/card_service.dart';
import 'package:parking_project/service/position_service.dart';
import 'package:parking_project/view/card_page.dart';
import 'package:parking_project/service/authentication_service.dart';
import 'package:parking_project/view/register_page.dart';

import 'error_dialog.dart';
import 'loading_dialog.dart';

// https://fakestoreapi.com/products


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userNameControler = TextEditingController();
  var passWordControler = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  String src = 'assets/image/logo2.png';
  Color clrsrc = Color.fromRGBO(31, 192, 176, 1);
  @override
  Widget build(BuildContext context) {
    double maxWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrsrc,
        automaticallyImplyLeading: false,
        title:
        Text("Đăng nhập hệ thống"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 40,),
                Image.asset(src,width: 230,),
                SizedBox(height: 40,),
                //input userName
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userNameControler,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text("Tên đăng nhập",style:
                        TextStyle(
                            color: clrsrc,
                            fontSize: 14
                        ),
                        ),
                        hintText: "Vui lòng nhập tên đăng nhập",
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: Icon(Icons.person)
                    ),
                    validator: (str){
                      if( str == null || str.isEmpty)
                        return "Tên đăng nhập không được rỗng";
                      else if(str.contains(" "))
                        return "Không thể chứa ký tự khoảng trắng";
                      return null;
                    },
                  ),
                ),
                //input passWord
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passWordControler,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text("Mật khẩu",style:
                        TextStyle(
                            color: clrsrc,
                            fontSize: 14
                        ),
                        ),
                        hintText: "Vui lòng nhập mật khẩu",
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: Icon(Icons.key)
                    ),
                    validator: (password){
                      if( password == null || password.isEmpty)
                        return "Mật khẩu rỗng";
                      return null;
                    },
                  ),
                ),
                // nút đăng nhập
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(clrsrc),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                  side: BorderSide(color: clrsrc)
                              )
                          )
                      ),
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                          var username = userNameControler.text;
                          var password = passWordControler.text;
                          showDialog(
                              context: context,
                              builder: (c){
                                return LoadingDialogWidget();
                              }
                          );
                          var user = await AuthenticatorServices.loginServices(username, password);
                          // var position = await PositionService.getList();

                          Navigator.pop(context);
                          if(user != null){
                            setState(() {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MonthlyCardPage()));
                            });
                          }else{
                            showDialog(
                                context: context,
                                builder: (c){
                                  return ErrorDialog(Title: 'Lỗi đăng nhập',Message: 'Vui lòng kiểm tra lại tên đăng nhập hoặc mật khẩu!');
                                }
                            );
                          }
                        } else {
                        }
                      },
                      child: Container(
                        width: maxWidth,
                        height: 50,
                        child: Center(
                          child: Text("Đăng nhập",style:
                          TextStyle(
                              fontSize: 16
                          ),),
                        ),
                      )
                  ),
                ),
                //nút quay lại
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // cách vào nút quay lại 1 khoảng trống
                    SizedBox(width: 20,),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RegisterPage()));
                        },
                        child: Text("Đăng ký",style:
                        TextStyle(
                            color: clrsrc
                        ),)
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

