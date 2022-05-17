// ignore_for_file: prefer_const_constructors_in_immutables, sized_box_for_whitespace, non_constant_identifier_names, must_be_immutable, unnecessary_brace_in_string_interps, avoid_print, unused_local_variable, unused_field, unrelated_type_equality_checks, avoid_unnecessary_containers, unnecessary_null_comparison, prefer_typing_uninitialized_variables
//  prefer_const_constructors, sized_box_for_whitespace
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:cartrackingapp/screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ipconnect.dart';

class EditProfile extends StatefulWidget {
  EditProfile({
    Key? key,
  }) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController? name;
  TextEditingController? phone;
  TextEditingController? email;
  List dataList = [];
  String? user_id;
  String? name_user;
  String? phone_user;
  String? email_user;
  bool statusLoading = false;
  File? _image;
  String? img;
  Future get_user_id() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('user_id');
    });
    print(user_id);
  }

  Future get_data_user() async {
    final response = await http
        .get(Uri.parse("$ipconnect/login/get_data_user.php?user_id=$user_id"));
    var data = json.decode(response.body);
    setState(() {
      dataList = data;
      img = dataList[0]['img'];
    });
    name_user = dataList[0]['user_name'];
    phone_user = dataList[0]['phone'];
    email_user = dataList[0]['email'];
    print(dataList);
  }

  get_image(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ),
    );
    if (image != null) {
      setState(() {
        _image = File(image!.path);
      });
    } else {
      _image = File('');
    }
  }

  Future edit_user() async {
    final uri = Uri.parse("${ipconnect}/login/edit_user.php");
    var request = http.MultipartRequest('POST', uri);
    if (_image != null) {
      var img = await http.MultipartFile.fromPath("img", _image!.path);
      request.files.add(img);
    }

    request.fields['user_id'] = user_id.toString();
    request.fields['user_name'] = name!.text;
    request.fields['phone'] = phone!.text;
    request.fields['email'] = email!.text;

    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        statusLoading = false;
      });
      Fluttertoast.showToast(
          msg: "บันทึกเสร็จสิ้น",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ProFileScreen();
      }));
    } else {
      setState(() {
        statusLoading = false;
      });
    }
  }

  setTextController() async {
    await get_user_id();
    await get_data_user();
    name = TextEditingController(text: '${name_user}');
    phone = TextEditingController(text: '${phone_user}');
    email = TextEditingController(text: '${email_user}');
  }

  @override
  void initState() {
    setTextController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
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
                dataList.isEmpty
                    ? Container(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SafeArea(
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 30),
                                  Row(
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
                                                  offset: Offset(
                                                      3, 3), // Shadow position
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Icon(Icons.arrow_back_ios_new),
                                        ),
                                      ),
                                    ],
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
                                  Container(
                                    height: 580,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: _image == null
                                                  ? img == '' || img == null
                                                      ? CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          radius: 80,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/profile.jpg'),
                                                        )
                                                      : CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          radius: 80,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  '${ipconnect}/images_user/${img}'),
                                                        )
                                                  : CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey,
                                                      radius: 80,
                                                      backgroundImage:
                                                          FileImage(_image!),
                                                    ),
                                            ),
                                            Positioned(
                                              right: 5,
                                              bottom: 20,
                                              child: GestureDetector(
                                                onTap: () {
                                                  get_image(ImgSource.Gallery);
                                                },
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    child: Icon(
                                                        Icons.add_a_photo)),
                                              ),
                                            )
                                          ],
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
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            BuildTxt(name),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'โทรศัพท์',
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 26,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            BuildTxt(phone),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'อีเมล',
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 26,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            BuildTxt(email),
                                          ],
                                        )),
                                        SizedBox(height: 22),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              statusLoading = true;
                                            });
                                            edit_user();
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color: Color(0xff0c488d),
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            child: Center(
                                                child: Text(
                                              "บันทึก",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: statusLoading == true ? true : false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.deepPurple),
                color: Colors.grey.withOpacity(0.5)),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding BuildTxt(TextEditingController? controllerEdit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: controllerEdit,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 35),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              width: 3,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
