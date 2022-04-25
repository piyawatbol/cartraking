// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_void_to_null
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'select_car.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<Null> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Text(
                "เมนู",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 25, color: Colors.white)),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SelectCar();
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
                      child: Text("คนขับรถ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: () {
                 
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
                        child: Text("ผู้โดยสาร",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )))),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  logout();
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
      ]),
    );
  }
}
