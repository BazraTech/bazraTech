import 'package:bazralogin/Model/Tripmanagementmodel.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripmangeFeed extends StatefulWidget {
  final Function? onChange;
  TripmangeFeed({super.key, required this.onChange});

  @override
  State<TripmangeFeed> createState() => _TripmangeFeedState();
}

class _TripmangeFeedState extends State<TripmangeFeed> {
  @override
  Widget build(BuildContext context) {
    TripHistory reportAttributes = Provider.of<TripHistory>(context);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // margin: EdgeInsets.zero,
                          child: Text(
                            reportAttributes.travelPlace,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          child: Text(
                            "${reportAttributes.totalTraveltime}hr",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: SizedBox(
                          child: Text(
                            "${reportAttributes.speedOfcar}Km/hr",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Text(
                            "Start"
                            " ${reportAttributes.dateOftravelstart}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
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
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width - 138),
                          child: Text(
                            "End "
                            "${reportAttributes.dateOftravelstart}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
