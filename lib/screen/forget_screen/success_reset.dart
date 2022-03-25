// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_unnecessary_containers
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login_screen/login_screen.dart';

class SuccessReset extends StatefulWidget {
  SuccessReset({Key? key}) : super(key: key);

  @override
  State<SuccessReset> createState() => _SuccessResetState();
}

class _SuccessResetState extends State<SuccessReset> {
  final urlImg = 'assets/images/correct.jpg';
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
            child: Container(
                child: Column(
              children: [
                SizedBox(
                  height: 170,
                ),
                CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage(urlImg),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "ดำเดินการเรียบร้อย",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 120,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return LoginScreen();
                    }));
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
              ],
            )),
          ),
        ],
      ),
    );
  }
}
