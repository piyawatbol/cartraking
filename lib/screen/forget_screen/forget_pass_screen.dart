// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cartrackingapp/screen/forget_screen/forget_email.dart';
import 'package:cartrackingapp/screen/forget_screen/forget_phone.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassScreen extends StatefulWidget {
  ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    "ลืมรหัสผ่าน",
                    style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(fontSize: 25, color: Colors.white)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ForgetPhone();
                      }));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 35,
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
                                Colors.orange.shade400,
                                Colors.pink.shade400
                              ])),
                      child: Center(
                          child: Text("เบอร์โทรศัพท์มือถือ",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ForgetEmail();
                      }));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 35,
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
                                Colors.orange.shade400,
                                Colors.pink.shade400
                              ])),
                      child: Center(
                          child: Text("อีเมล",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )))),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 110,
                      height: 33,
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
                              fontSize: 18,
                              color: Colors.white,
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
