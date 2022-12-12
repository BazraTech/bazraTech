import 'package:bazralogin/Model/item.dart';
import 'package:bazralogin/Page/Screen/carinfodisplayonMap.dart';
import 'package:bazralogin/Route/route.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

const double ZOOM = 1;

class Tracking extends StatefulWidget {
  @override
  State<Tracking> createState() => _TrackingState();
}

List<Car> products = [];

class _TrackingState extends State<Tracking> {
  final TextEditingController searchController = TextEditingController();

  GoogleMapController? mapController;
  // GeoPoint? location;
  // Object? latLng;
  // int? length;
  // void dispose() {
  //   mapController.dispose();

  // }

  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(9.005401, 38.763611),
        infoWindow: InfoWindow(title: "car")),
  ];
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    final carData = Provider.of<Carinfo>(context);
    final productsList = carData.products;

    
    // final carmarker = CarData.products;  carmarker.forEach((Value) => _marker.add(const Marker(
    //       markerId: MarkerId("car"),
    //     )));
    // Widget animatCar() {
    //   return Container(
    //     child: GoogleMap(
    //       initialCameraPosition:
    //           const CameraPosition(target: LatLng(9.005401, 38.763611)),
    //       // Markers to be pointed
    //       markers: Set<Marker>.of(_marker),
    //       onMapCreated: (controller) {
    //         // Assign the controller value to use it later
    //         mapController = controller;
    //       },
    //     ),
    //   );
    // }

    return Scaffold(
        body: Stack(
      children: [
        Container(
          child: GoogleMap(
            initialCameraPosition:
                const CameraPosition(target: LatLng(9.005401, 38.763611)),
            // Markers to be pointed

            onMapCreated: (controller) {
              // Assign the controller value to use it later
              mapController = controller;
            },
          ),
        ),
        Positioned(
            child: Container(
                width: 200,
                margin: const EdgeInsets.only(top: 60, left: 250, right: 8),
                child: ElevatedButton(
                  child: Row(
                    children: const [Icon(Icons.search), Text(" Search car")],
                  ),
                  onPressed: (() {
                    Navigator.of(context).pushNamed(AppRoutes.mapSearch);
                  }),
                )))
      ],
    ));
  }
}

// class Listdat extends StatefulWidget {
//   Listdat({super.key});

//   @override
//   State<Listdat> createState() => _ListdatState();
// }

// class _ListdatState extends State<Listdat> {
//   int? dataLength;

//   List<Car>? data;

//   @override
//   Widget build(BuildContext context) {
//     final listOfcar = Provider.of<Carinfo>(context);

//     final car = listOfcar.product;

//     return Scaffold(
//       body: ListView(
//         children: [
//           Container(
//             child: TextFormField(
//               onChanged: (value) {
//                 setState(() {
//                   dataLength = car
//                       .where((element) =>
//                           element.name!.toLowerCase().startsWith(value))
//                       .length;

//                   print(dataLength);
//                   data = car
//                       .where((element) =>
//                           element.name!.toLowerCase().startsWith(value))
//                       .toList();
//                 });
//               },
//               decoration: InputDecoration(
//                   hintText: "search", prefixIcon: Icon(Icons.search)),
//             ),
//           ),
//           ...List.generate(dataLength == null ? car.length : dataLength!,
//               (index) {
//             final snapshot = data == null ? car[index] : data![index];
//             final listOf = Provider.of<Car>(context);
//             return InkWell(
//               onTap: () {
//                 Navigator.of(context)
//                     .pushNamed(AppRoutes.mapTracking, arguments: listOf.id);
//               },
//               child: ListTile(
//                 title: Text(snapshot.name),
//                 subtitle: Text(snapshot.id.toString()),
//               ),
//             );
//           })
//         ],
//       ),
//     );
//   }
// }
