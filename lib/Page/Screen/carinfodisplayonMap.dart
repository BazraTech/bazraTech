// ignore: file_names
import 'dart:convert';

import 'package:location/location.dart';

import 'package:bazralogin/Model/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class displaycarlaction extends StatefulWidget {
  const displaycarlaction({super.key});

  @override
  State<displaycarlaction> createState() => _displaycarlactionState();
}

// ignore: camel_case_types
class _displaycarlactionState extends State<displaycarlaction> {
  GoogleMapController? mapController;
  static const LatLng SOURCE_LOCATION = LatLng(9.005401, 38.763611);
  LatLng DEST_LOCATION = LatLng(7.6785, 36.8384);

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

  Widget build(BuildContext context) {
    final CarData = Provider.of<Carinfo>(context);

    final CarId = ModalRoute.of(context)?.settings.arguments as String?;

    final cardAttr = CarData.findById(CarId!);
    final CarList = CarData.products;

    Future onpenDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(cardAttr.name),
              content: Container(
                child: Text(cardAttr.history),
              ),
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
                infoWindow: InfoWindow(
                    title: "${cardAttr.name}",
                    snippet: "${cardAttr.location}"
                        "time:"
                        "${cardAttr.time}")),
            Marker(
                markerId: MarkerId("destinations"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                position: dEST_LOCATION,
                infoWindow: InfoWindow(title: "jimma"))
          },
          onMapCreated: (controller) {
            // Assign the controller value to use it later
            mapController = controller;
            setPolylines();
          },
        ),
        Positioned(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              margin: EdgeInsets.only(top: 200),
              child: ElevatedButton(
                onPressed: (() {
                  onpenDialog();
                }),
                child: Container(child: Text("car history")),
              )),
        )),
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
