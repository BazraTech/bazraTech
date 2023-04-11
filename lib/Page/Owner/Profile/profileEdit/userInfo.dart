import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../config/APIService.dart';

class SearchDataFromAPI extends StatefulWidget {
  @override
  _SearchDataFromAPIState createState() => _SearchDataFromAPIState();
}

class _SearchDataFromAPIState extends State<SearchDataFromAPI> {
  List datalist = [];
  List filteredData = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  // Fetch data from API
  fetchData() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.driverApi);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      await storage.write(
          key: "totalDrivers", value: data["totalDrivers"].toString());

      // Store all data in filteredData initially

      setState(() {
        filteredData = data['drivers'];
        datalist = filteredData;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // Filter data based on search query
  void filterSearchResult(String searchQuery) {
    List filtered = [];
    setState(() {
      filteredData = datalist.where((driver) {
        final name = driver['driverName'].toLowerCase();

        final inputName = searchQuery.toLowerCase();
        final inputLicense = searchQuery.toLowerCase();
        return name.contains(inputName);
      }).toList();
    });
    setState(() {
      filteredData = filteredData;
    });

    // filteredData = data.where((driver) {
    //   final name = driver['driverName'].toLowerCase();

    //   final inputName = searchQuery.toLowerCase();
    //   final inputLicense = searchQuery.toLowerCase();
    //   return name.contains(inputName);
    // }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(filteredData);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Data from API"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: IconButton(
                        onPressed: () {
                          searchController.clear();
                          filterSearchResult("");
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    onChanged: (value) {
                      filterSearchResult(value);
                    },
                  ),
                ),
                // List of search results
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredData == null ? 0 : filteredData!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title:
                            Text(filteredData![index]['driverName'].toString()),
                        subtitle: Text(filteredData![index]['id'].toString()),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
