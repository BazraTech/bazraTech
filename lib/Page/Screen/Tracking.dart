import 'package:bazralogin/Model/car.dart';
import 'package:bazralogin/Page/Screen/Search.dart';
import 'package:bazralogin/Page/Screen/carinfodisplayonMap.dart';
import 'package:bazralogin/Page/Screen/communication/seachdriver.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:bazralogin/const/color.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:maps_launcher/maps_launcher.dart';

// track all car

class Tracking extends StatefulWidget {
  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  final TextEditingController searchController = TextEditingController();
  GoogleMapController? mapController;
  static LatLng SOURCE_LOCATION = LatLng(9.005401, 38.763611);
  static LatLng DEST_LOCATION = LatLng(8.5263, 39.2583);

  // get location
  LocationData? currentLocation;
  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
  }

  //polyline
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  late LatLng dEST_LOCATION;
  late LatLng currentlocation;

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    this.setInitialLocation();

    super.initState();
  }

  void setInitialLocation() {
    currentlocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    dEST_LOCATION = LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final carData = Provider.of<Carinfo>(context);
    // dialog
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Trip"),
                          ),
                          Spacer(),
                          Text(" 11 ,3,2022 ,move  to Adama ")
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Distance"),
                          ),
                          Spacer(),
                          Text(" 11 ,3,2022 ,move  to Adama ")
                        ],
                      )
                    ],
                  )),
            ));

    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Color.fromRGBO(217, 217, 217, 1),
          child: GoogleMap(
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
                  infoWindow: InfoWindow(title: "car")),
              Marker(
                  markerId: MarkerId("destinations"),
                  position: dEST_LOCATION,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                  onTap: (() {}),
                  infoWindow: InfoWindow(title: "Adama"))
            },
            onMapCreated: (controller) {
              // Assign the controller value to use it later
              mapController = controller;
              setPolylines();
            },
          ),
        ),
        Positioned(
            child: Container(
          margin: EdgeInsets.only(top: 200, left: 15),
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: (() {
                    onpenDialog();
                  }),
                  child: Text(
                    "History",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return ColorsConsts.backgroundColor;
                        }
                        return const Color.fromRGBO(255, 255, 255, 1);
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)))))
            ],
          ),
        ))
      ],
    ));
  }

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
