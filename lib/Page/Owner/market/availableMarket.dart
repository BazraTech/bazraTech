// import 'dart:convert';

// import 'package:bazralogin/Route/route.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_places_flutter/model/place_details.dart';
// import 'package:http/http.dart' as http;
// import 'package:bazralogin/Theme/customAppBar.dart';
// import 'package:bazralogin/const/constant.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:flutter/material.dart';
// import '../../../../Model/Vehicle.dart';
// import '../../../config/ApiConfig.dart';
// import '../Driver/assignDriver.dart';

// class AvailableMarket extends StatefulWidget {
//   final String? licenseNumber;
//   AvailableMarket({super.key, this.licenseNumber});

//   @override
//   State<AvailableMarket> createState() => _AvailableMarketState();
// }

// bool isPressed = true;
// Offset distance = isPressed ? Offset(10, 10) : Offset(20, 20);
// double blur = isPressed ? 5.0 : 20.0;

// class _AvailableMarketState extends State<AvailableMarket> {
//   TextEditingController _searchController = TextEditingController();
//   bool valuefirst = false;

//   List resultss = [];
//   final _fetchVehicle = APIService();
//   VehicleResponseModel? _vehicleResponseModel;
//   void checkStatus() {
//     valuefirst = !valuefirst;
//   }

//   void initState() {
//     super.initState();
//     //_getData();
//     _fetchVehicle
//         .vehicleFetch()
//         .then((car) => setState(() => _vehicleResponseModel = car));
//   }

//   void driversSearch(String enterKeyboard) {
//     setState(() {});
//     if (enterKeyboard.isEmpty) {
//     } else {
//       final findVehicle = resultss.where((driver) {
//         final name = driver['vehicleName'].toLowerCase();
//         // final license = driver.plateNumber.toLowerCase();
//         final inputName = enterKeyboard.toLowerCase();
//         final inputLicense = enterKeyboard.toLowerCase();
//         return name.contains(inputName);
//       }).toList();
//       setState(() {
//         this.resultss = findVehicle;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//         child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: Scaffold(
//                 // backgroundColor: kBackgroundColor,
//                 appBar: AppBar(
//                   leading: IconButton(
//                     icon: const Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.white,
//                     ),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   toolbarHeight: 80,
//                   backgroundColor: kPrimaryColor,
//                   title: Container(
//                     margin: EdgeInsets.only(top: 10, right: 50),
//                     height: 45,
//                     decoration: BoxDecoration(
//                       color: Color.fromRGBO(244, 243, 243, 1),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: TextField(
//                       onChanged: driversSearch,
//                       //   controller: _searchController,
//                       decoration: const InputDecoration(
//                         suffixIcon: Icon(Icons.close),
//                         prefixIcon: Icon(Icons.search_rounded),
//                         border: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         hintText: 'Driver Name or Plate No.',
//                       ),
//                     ),
//                   ),
//                   centerTitle: true,
//                 ),
//                 body: SingleChildScrollView(
//                     child: _vehicleResponseModel == null
//                         ? Container(
//                             margin: EdgeInsets.only(top: 130),
//                             child: Center(child: CircularProgressIndicator()))
//                         : Column(children: [
//                             Container(
//                                 margin: EdgeInsets.only(
//                                     left: 10, top: 5, bottom: 5),
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.07,
//                                 width: MediaQuery.of(context).size.width * 0.8,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(6.0),
//                                 ),
//                                 child: Container(
//                                   margin: EdgeInsets.only(
//                                       left: 70, top: 25, bottom: 6),
//                                   child: const Text("List Of Vehicles",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 23,
//                                         color: kPrimaryColor,
//                                       )),
//                                 )),
//                             Container(
//                                 margin: EdgeInsets.only(top: 20),
//                                 height: MediaQuery.of(context).size.height,
//                                 child: ListView.builder(
//                                     itemCount:
//                                         _vehicleResponseModel!.vehicles.length,
//                                     itemBuilder: (context, index) {
//                                       return Column(
//                                         children: [
//                                           Container(
//                                             height: screenHeight * 0.1,
//                                             child: Center(
//                                               child: Card(
//                                                 elevation: 8,
//                                                 child: Center(
//                                                   child: InkWell(
//                                                     onTap: (() {
//                                                       // Navigator.push<void>(
//                                                       //   context,
//                                                       //   MaterialPageRoute<void>(
//                                                       //       builder: (BuildContext
//                                                       //               context) =>
//                                                       //           assignscreen(
//                                                       //             plateNumber: _vehicleResponseModel!
//                                                       //                 .vehicles[
//                                                       //                     index]
//                                                       //                 .plateNumber,
//                                                       //             lNumber:
//                                                       //                 '${widget.licenseNumber}',
//                                                       //           )),
//                                                       // );
//                                                     }),
//                                                     child: ListTile(
//                                                         leading: Container(
//                                                           width: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .width *
//                                                               0.18,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: const Color
//                                                                     .fromARGB(
//                                                                 255,
//                                                                 220,
//                                                                 242,
//                                                                 255),
//                                                             border: Border.all(
//                                                               color: Colors
//                                                                   .blueGrey,
//                                                               width: 2,
//                                                             ),
//                                                             image: const DecorationImage(
//                                                                 image: AssetImage(
//                                                                     'assets/images/car2.png'),
//                                                                 fit: BoxFit
//                                                                     .fill),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         6.0),
//                                                           ),
//                                                         ),
//                                                         title: Container(
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   bottom: 15),
//                                                           child: Text(
//                                                             _vehicleResponseModel!
//                                                                 .vehicles[index]
//                                                                 .vehicleName,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color: Colors
//                                                                   .grey[500],
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         subtitle: Container(
//                                                           child: _vehicleResponseModel!
//                                                                       .vehicles[
//                                                                           index]
//                                                                       .driver!
//                                                                       .driverName ==
//                                                                   null
//                                                               ? Text(
//                                                                   "Unassigned",
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     color: Colors
//                                                                             .grey[
//                                                                         500],
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                   ),
//                                                                 )
//                                                               : Text(
//                                                                   _vehicleResponseModel!
//                                                                       .vehicles[
//                                                                           index]
//                                                                       .driver!
//                                                                       .driverName,
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     color: Colors
//                                                                             .grey[
//                                                                         500],
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                   ),
//                                                                 ),
//                                                         ),
//                                                         trailing: Container(
//                                                           width: screenWidth *
//                                                               0.48,
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Text(_vehicleResponseModel!
//                                                                   .vehicles[
//                                                                       index]
//                                                                   .plateNumber),
//                                                               Container(
//                                                                   height: screenHeight *
//                                                                       0.045,
//                                                                   width:
//                                                                       screenWidth *
//                                                                           0.25,
//                                                                   margin:
//                                                                       const EdgeInsets
//                                                                           .only(
//                                                                     left: 25,
//                                                                   ),
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     borderRadius:
//                                                                         BorderRadius
//                                                                             .circular(6),
//                                                                     color:
//                                                                         kPrimaryColor,
//                                                                   ),
//                                                                   child:
//                                                                       const Center(
//                                                                     child: Text(
//                                                                       "On Stock",
//                                                                       style: TextStyle(
//                                                                           color:
//                                                                               Colors.white),
//                                                                     ),
//                                                                   )),
//                                                             ],
//                                                           ),
//                                                         )),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       );
//                                     }))
//                           ])))));
//   }
// }
