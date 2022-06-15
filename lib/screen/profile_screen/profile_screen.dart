// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_print, non_constant_identifier_names, unused_element, unnecessary_brace_in_string_interps, unused_local_variable, prefer_void_to_null, prefer_final_fields, unnecessary_null_comparison, avoid_unnecessary_containers, unnecessary_this
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:cartrackingapp/screen/login_screen/login_screen.dart';
import 'package:cartrackingapp/screen/profile_screen/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../ipconnect.dart';

class ProFileScreen extends StatefulWidget {
  ProFileScreen({Key? key}) : super(key: key);

  @override
  State<ProFileScreen> createState() => _ProFileScreenState();
}

class _ProFileScreenState extends State<ProFileScreen> {
  String? user_id;
  List dataList = [];
  String? name;
  String? phone;
  String? email;
  String? img;
  Future get_user_id() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('user_id');
    });
    print(user_id);
    await get_data_user();
  }

  Future get_data_user() async {
    final response = await http
        .get(Uri.parse("$ipconnect/login/get_data_user.php?user_id=$user_id"));
    var data = json.decode(response.body);

    if (this.mounted) {
      setState(() {
        dataList = data;
      });
    }
    name = dataList[0]['user_name'];
    phone = dataList[0]['phone'];
    email = dataList[0]['email'];
    img = dataList[0]['img'];
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                                  offset: Offset(3, 3), // Shadow position
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(
                    "โปรไฟล์",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      img == '' || img == null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 80,
                                backgroundImage:
                                    AssetImage('assets/images/profile.jpg'),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 80,
                                backgroundImage: NetworkImage(
                                    '${ipconnect}/images_user/${img}'),
                              ),
                            ),
                      Text(
                        "ชื่อ",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        "$name",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        "เบอร์โทร",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        "$phone",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        "อีเมล",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        "$email",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return EditProfile();
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Color(0xff0c488d),
                              borderRadius: BorderRadius.circular(14)),
                          child: Center(
                              child: Text(
                            "แก้ไข",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return EditProfile();
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Color(0xff0c488d),
                        borderRadius: BorderRadius.circular(14)),
                    child: Center(
                        child: Text(
                      "ออกจากระบบ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
