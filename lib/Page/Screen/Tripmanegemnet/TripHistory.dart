import 'package:bazralogin/Page/Screen/Tripmanegemnet/TripHistorysearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';

class TripHistorys extends StatelessWidget {
  const TripHistorys({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(247, 250, 252, 1),
          margin: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         width: 200,
              //         height: 50,
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(32)),
              //         child: Card(
              //           child: Row(
              //             children: [
              //               Text(" Current Status "),
              //               Text(
              //                 " On Route ",
              //                 style: TextStyle(
              //                     color: const Color.fromRGBO(25, 205, 54, 1)),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SearchTriphistory(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
