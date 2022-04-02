// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'reset_pass.dart';

class ForgetPhone extends StatefulWidget {
  ForgetPhone({Key? key}) : super(key: key);

  @override
  State<ForgetPhone> createState() => _ForgetPhoneState();
}

class _ForgetPhoneState extends State<ForgetPhone> {
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
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Text(
                  "ยืนยันตัวตนผ่านเบอร์โทรศัพท์มือถือ",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "เบอร์โทรศัพท์มือถือ",
                          style: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                      TextFormField(decoration: inputstyle),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "รหัสยืนยันตัวตน",
                          style: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                      TextFormField(decoration: inputstyle),
                    ],
                  )),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ResetPass();
                    }));
                  },
                  child: Container(
                    width: 110,
                    height: 33,
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
                      padding: const EdgeInsets.only(left: 30, top: 1),
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
                  height: 20,
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
        ],
      ),
    );
  }
}
