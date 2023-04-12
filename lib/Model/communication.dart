import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// communications  model
class Communications with ChangeNotifier {
  final String name;
  final String Status;
  bool value;

  Communications({
    required this.name,
    required this.Status,
    required this.value,
  });
}

// ignore: prefer_final_fields
// communications provider
class Commuicationprovider with ChangeNotifier {
  List<Communications> products = [
    Communications(
      value: false,
      name: " Abebe",
      Status: "  Assigned ",
    ),
    Communications(name: " Alex", Status: " Assigned", value: false),
    Communications(name: " Robel", Status: "Assigned", value: false),
    Communications(name: " Roman", Status: " Assigned", value: false),
    Communications(name: " Abenii", Status: " Assigned ", value: false),
    Communications(name: " Abeniim", Status: " Assigned ", value: false),
    Communications(name: " Yared", Status: "Assigned ", value: false),
    Communications(name: " Anduamlak", Status: "  Assigned  ", value: false)
  ];
  // Car findById(String productId) {
  //   return products.firstWhere((element) => element.id == productId);
  // }

  List<Communications> get product {
    return [...products];
  }

  List<Communications> searchQuery(String searchText) {
    List _searchList = products
        .where((element) =>
            element.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return [..._searchList];
  }
}
