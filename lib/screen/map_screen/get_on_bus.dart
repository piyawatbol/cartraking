// ignore_for_file: prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_const_constructors, non_constant_identifier_names, must_be_immutable, avoid_print, unused_local_variable, unnecessary_brace_in_string_interps, sized_box_for_whitespace
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cartrackingapp/ipconnect.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetOnBus extends StatefulWidget {
  String? car_id;
  GetOnBus({Key? key, required this.car_id}) : super(key: key);

  @override
  State<GetOnBus> createState() => _GetOnBusState();
}

class _GetOnBusState extends State<GetOnBus> {
  List carList = [];
  List userSeat1 = [];
  List userSeat2 = [];
  List userSeat3 = [];
  List userSeat4 = [];
  List userSeat5 = [];
  List userSeat6 = [];
  List userSeat7 = [];
  List userSeat8 = [];
  List userSeat9 = [];
  String? user_id;
  String? seat1;
  String? seat2;
  String? seat3;
  String? seat4;
  String? seat5;
  String? seat6;
  String? seat7;
  String? seat8;
  String? seat9;
  bool statusLoading = false;

  get_car() async {
    final response = await http.get(
        Uri.parse("$ipconnect/get_car/get_car.php?car_id=${widget.car_id}"));
    var data = json.decode(response.body);
    setState(() {
      carList = data;
    });
    if (carList[0]['seat_1'] == 'empty') {
      seat1 = '';
    } else {
      final response1 = await http.get(Uri.parse(
          "$ipconnect/login/get_data_user.php?user_id=${carList[0]['seat_1']}"));
      var data1 = json.decode(response1.body);
      setState(() {
        userSeat1 = data1;
      });
      seat1 = userSeat1[0]['user_name'];
    }
    if (carList[0]['seat_2'] == 'empty') {
      seat2 = '';
    } else {
      final response2 = await http.get(Uri.parse(
          "$ipconnect/login/get_data_user.php?user_id=${carList[0]['seat_2']}"));
      var data2 = json.decode(response2.body);
      setState(() {
        userSeat2 = data2;
      });
      seat2 = userSeat2[0]['user_name'];
    }
    if (carList[0]['seat_3'] == 'empty') {
      seat3 = '';
    } else {
      final response3 = await http.get(Uri.parse(
          "$ipconnect/login/get_data_user.php?user_id=${carList[0]['seat_3']}"));
      var data3 = json.decode(response3.body);
      setState(() {
        userSeat3 = data3;
      });
      seat3 = userSeat3[0]['user_name'];
    }
    if (carList[0]['seat_4'] == 'empty') {
      seat4 = '';
    } else {
      final response4 = await http.get(Uri.parse(
          "$ipconnect/login/get_data_user.php?user_id=${carList[0]['seat_4']}"));
      var data4 = json.decode(response4.body);
      setState(() {
        userSeat4 = data4;
      });
      seat4 = userSeat4[0]['user_name'];
    }
    if (carList[0]['seat_5'] == 'empty') {
      seat5 = '';
    } else {
      final response5 = await http.get(Uri.parse(
          "$ipconnect/login/get_data_user.php?user_id=${carList[0]['seat_5']}"));
      var data5 = json.decode(response5.body);
      setState(() {
        userSeat5 = data5;
      });
      seat5 = userSeat5[0]['user_name'];
    }
    if (carList[0]['seat_6'] == 'empty') {
      seat6 = '';
    } else {
      final response6 = await http.get(Uri.parse(
          "$ipconnect/login/get_data_user.php?user_id=${carList[0]['seat_6']}"));
      var data6 = json.decode(response6.body);
      setState(() {
        userSeat6 = data6;
      });
      seat6 = userSeat6[0]['user_name'];
    }
    if (carList[0]['seat_7'] == 'empty') {
      seat7 = '';
    } else {
      final response7 = await http.get(Uri.parse(
          "$ipconnect/login/get_data_user.php?user_id=${carList[0]['seat_7']}"));
      var data7 = json.decode(response7.body);
      setState(() {
        userSeat7 = data7;
      });
      seat7 = userSeat7[0]['user_name'];
    }
    if (carList[0]['seat_8'] == 'empty') {
      seat8 = '';
    } else {
      final response8 = await http.get(Uri.parse(
          "$ipconnect/login/get_data_user.php?user_id=${carList[0]['seat_8']}"));
      var data8 = json.decode(response8.body);
      setState(() {
        userSeat8 = data8;
      });
      seat8 = userSeat8[0]['user_name'];
    }
    if (carList[0]['seat_9'] == 'empty') {
      seat9 = '';
    } else {
      final response9 = await http.get(Uri.parse(
          "$ipconnect/login/get_data_user.php?user_id=${carList[0]['seat_9']}"));
      var data9 = json.decode(response9.body);
      setState(() {
        userSeat9 = data9;
      });
      seat9 = userSeat9[0]['user_name'];
    }
  }

  out_seat() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('user_id');
    });
    var url = Uri.parse('$ipconnect/insert_seat/out_seat.php');
    var response_out = await http.post(url, body: {
      "car_id": widget.car_id.toString(),
      "user_id": user_id.toString(),
    });
    var data = json.decode(response_out.body);
    if (data == 'out') {
      setState(() {
        statusLoading = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    get_car();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade700,
              Colors.pink.shade200,
              Colors.yellow.shade200
            ],
          ),
        ),
        child: carList.isEmpty
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                ),
              )
            : Stack(
                children: [
                  SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 1,
                                          offset:
                                              Offset(3, 3), // Shadow position
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Icon(Icons.arrow_back_ios_new),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            Container(
                              color: Colors.white,
                              child: Center(
                                child: seat1 == ''
                                    ? Text('ว่าง')
                                    : Text("${seat1}"),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Center(
                                child: seat2 == ''
                                    ? Text('ว่าง')
                                    : Text("${seat2}"),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Center(
                                child: seat3 == ''
                                    ? Text('ว่าง')
                                    : Text("${seat3}"),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Center(
                                child: seat4 == ''
                                    ? Text('ว่าง')
                                    : Text("${seat4}"),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Center(
                                child: seat5 == ''
                                    ? Text('ว่าง')
                                    : Text("${seat5}"),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Center(
                                child: seat6 == ''
                                    ? Text('ว่าง')
                                    : Text("${seat6}"),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Center(
                                child: seat7 == ''
                                    ? Text('ว่าง')
                                    : Text("${seat7}"),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Center(
                                child: seat8 == ''
                                    ? Text('ว่าง')
                                    : Text("${seat8}"),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Center(
                                child: seat9 == ''
                                    ? Text('ว่าง')
                                    : Text("${seat9}"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              statusLoading = true;
                            });
                            out_seat();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "ลงจากรถ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: statusLoading,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: Colors.deepPurple),
                          color: Colors.grey.withOpacity(0.5)),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
