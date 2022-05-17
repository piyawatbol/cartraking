// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_brace_in_string_interps, unused_element, unused_local_variable, prefer_void_to_null
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:cartrackingapp/screen/map_screen/customer_map.dart';
import 'package:cartrackingapp/screen/map_screen/driver_map.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../ipconnect.dart';
import '../login_screen/login_screen.dart';

class SelectCar extends StatefulWidget {
  SelectCar({Key? key}) : super(key: key);

  @override
  State<SelectCar> createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  List carList = [];
  List userList = [];
  String? car_id;
  String? user_id;

  Future get_user_id() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('user_id');
    });
    get_data_user();
  }

  Future get_data_user() async {
    final response = await http
        .get(Uri.parse("$ipconnect/login/get_data_user.php?user_id=$user_id"));
    var data = json.decode(response.body);
    setState(() {
      userList = data;
    });
   // print('user ${userList}');
  }

  Future get_car() async {
    final response =
        await http.get(Uri.parse("$ipconnect/get_car/get_car.php"));
    var data = json.decode(response.body);

    setState(() {
      carList = data;
    });
  //  print("car : ${carList}");
  }

  Future<Null> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return LoginScreen();
    }));
  }

  @override
  void initState() {
    get_user_id();
    get_car();
    super.initState();
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
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              SizedBox(
                height: 140,
              ),
              Text(
                "รถ",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 25, color: Colors.white)),
              ),
              SizedBox(
                height: 30,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: carList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return userList[0]['status'] == 'driver'
                            ? DriverMap(car_id: carList[index]['car_id'])
                            : CustomerMap(car_id: carList[index]['car_id']);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
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
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120,
                            ),
                            Text("คันที่ ${carList[index]['car_id']} ",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ))),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  logout();
                },
                child: Container(
                  width: 150,
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
                    child: Text("ออกจากระบบ",
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
