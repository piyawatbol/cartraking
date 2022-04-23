// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_brace_in_string_interps, unused_element
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:cartrackingapp/screen/map_screen/driver_map.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../ipconnect.dart';

class SelectCar extends StatefulWidget {
  SelectCar({Key? key}) : super(key: key);

  @override
  State<SelectCar> createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  List dataList = [];
  String? car_id;
  String? user_id;

  Future get_user_id() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('user_id');
    });
    // print('user_id : ${user_id}');
  }

  Future select_car_driver(car_id) async {
    get_user_id();
    var url = Uri.parse(
        'http://${ipconnect}/cartraking/get_car/select_car_driver.php');
    var response = await http.post(url, body: {
      "car_id": car_id.toString(),
      "user_id": user_id.toString(),
    });
    var data = json.decode(response.body);
    print(data.toString());
  }

  Future get_car() async {
    final response = await http
        .get(Uri.parse("http://$ipconnect/cartraking/get_car/get_car.php"));
    var data = json.decode(response.body);

    setState(() {
      dataList = data;
    });
    print("car : ${dataList}");
  }

  @override
  void initState() {
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
              Container(
                height: 400,
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        select_car_driver(car_id = dataList[index]['car_id']);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return DriverMap(
                            car_id: car_id,  
                            user_id: user_id,                   
                          );
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
                                width: 85,
                              ),
                              Text(
                                  "คันที่ ${dataList[index]['car_id']} ${dataList[index]['car_name']}",
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
              ),
              SizedBox(
                height: 20,
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
      ]),
    );
  }
}
