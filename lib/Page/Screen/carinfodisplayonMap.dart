// ignore: file_names
import 'dart:convert';

import 'package:bazralogin/Page/Screen/Search.dart';
import 'package:bazralogin/Route/route.dart';

import 'package:flutter/services.dart';
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
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  // search
  bool isLoading = false;

  late List<String>? autoCompleteData;

  late TextEditingController controller;

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
    super.initState();
  }

  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  void setInitialLocation() {
    currentlocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    dEST_LOCATION = LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  Widget build(BuildContext context) {
    final CarData = Provider.of<Carinfo>(context);

    final CarId = ModalRoute.of(context)?.settings.arguments as String?;

    final CarList = CarData.products;
// history display
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
                position: DEST_LOCATION,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                onTap: (() {}),
                infoWindow: InfoWindow(title: "CarB"))
          },
          onMapCreated: (controller) {
            // Assign the controller value to use it later
            mapController = controller;
            setPolylines();
          },
        ),
        Container(
          margin: EdgeInsets.only(left: 200, top: 30, bottom: 150),
          child: Positioned(
            child: Container(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Column(
                          children: [
                            Autocomplete(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                } else {
                                  return autoCompleteData!.where((word) => word
                                      .toLowerCase()
                                      .contains(
                                          textEditingValue.text.toLowerCase()));
                                }
                              },
                              optionsViewBuilder: (context,
                                  Function(String) onSelected, options) {
                                return Container(
                                  child: Material(
                                    elevation: 4,
                                    child: Container(
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          final option =
                                              options.elementAt(index);

                                          return Container(
                                            child: GestureDetector(
                                              onTap: (() {
                                                Navigator.of(context).pushNamed(
                                                  AppRoutes.mapTracking,
                                                );
                                              }),
                                              child: ListTile(
                                                // title: Text(option.toString()),
                                                title: SubstringHighlight(
                                                  text: option.toString(),
                                                  term: controller.text,
                                                  textStyleHighlight: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                leading: Image.asset(
                                                    "assets/images/car1.png"),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(),
                                        itemCount: options.length,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onSelected: (selectedString) {
                                print(selectedString);
                              },
                              fieldViewBuilder: (context, controller, focusNode,
                                  onEditingComplete) {
                                this.controller = controller;

                                return Container(
                                  color: Colors.white,
                                  child: TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    onEditingComplete: onEditingComplete,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.black!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.black!),
                                      ),
                                      hintText: "Search car",
                                      prefixIcon: Icon(Icons.search),
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
        )
      ],
    ));
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
