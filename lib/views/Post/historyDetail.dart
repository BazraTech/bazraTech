import 'dart:convert';

import 'package:cargo/shared/customAppbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/cargo.dart';
import '../../shared/checkConnection.dart';
import '../../shared/storage_hepler.dart';

class cargoHistoryDetail extends StatefulWidget {
  final int? cargoId;
  cargoHistoryDetail({super.key, required this.cargoId});

  @override
  State<cargoHistoryDetail> createState() => _cargoHistoryDetailState();
}

class _cargoHistoryDetailState extends State<cargoHistoryDetail> {
  Future? futureCargo;
  fetchCargoDetail() async {
    StorageHelper storageHelper = StorageHelper();
    String? accessToken = await storageHelper.getToken();
    final response = await http.get(
        Uri.parse(
            'http://64.226.104.50:9090/Api/Cargo/All/Cargos/${widget.cargoId}'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        });

    if (response.statusCode == 200) {
      Map cargoJson = json.decode(response.body);
      return Cargo.fromJson(cargoJson);
    } else {
      throw Exception(
          'Failed load data with status code ${response.statusCode}');
    }
  }

  bool? _isConnected;

  @override
  void initState() {
    super.initState();
    checkInternetConnection().then((value) {
      setState(() {
        _isConnected = value;
      });
    });
    futureCargo = fetchCargoDetail();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cargo Detail",
        showBackButton: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: futureCargo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Cargo cargo = snapshot.data!;
              return Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("From"),
                        trailing: Text('${cargo.pickUp}'),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("To"),
                        trailing: Text('${cargo.dropOff}'),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("Date"),
                        trailing: Text('${cargo.date}'),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("Cargo Type"),
                        trailing: Text('${cargo.cargoType}'),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("Cargo Owner"),
                        trailing: Text('${cargo.cargoOwner}'),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("Packaging"),
                        trailing: Text('${cargo.packaging}'),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("Weight"),
                        trailing: Text('${cargo.weight}'),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("Price"),
                        trailing: Text('${cargo.price}'),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
