import 'package:bazralogin/Model/Reportmodel.dart';
import 'package:bazralogin/Model/car.dart';

import 'package:bazralogin/Route/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class newReport extends StatefulWidget {
  String? date;

  newReport({
    super.key,
    required this.date,
  });

  @override
  State<newReport> createState() => _newReportState();
}

class _newReportState extends State<newReport> {
  List<TravelReport> _categoryList = [];
  @override
  Widget build(BuildContext context) {
    TravelReport reportAttributes = Provider.of<TravelReport>(context);
    
    return Scaffold(
      body: Card(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  reportAttributes.travelPlace,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "${reportAttributes.totalTraveltime}hr",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "${reportAttributes.speedOfcar}Km/hr",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              // Spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Start"
                  " ${widget.date}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  margin: EdgeInsets.only(left: 290),
                  child: Text("End "
                      "${widget.date}"),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
