import 'package:flutter/material.dart';
import 'package:parking_project/view/login_page.dart';
import 'package:parking_project/view/success_dialog.dart';

import '../service/authentication_service.dart';
import 'card_page.dart';
import 'error_dialog.dart';
import 'loading_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var phoneController = new TextEditingController();
  var emailController =new  TextEditingController();
  var birthdayController = new TextEditingController();
  var fullNameController =  new TextEditingController();
  var passWordController = new  TextEditingController();
  var rePassWordController = new TextEditingController();
  final _genderList = ["Nam", "Nữ"];
  String _value = "Nam";
  var _formKey = GlobalKey<FormState>();
  String? p1,p2;
  String src = 'assets/image/logo2.png';
  Color clrsrc =  Color.fromRGBO(31, 192, 176, 1);
  @override
  Widget build(BuildContext context) {
    double maxWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrsrc,
        title:
        Text("Đăng ký tài khoản"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(src,width: 260,),
              //input email
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text("Địa chỉ Email",style:
                      TextStyle(
                          color: clrsrc,
                          fontSize: 14
                      ),
                      ),
                      hintText: "Nhập địa chỉ Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.alternate_email)
                  ),
                  validator: (email){
                    if( email == null || email.isEmpty)
                      return "Địa chỉ email không được rỗng";
                    else
                    {
                      if(!email.contains("@"))
                        return "Email chưa có @";
                      if(email.contains(" "))
                        return "Email chứa khoảng trắng";
                    }
                    return null;
                  },
                ),
              ),
              //input phoneNumber
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text("Số điện thoại",style:
                      TextStyle(
                          color: clrsrc,
                          fontSize: 14
                      ),
                      ),
                      hintText: "Nhập số điện thoại",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.call)
                  ),
                  validator: (Phonestr){
                    if( Phonestr == null || Phonestr.isEmpty)
                      return "Số điện thoại không được rỗng";
                    else
                    {
                      if(Phonestr.length!=10)
                        return "Số điện thoại phải có 10 chữ số";
                    }
                    return null;
                  },
                ),
              ),
              //input fullName
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text("Họ và tên",style:
                      TextStyle(
                          color: clrsrc,
                          fontSize: 14
                      ),
                      ),
                      hintText: "Vui lòng nhập họ và tên",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.person)
                  ),
                  validator: (str){
                    if( str == null || str.isEmpty)
                      return "Họ và tên không được rỗng";
                    return null;
                  },
                ),
              ),
              // input birthday
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: birthdayController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(
                        "Ngày sinh",
                        style: TextStyle(color: clrsrc, fontSize: 14),
                      ),
                      hintText: "2001-12-31",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.date_range)),
                  validator: (str) {
                    if (str == null || str.isEmpty)
                      return "Ngày sinh không được bỏ trống";
                    return null;
                  },
                ),
              ),
              //input gender
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Giới tính:  ",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: maxWidth-130,
                    child: DropdownButton<String>(
                      items: _genderList.map(buildMenuItem).toList(),
                      value: _value,
                      onChanged: (valueBank) => setState(() {
                        this._value = valueBank!;
                      }),
                    ),
                  ),
                ],
              ),
              //input passWord
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: passWordController,
                  obscureText: true,
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
                  validator: (passWord){
                    // lưu lại để kiểm tra nhập lại mật khẩu
                    p1=passWord;
                    if( passWord == null || passWord.isEmpty)
                      return "Mật khẩu rỗng";
                    return null;
                  },
                ),
              ),
              //input rePassWord
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: rePassWordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text("Nhập lại mật khẩu",style:
                      TextStyle(
                          color: clrsrc,
                          fontSize: 14
                      ),
                      ),
                      hintText: "Vui lòng lại nhập mật khẩu",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.key)
                  ),
                  validator: (rePassword){
                    p2=rePassword;
                    if( rePassword == null || rePassword.isEmpty)
                      return "Mật khẩu nhập lại rỗng";
                    else if(p2!=p1)
                      return "Mật khẩu không khớp";
                    else
                      return null;
                  },
                ),
              ),
              // nút đăng ký
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
                        var fullname = fullNameController.text;
                        var password = passWordController.text;
                        var email = emailController.text;
                        var birthday = birthdayController.text;
                        var gender = _value;
                        var phone = phoneController.text;


                        String? msg = await AuthenticatorServices
                            .registerService(
                            fullname, email, phone, password, gender, birthday);
                        // var position = await PositionService.getList();
                        if(msg==null)
                          {
                            print("Đăng ký thành công");

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => LoginPage()));
                            showDialog(
                                context: context,
                                builder: (c){
                                  return SuccessDialog(Title: 'Đăng ký thành công', Message: 'Chuyển đến giao diện đăng nhập');
                                }
                            );
                          }
                        else
                          showDialog(
                              context: context,
                              builder: (c){
                                return ErrorDialog(Title: 'Đăng ký thất bại',Message: 'Đã tồn tại Email hoặc nhập sai thông tin');
                              }
                          );
                          print("lỗi");

                      }
                    },
                    child: Container(
                      width: maxWidth,
                      height: 50,
                      child: Center(
                        child: Text("Đăng ký tài khoản",style:
                        TextStyle(
                            fontSize: 16
                        ),),
                      ),
                    )
                ),
              ),
              //nút tiến tới
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // cách vào nút quay lại 1 khoảng trống
                  SizedBox(width: 20,),
                  Text("Đã có tài khoản?,",style:
                  TextStyle(
                      color: Colors.grey
                  ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text("Đăng nhập",style:
                      TextStyle(
                          color: clrsrc
                      ),)
                  ),
                ],
              ),
              SizedBox(height: 200,),
            ],
          ),
        ),
      ),
    );
  }
}


DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
  value: item,
  child: Text(
    item,
    style: TextStyle( fontSize: 18),
  ),
);
