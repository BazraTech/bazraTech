// ignore: file_names
import 'dart:convert';

import 'package:bazralogin/Page/Screen/Searchcar.dart';
import 'package:bazralogin/Route/route.dart';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:bazralogin/Model/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';

class displaycarlaction extends StatefulWidget {
  const displaycarlaction({super.key});

  @override
  State<displaycarlaction> createState() => _displaycarlactionState();
}

// ignore: camel_case_types
class _displaycarlactionState extends State<displaycarlaction> {
  GoogleMapController? mapController;
  static LatLng SOURCE_LOCATION = LatLng(9.005401, 38.763611);
  static LatLng DEST_LOCATION = LatLng(8.5263, 39.2583);

  // search
  bool isLoading = false;
  String? userSelected;
  late List<String>? autoCompleteData;
  String? latitude;
  String? longitude;

  late TextEditingController controller;
  // get current location
  Location currentLocationcar = Location();
  Set<Marker> _markers = {};

  void getLocation() async {
    var location = await currentLocationcar.getLocation();
    currentLocationcar.onLocationChanged.listen((LocationData loc) {
      mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      });
    });
  }

  Future<void> _goto(double x, double y) async {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(x, y), zoom: 18)));
    Marker(
        markerId: MarkerId("strat"),
        position: LatLng(x, y),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: "CarB"));
    Marker(
        markerId: MarkerId("Adama"),
        position: currentlocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: "CarB"));
    setPolylines();
  }

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final String stringData = await rootBundle.loadString("assets/data.json");

    final List<dynamic> json = jsonDecode(stringData);

    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }

  //ployline

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  late LatLng dEST_LOCATION;
  late LatLng currentlocation;

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    this.setInitialLocation();
    fetchAutoCompleteData();
    getLocation();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void setInitialLocation() {
    currentlocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    dEST_LOCATION = LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  Widget build(BuildContext context) {
    Future onpenDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Trip"),
                          Text(" 11 ,3,2022 ,move  to Adama ,")
                        ],
                      )
                    ],
                  )),
            ));

// history display

    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          polylines: _polylines,
          myLocationEnabled: true,
          initialCameraPosition:
              CameraPosition(target: LatLng(9.005401, 38.763611)),
          // Markers to be pointed
          markers: {
            Marker(
                markerId: MarkerId("strat"),
                position: currentlocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                infoWindow: InfoWindow(title: "CarB")),
            Marker(
                markerId: MarkerId("destinations"),
                position: dEST_LOCATION,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                onTap: (() {}),
                infoWindow: InfoWindow(title: "CarB"))
          },
          onMapCreated: (controller) {
            // Assign the controller value to use it later
            mapController = controller;
            // setPolylines();
          },
        ),
        Container(
          child: Positioned(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 13.0, left: 10),
                  child: Container(
                    width: 100,
                    height: 45,
                    margin: EdgeInsets.only(top: 200),
                    child: ElevatedButton(
                      onPressed: (() {
                        Navigator.pushNamed(context, AppRoutes.carhistory);
                      }),
                      child: Text(
                        "History",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            }
                            return const Color.fromRGBO(255, 255, 255, 1);
                          }),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Color.fromRGBO(162, 184, 212, 1)),
                                  borderRadius: BorderRadius.circular(18)))),
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  height: 100,
                  margin: EdgeInsets.only(left: 100),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            child: isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Autocomplete(
                                            optionsBuilder: (TextEditingValue
                                                textEditingValue) {
                                              if (textEditingValue
                                                  .text.isEmpty) {
                                                return const Iterable<
                                                    String>.empty();
                                              } else {
                                                return autoCompleteData!.where(
                                                    (word) => word
                                                        .toLowerCase()
                                                        .contains(
                                                            textEditingValue
                                                                .text
                                                                .toLowerCase()));
                                              }
                                            },
                                            optionsViewBuilder: (context,
                                                Function(String) onSelected,
                                                options) {
                                              return Container(
                                                height: 20,
                                                width: 150,
                                                child: Material(
                                                  elevation: 4,
                                                  child: Container(
                                                    child: ListView.separated(
                                                      padding: EdgeInsets.zero,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final option = options
                                                            .elementAt(index);

                                                        return Container(
                                                          height: 50,
                                                          child: ListTile(
                                                            onTap: () async {
                                                              _goto(9.005401,
                                                                  38.763611);
                                                            },
                                                            // title: Text(option.toString()),
                                                            title:
                                                                SubstringHighlight(
                                                              text: option
                                                                  .toString(),
                                                              term: controller
                                                                  .text,
                                                              textStyleHighlight:
                                                                  TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                            ),
                                                            leading: Image.asset(
                                                                "assets/images/download-removebg-preview (1).png"),
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              Divider(),
                                                      itemCount: options.length,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            onSelected:
                                                (String selectedString) {
                                              setState(() {
                                                userSelected = selectedString;
                                              });
                                            },
                                            fieldViewBuilder: (context,
                                                controller,
                                                focusNode,
                                                onEditingComplete) {
                                              this.controller = controller;

                                              return Container(
                                                margin:
                                                    EdgeInsets.only(top: 40),
                                                color: Colors.white,
                                                child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller: controller,
                                                    focusNode: focusNode,
                                                    onEditingComplete:
                                                        onEditingComplete,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      hintText: "Search  ",
                                                      hintStyle: TextStyle(
                                                          fontSize: 10),
                                                      prefixIcon: Icon(
                                                        Icons.search,
                                                        size: 23,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
    floatingActionButton:
    FloatingActionButton(
      child: Icon(
        Icons.location_searching,
        color: Colors.white,
      ),
      onPressed: () {
        getLocation();
      },
    );
  }

// draw polyline
  void setPolylines() async {
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      "AIzaSyDd81MpJcxjNdICQeKRg3Emywp4e_29Sfc",
      PointLatLng(
        currentlocation.latitude,
        currentlocation.longitude,
      ),
      PointLatLng(
        dEST_LOCATION.latitude,
        dEST_LOCATION.longitude,
      ),
    );
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      print("yyyyyyyyyyyyyyyyyyyyyyyy");
      setState(() {
        _polylines.add(Polyline(
            width: 3,
            polylineId: PolylineId('polyLine'),
            color: Colors.blue,
            points: polylineCoordinates));
      });
    }
  }
}
