// ignore_for_file: prefer_const_constructors_in_immutables, avoid_unnecessary_containers
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cartrackingapp/screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final textstyle1 = GoogleFonts.bebasNeue(
      textStyle: TextStyle(fontSize: 100, color: Colors.yellow));
  final textstyle2 = GoogleFonts.bebasNeue(
      textStyle: TextStyle(fontSize: 100, color: Colors.white));
  final left = 50;
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
        Positioned(
            left: 230,
            top: 140,
            child: Image.asset(
              'assets/images/location.png',
            )),
        Positioned(
          top: 120,
          left: double.parse(left.toString()),
          child: Text("BSRU", style: textstyle1),
        ),
        Positioned(
          top: 190,
          left: double.parse(left.toString()),
          child: Text(
            'CAR',
            style: textstyle2,
          ),
        ),
        Positioned(
          top: 260,
          left: double.parse(left.toString()),
          child: Text(
            'TRACKING',
            style: textstyle2,
          ),
        ),
        Positioned(
          top: 330,
          left: double.parse(left.toString()),
          child: Text(
            'SYSTEM',
            style: textstyle2,
          ),
        ),
        Positioned(
          top: 620,
          left: 101,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return LoginScreen();
              }));
            },
            child: Container(
              width: 200,
              height: 60,
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
                      colors: [Colors.orange.shade400, Colors.pink.shade400])),
              child: Center(
                  child: Text("เข้าสู่ระบบ",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      )))),
            ),
          ),
        )
      ]),
    );
  }
}
