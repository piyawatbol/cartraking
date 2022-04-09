// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, unused_import, non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';

import 'package:cartrackingapp/screen/forget_screen/forget_pass_screen.dart';
import 'package:cartrackingapp/screen/login_screen/register_screen.dart';
import 'package:cartrackingapp/screen/login_screen/start_screen.dart';
import 'package:cartrackingapp/screen/menu_screen/menu_screnn.dart';
import 'package:cartrackingapp/screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../ipconnect.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //ตกแต่งขอบของตัว input
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
  TextEditingController user_name = TextEditingController();
  TextEditingController pass_word = TextEditingController();

  Future login() async {
    var url = Uri.parse('http://${ipconnect}/cartraking/login/login.php');
    var response = await http.post(url, body: {
      "user_name": user_name.text,
      "pass_word": pass_word.text,
    });
    var data = json.decode(response.body);
    if (data == "miss") {
      Fluttertoast.showToast(
          msg: "ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('user_id', data[0]['user_id']);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MenuScreen();
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
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Container(
              width: double.infinity,
              height: 700,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "เข้าสู่ระบบ",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text(
                              "ชื่อผู้ใช้",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                          ),
                          TextFormField(
                            controller: user_name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('กรุณากรอกชื่อผู้ใช้งาน');
                              }
                              return null;
                            },
                            decoration: inputstyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "รหัสผ่าน",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                          ),
                          TextFormField(
                              obscureText: true,
                              controller: pass_word,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ('กรุณากรอกรหัสผ่าน');
                                }
                                return null;
                              },
                              decoration: inputstyle),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return ForgetPassScreen();
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "ลืมรหัสผ่าน",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      )),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final isValid = formKey.currentState!.validate();
                          if (isValid) {
                            print(user_name.text);
                            print(pass_word.text);
                            login();
                          }
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
                          //  Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return StartScreen();
                          }));
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return RegisterScreen();
                          }));
                        },
                        child: Text(
                          "สร้างบัญชีผู้ใช้งาน",
                          style: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
