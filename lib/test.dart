// ignore_for_file: prefer_const_constructors_in_immutables, sized_box_for_whitespace, prefer_const_constructors, non_constant_identifier_names, must_be_immutable, unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'ipconnect.dart';

class Test extends StatefulWidget {
  String? user_id;
  String? car_id;
  Test({Key? key, required this.user_id, required this.car_id})
      : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Future select_car_driver() async {
    var url = Uri.parse(
        'http://${ipconnect}/cartraking/get_car/select_car_driver.php');
    var response = await http.post(url, body: {
      "car_id": widget.car_id.toString(),
      "user_id": widget.user_id.toString(),
    });
    var data = json.decode(response.body);
    print(data.toString());
  }

  @override
  void initState() {
    select_car_driver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.user_id.toString()),
            Text(widget.car_id.toString())
          ],
        ),
      ),
    );
  }
}
