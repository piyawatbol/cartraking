// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names, avoid_print
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:cartrackingapp/ipconnect.dart';
import 'package:cartrackingapp/screen/forget_screen/success_reset.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPass extends StatefulWidget {
  final String user_id;
  ResetPass({Key? key, required this.user_id}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController newPass = TextEditingController();
  TextEditingController ComPass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    print(widget.user_id);
    super.initState();
  }

  Future<void> ResetPassword() async {
    print("Pass");
    var reset = await http.post(
        Uri.parse('$ipconnect/forget_password/ResetPass.php'),
        body: {'user_id': widget.user_id, 'Pass': newPass.text});
    var data = json.decode(reset.body);
    print(data);
    if (data == "error") {
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return SuccessReset();
      }));
    }
  }

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                    "รีเซ็ตรหัสผ่าน",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "รหัสผ่านใหม่",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ('กรุณากรอกรหัสผ่าน');
                                }
                                return null;
                              },
                              decoration: inputstyle,
                              controller: newPass,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "ยีนยันรหัสผ่านใหม่อีกครั้ง",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ('กรุณากรอกรหัสผ่าน');
                                }
                                return null;
                              },
                              decoration: inputstyle,
                              controller: ComPass,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      final isValid = formKey.currentState!.validate();
                      if (isValid) {
                        if (newPass.text != ComPass.text) {
                          Fluttertoast.showToast(
                              msg: "รหัสผ่านไม่ตรงกัน",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          ResetPassword();
                        }
                      }
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
      ),
    );
  }
}
