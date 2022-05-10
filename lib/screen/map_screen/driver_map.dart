// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_element, avoid_print, unnecessary_new, unused_local_variable, non_constant_identifier_names, prefer_final_fields, must_be_immutable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations
import 'dart:async';
import 'package:cartrackingapp/screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../ipconnect.dart';

class DriverMap extends StatefulWidget {
  String? car_id;
  DriverMap({
    Key? key,
    required this.car_id,
  }) : super(key: key);

  @override
  State<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  GoogleMapController? mapController;
  Position? driverLocation;
  String lati_user = '0';
  String longti_user = '0';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
    Timer.periodic(new Duration(seconds: 10), (timer) async {
      _getLocation();
      insert_location();
      // timer.cancel(); //ถ้าต้องการให้หยุดทำงาน
    });
  }

  Future insert_location() async {
    var url = Uri.parse('$ipconnect/insert_location/insert_location.php');
    var response = await http.post(url, body: {
      "car_id": widget.car_id.toString(),
      "lati": driverLocation!.latitude.toString(),
      "longti": driverLocation!.longitude.toString(),
    });
  }

  @override
  void initState() {
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
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    zoom: 18,
                    target: LatLng(
                        driverLocation!.latitude, driverLocation!.longitude),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 75,
                  child: Container(
                    width: 355,
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
                              timer.cancel(); //ถ้าต้องการให้หยุดทำงาน
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
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return AlertDialog(
          //         content: Container(
          //           height: 50,
          //           child: Column(
          //             children: [
          //               Text(userLocation!.latitude.toString()),
          //               Text(userLocation!.longitude.toString()),
          //             ],
          //           ),
          //         ),
          //       );
          //     });
        },
        child: Icon(Icons.near_me),
      ),
    );
  }
}
