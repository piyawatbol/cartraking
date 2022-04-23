// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_print, non_constant_identifier_names, unused_element, unnecessary_brace_in_string_interps, unused_local_variable, prefer_void_to_null
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';

import 'package:cartrackingapp/screen/login_screen/login_screen.dart';
import 'package:cartrackingapp/screen/profile_screen/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../ipconnect.dart';

class ProFileScreen extends StatefulWidget {
  ProFileScreen({Key? key}) : super(key: key);

  @override
  State<ProFileScreen> createState() => _ProFileScreenState();
}

class _ProFileScreenState extends State<ProFileScreen> {
  String? user_id;
  List dataList = [];
  String? name;
  String? phone;
  String? email;
  final img = 'assets/images/profile.jpg';
  Future get_user_id() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('user_id');
    });
    print(user_id);
    get_data_user();
  }
  Future get_data_user() async {
    final response = await http.get(Uri.parse(
        "http://$ipconnect/cartraking/login/get_data_user.php?user_id=$user_id"));
    var data = json.decode(response.body);

    setState(() {
      dataList = data;
    });
    name = dataList[0]['name'];
    phone = dataList[0]['phone'];
    email = dataList[0]['email'];
  }
  Future<Null> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
  @override
  void initState() {
    get_user_id();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          Positioned(
            left: 20,
            top: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1,
                    offset: Offset(3, 3), // Shadow position
                  ),
                ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 790,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 110,
                  ),
                  Text(
                    "โปรไฟล์",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 510,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage(img),
                          ),
                        ),
                        Text(
                          'ชื่อ',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          name.toString(),
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                          )),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "เบอร์โทร",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          phone.toString(),
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                          )),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "อีเมล",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          email.toString(),
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                          )),
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return EditProfile(
                                user_id: user_id,
                              );
                            }));
                          },
                          child: Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 12, 72, 141),
                                borderRadius: BorderRadius.circular(14)),
                            child: Center(
                                child: Text(
                              "แก้ไข",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      logout();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return LoginScreen();
                      }));
                    },
                    child: Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 12, 72, 141),
                          borderRadius: BorderRadius.circular(14)),
                      child: Center(
                          child: Text(
                        "ออกจากระบบ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
