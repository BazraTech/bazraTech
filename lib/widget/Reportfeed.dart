import 'package:bazralogin/Model/Reportmodel.dart';
import 'package:bazralogin/Model/car.dart';

import 'package:bazralogin/Route/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Reportfeed extends StatefulWidget {
  final Function? onChange;
  Reportfeed({super.key, required this.onChange});

  @override
  State<Reportfeed> createState() => _ReportfeedState();
}

class _ReportfeedState extends State<Reportfeed> {
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
                  " ${reportAttributes.dateOftravelstart}",
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
                  margin: EdgeInsets.only(left: 310),
                  child: Text("End "
                      "${reportAttributes.dateOftravelstart}"),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
