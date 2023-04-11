
import 'package:bazralogin/Route/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/TrapManagementMode.dart';

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
        child: Card(
            margin: EdgeInsets.zero,
            elevation: 15,
            child: Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            // margin: EdgeInsets.zero,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: SizedBox(
                              // width: 100,
                              // // height: ,
                              child: Text(
                                reportAttributes.travelPlace,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // VerticalDivider(
                        //   thickness: 2,
                        //   // width: 20,
                        //   color: Colors.red,
                        // ),
                        Divider(
                          color: Colors.black,
                          thickness: 0.3,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            "${reportAttributes.totalTraveltime}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // VerticalDivider(
                        //   thickness: 2,
                        //   // width: 20,
                        //   color: Colors.red,
                        // ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Text(
                            "${reportAttributes.speedOfcar} ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          // margin: EdgeInsets.only(right: 5),
                          child: Text(
                            " ${reportAttributes.dateOftravelstart}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          child: Text("-"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          // margin: EdgeInsets.only(
                          //     left: MediaQuery.of(context).size.width - 138),
                          child: Text(
                            "${reportAttributes.dateOftravelend}",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
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