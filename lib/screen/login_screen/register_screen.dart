// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, unused_import, avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps, unused_local_variable
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:cartrackingapp/ipconnect.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'success_screen.dart';
class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final inputstyle = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 35),
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        width: 3,
        color: Colors.white,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        color: Colors.red,
        width: 3,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        width: 3,
        color: Colors.red,
      ),
    ),
  );
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController user_name = TextEditingController();
  TextEditingController pass_word = TextEditingController();
  Future register() async {
    var url = Uri.parse('http://${ipconnect}/cartraking/login/register.php');
    var response = await http.post(url, body: {
      "name": name.text,
      "phone": phone.text,
      "email": email.text,
      "user_name": user_name.text,
      "pass_word": pass_word.text,
    });
    var data = json.decode(response.body);
    print(data.toString());
    if (data == 'duplicate_username') {
      Fluttertoast.showToast(
          msg: "ชื่อผู้ใช้นี้ได้ถูกใช้ไปแล้ว",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (data == 'duplicate_email') {
      Fluttertoast.showToast(
          msg: "email นี้ถูกใช้ไปแล้ว",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (data == 'succes') {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return SuccessScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.purple.shade700,
                Colors.pink.shade200,
                Colors.yellow.shade200
              ])),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: SafeArea(
              child: Container(
                width: double.infinity,
                height: 780,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "สร้างบัญชีผู้ใช้",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "ชื่อ",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                            TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ('กรุณากรอกชื่อผู้ใช้งาน');
                                  }
                                  return null;
                                },
                                controller: name,
                                decoration: inputstyle),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "เบอร์โทรศัพท์มือถือ",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                            TextFormField(
                                controller: phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ('กรุณากรอกเบอร์โทรศัพมือถือ');
                                  }
                                  return null;
                                },
                                decoration: inputstyle),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "อีเมล",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                            TextFormField(
                                controller: email,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ('กรุณากรอกอีเมล');
                                  }
                                  return null;
                                },
                                decoration: inputstyle),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "ชื่อผู้ใช้งาน",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                            TextFormField(
                                controller: user_name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ('กรุณากรอกชื่อผู้ใช้');
                                  }
                                  return null;
                                },
                                decoration: inputstyle),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "รหัสผ่าน",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                            TextFormField(
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ('กรุณากรอกรหัสผ่าน');
                                  }
                                  if (value.length <= 5) {
                                    return ('กรุณาใส่รหัสผ่าน 6 ตัวขึ้นไป');
                                  }
                                  return null;
                                },
                                controller: pass_word,
                                decoration: inputstyle),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        )),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // print(name.text);
                            // print(phone.text);
                            // print(email.text);
                            // print(user_name.text);
                            // print(pass_word.text);
                            final isValid = formKey.currentState!.validate();
                            if (isValid) {
                              register();
                            }
                            // register();
                          },
                          child: Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 2,
                                    offset: Offset(3, 5), // Shadow position
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.orange.shade400,
                                      Colors.pink.shade400
                                    ])),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 35, top: 5),
                              child: Text("ตกลง",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 3,
                                    offset: Offset(2, 5), // Shadow position
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      Colors.white60,
                                      Colors.black12
                                    ])),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 21, top: 5),
                              child: Text("ย้อนกลับ",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
