import 'package:bazralogin/Page/Screen/Tripmanegemnet/TripHistorysearch.dart';
import 'package:flutter/material.dart';

class Tripmanegement extends StatelessWidget {
  const Tripmanegement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(247, 250, 252, 1),
          margin: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.zero,
                child: SearchTriphistory(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
