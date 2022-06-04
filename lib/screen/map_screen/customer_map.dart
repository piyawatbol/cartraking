// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_element, avoid_print, unnecessary_new, unused_local_variable, non_constant_identifier_names, prefer_final_fields, must_be_immutable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unnecessary_this, prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cartrackingapp/screen/map_screen/get_on_bus.dart';
import 'package:cartrackingapp/screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ipconnect.dart';

class CustomerMap extends StatefulWidget {
  String? car_id;

  CustomerMap({
    Key? key,
    required this.car_id,
  }) : super(key: key);
  @override
  State<CustomerMap> createState() => _CustomerMapState();
}

class _CustomerMapState extends State<CustomerMap> {
  String? car_id;
  List dataList = [];
  GoogleMapController? mapController;
  Position? userLocation;
  List location_car = [];
  String lati_driver = '0';
  String longti_driver = '0';
  String? data_distance1;
  late BitmapDescriptor mapMaker;
  double? distance;
  String? titleStr;
  String time = "";
  String? user_id;
  var MapData = [];
  bool statusLoading = false;

  bool visibleTabBottom = false;

  calculateDistance(double lat, double long) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat - double.parse(lati_driver.toString())) * p) / 2 +
        c(double.parse(lati_driver.toString()) * p) *
            c(lat * p) *
            (1 - c((double.parse(longti_driver.toString()) - long) * p)) /
            2;
    setState(() {
      distance = double.parse((12742 * asin(sqrt(a))).toStringAsFixed(2));
      // print("distance: ${distance}");
      if (((distance! / 30) * 60) < 1) {
        time = "${(((distance! / 30) * 60) * 60).toStringAsFixed(2)} วินาที";
      } else {
        time = "${((distance! / 30) * 60).toStringAsFixed(2)} นาที";
      }
      // print("lati_driver: ${lati_driver}");
      // print("longti_driver: ${longti_driver}");
      // print("lat: ${lat}");
      // print("long: ${long}");
      // print(time);
    });
  }

  void setCustomMaker() async {
    mapMaker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(10, 10)), "assets/images/bus.png");
  }

  List<Marker> listMap = [];
  // var MapData = [
  //   {"lat": 13.7321834828, "long": 100.487415791, "title": "คณะ ครุศาสตร์"},
  //   {
  //     "lat": 13.7313536167,
  //     "long": 100.48793748,
  //     "title": "ตึก 24 มหาวิทยาลัยราชภัฎบ้านสมเด็จเจ้าพระยา"
  //   },
  //   {
  //     "lat": 13.7319,
  //     "long": 100.4887,
  //     "title": "โรงเรียนสาธิตมหาวิทยาลัยราชภัฏบ้านสมเด็จฯ"
  //   },
  //   {
  //     "lat": 13.7313510111,
  //     "long": 100.490795374,
  //     "title": "สำนักส่งเสริมวิชาการและงานทะเบียน"
  //   },
  //   {
  //     "lat": 13.7322773,
  //     "long": 100.4907417,
  //     "title": "สาขาวิชาสาธารณสุขศาสตร์"
  //   },
  //   {
  //     "lat": 13.7328094007,
  //     "long": 100.488688562,
  //     "title": "แหล่งเรียนรู้กรุงธนบุรีศึกษา"
  //   },
  // ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  addmap() async {
    final response =
        await http.get(Uri.parse("$ipconnect/get_map/get_map.php"));
    var data = json.decode(response.body);
    // print(data);
    setState(() {
      MapData = data;
    });
    for (var i = 0; i < MapData.length; i++) {
      var lat = double.parse("${MapData[i]['lat']}");
      var long = double.parse("${MapData[i]['lng']}");
      var title = MapData[i]['title'].toString();
      listMap.add(Marker(
        onTap: () {
          setState(() {
            calculateDistance(lat, long);
            titleStr = title;
            showModalBottomSheet(
                barrierColor: Colors.transparent,
                context: this.context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                builder: (context) {
                  return showmodal_map();
                });
          });
        },
        markerId: MarkerId(i.toString()),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: title),
      ));
    }
    setState(() {
      listMap.add(
        Marker(
            onTap: () {
              showModalBottomSheet(
                  barrierColor: Colors.transparent,
                  context: this.context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  builder: (context) {
                    return showmodal_bus();
                  });
            },
            markerId: MarkerId('id-1'),
            icon: mapMaker,
            position: lati_driver == ''
                ? LatLng(0, 0)
                : LatLng(double.parse(lati_driver.toString()),
                    double.parse(longti_driver.toString())),
            infoWindow: InfoWindow(
              title: 'คนขับ',
            )),
      );
    });
  }

  get_location_car() async {
    final response = await http.get(Uri.parse(
        "$ipconnect/get_car/get_location_car.php?car_id=${widget.car_id}"));
    var data = json.decode(response.body);
    if (this.mounted) {
      setState(() {
        location_car = data;
      });
    }
    lati_driver = location_car[0]['lo_driver_lati'];
    longti_driver = location_car[0]['lo_driver_longti'];
  }

  Future<Position?> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return userLocation;
  }

  getDataRealTime() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      get_location_car();
      addmap();
      setCustomMaker();
      // timer.cancel();
    });
  }

  Future get_on_bus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString('user_id');
    });
    var url = Uri.parse('$ipconnect/insert_seat/insert_seat.php');
    var response = await http.post(url, body: {
      "car_id": widget.car_id.toString(),
      "user_id": user_id.toString(),
    });
    var data = json.decode(response.body);
    setState(() {
      statusLoading = false;
    });
    if (data == 'full') {
      print('รถเต็ม');
      Alert(
          context: context,
          content: Column(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 100,
              ),
              Text("รถเต็ม")
            ],
          )).show();
    } else if (data == 'you_sit_seat') {
      Alert(
          context: context,
          content: Column(
            children: [
              Icon(
                Icons.warning_amber,
                color: Colors.yellow,
                size: 100,
              ),
              Text("คุณขึ้นรถแล้ว")
            ],
          )).show();
    } else {
      print('ขึ้นรถ');
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return GetOnBus(car_id: location_car[0]['car_id']);
      }));
    }
  }

  @override
  void initState() {
    getDataRealTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: location_car.isEmpty
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : FutureBuilder(
              future: _getLocation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      GoogleMap(
                          markers: listMap.toSet(),
                          zoomControlsEnabled: false,
                          mapType: MapType.normal,
                          myLocationButtonEnabled: false,
                          onMapCreated: _onMapCreated,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                              zoom: 16,
                              target: LatLng(userLocation!.latitude,
                                  userLocation!.longitude))),
                      Positioned(
                        left: 20,
                        top: 75,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 60,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 133, 88, 148),
                                    Color.fromARGB(255, 167, 110, 186)
                                  ]),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Timer.periodic(Duration(seconds: 1),
                                      (timer) async {
                                    timer.cancel();
                                  });
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "รถคันที่ ${widget.car_id} ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return ProFileScreen();
                                  }));
                                },
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              )
                            ],
                          ),
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
                              border: Border.all(
                                  width: 2, color: Colors.deepPurple),
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
                } else {
                  return Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 80,
                        child: GestureDetector(
                          onTap: () {
                            Timer.periodic(Duration(seconds: 1), (timer) async {
                              timer.cancel(); //ถ้าต้องการให้หยุดทำงาน
                            });
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
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController?.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(userLocation!.latitude, userLocation!.longitude), 18));
        },
        child: Icon(Icons.near_me),
      ),
    );
  }

  showmodal_map() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 133, 88, 148),
                Color.fromARGB(255, 133, 88, 148),
              ]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.01,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(60)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Icon(Icons.location_city),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 240,
                      child: Text(
                        "${titleStr}",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.access_time),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 240,
                      child: Text(
                        "รถโดยสายกำลังจะมาถึงภายใน ${time}  (${distance} กิโลเมตร) ",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showmodal_bus() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 133, 88, 148),
              Color.fromARGB(255, 133, 88, 148),
            ]),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.01,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                statusLoading = true;
              });
              get_on_bus();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'ขึ้นรถ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return GetOnBus(car_id: widget.car_id);
              }));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'ดูคนบนรถ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
