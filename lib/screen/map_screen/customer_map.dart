// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_element, avoid_print, unnecessary_new, unused_local_variable, non_constant_identifier_names, prefer_final_fields, must_be_immutable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cartrackingapp/screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
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
  Position? driverLocation;
  List location_car = [];
  String lati_driver = '0';
  String longti_driver = '0';
  String? data_distance1;
  late BitmapDescriptor mapMaker;
  double? distance;
  String? titleStr;
  String time = "";
  var MapData = [];

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
      distance = double.parse((12742 * asin(sqrt(a))).toStringAsFixed(3));
      print("distance: ${distance}");
      if (((distance! / 30) * 60) < 1) {
        time = "${(((distance! / 30) * 60) * 60).toStringAsFixed(3)} วินาที";
      } else {
        time = "${((distance! / 30) * 60).toStringAsFixed(3)} นาที";
      }
      print("lati_driver: ${lati_driver}");
      print("longti_driver: ${longti_driver}");
      print("lat: ${lat}");
      print("long: ${long}");
      print(time);
    });
  }

  void setCustomMaker() async {
    mapMaker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/bus.png");
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
    setState(() {
      listMap.add(
        Marker(
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

  addmap() async {
    final response =
        await http.get(Uri.parse("$ipconnect/get_map/get_map.php"));
    var data = json.decode(response.body);
    print(data);
    setState(() {
      MapData = data;
    });

    for (var i = 0; i < MapData.length; i++) {
      var lat = double.parse("${MapData[i]['lat']}");
      var long = double.parse("${MapData[i]['lng']}");
      var title = MapData[i]['title'].toString();
      listMap.add(Marker(
        onTap: () {
          setState(() async {
            await calculateDistance(lat, long);
            titleStr = title;
            visibleTabBottom = true;
          });
        },
        markerId: MarkerId(i.toString()),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: title),
      ));
    }
  }

  Future get_location_car() async {
    final response = await http.get(Uri.parse(
        "$ipconnect/get_car/get_location_car.php?car_id=${widget.car_id}"));
    var data = json.decode(response.body);

    location_car = data;

    lati_driver = location_car[0]['lo_driver_lati'];
    longti_driver = location_car[0]['lo_driver_longti'];
    print("location lati car : ${lati_driver}");
    print("location longti car : ${longti_driver}");
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
    driverLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return driverLocation;
  }

  getDataRealTime() async {
    Timer.periodic(Duration(seconds: 10), (timer) async {
      get_location_car();
      _getLocation();
      // timer.cancel();
    });
  }

  @override
  void initState() {
    addmap();
    get_location_car();

    setCustomMaker();
    getDataRealTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                GoogleMap(
                    onTap: (value) {
                      setState(() {
                        visibleTabBottom = false;
                      });
                    },
                    markers: listMap.toSet(),
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        zoom: 16,
                        target: LatLng(driverLocation!.latitude,
                            driverLocation!.longitude))),
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
                            Timer.periodic(Duration(seconds: 1), (timer) async {
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
                  visible: visibleTabBottom,
                  child: Positioned(
                    bottom: -30,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 133, 88, 148),
                                    Color.fromARGB(255, 167, 110, 186)
                                  ]),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Text(
                                        "ชื่อสถานที่ : ${titleStr}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ระยะทาง ${distance} เมตร",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ระยะเวลา ${time}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
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
              LatLng(driverLocation!.latitude, driverLocation!.longitude), 20));
        },
        child: Icon(Icons.near_me),
      ),
    );
  }
}
