// ignore_for_file: prefer_const_constructors_in_immutables, sized_box_for_whitespace, non_constant_identifier_names, must_be_immutable
//  prefer_const_constructors, sized_box_for_whitespace
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  String? user_id;
  EditProfile({Key? key, required this.user_id}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final img = 'assets/images/profile.jpg';
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
          Positioned(
            left: 20,
            top: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1,
                    offset: Offset(3, 3), // Shadow position
                  ),
                ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "โปรไฟล์",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: 580,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: AssetImage(img),
                              ),
                            ),
                            Form(
                                child: Column(
                              children: [
                                Text(
                                  'ชื่อ',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 26,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: TextFormField(
                                    decoration: inputstyle,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'โทรศัพท์',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 26,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: TextFormField(
                                    decoration: inputstyle,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'อีเมล',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 26,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: TextFormField(
                                    decoration: inputstyle,
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(height: 22),
                            Container(
                              width: 100,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 12, 72, 141),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Center(
                                  child: Text(
                                "บันทึก",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
