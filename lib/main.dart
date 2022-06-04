// ignore_for_file: non_constant_identifier_names

import 'package:cartrackingapp/screen/login_screen/start_screen.dart';
import 'package:cartrackingapp/screen/select_car_screen/select_car.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String user_id = "";
  Future get_user_id() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString("user_id") == null) {
      preferences.setString("user_id", "");
    } else {
      setState(() {
        user_id = preferences.getString('user_id')!;
      }); 
    }
  }

  @override
  void initState() {
    get_user_id();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: user_id == "" ? StartScreen() : SelectCar(),
    );
  }
}
