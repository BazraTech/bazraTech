import 'package:bazralogin/Model/report.dart';
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        // color: Colors.white,
        height: 70,
        child: Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        reportAttributes.travelPlace,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Text(
                      "${reportAttributes.totalTraveltime}hr",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),

                    Text(
                      "${reportAttributes.speedOfcar}Km/hr",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),

                    // Spacer(),
                    Text(
                      "Start"
                      " ${reportAttributes.dateOftravelstart}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
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
      ),
    );
  }
}
