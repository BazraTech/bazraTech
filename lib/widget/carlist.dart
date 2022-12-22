import 'package:bazralogin/Model/car.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feedcar extends StatefulWidget {
  Feedcar({super.key});

  @override
  State<Feedcar> createState() => _FeedcarState();
}

class _FeedcarState extends State<Feedcar> {
  @override
  Widget build(BuildContext context) {
    Car carAttributes = Provider.of<Car>(context);

    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.display,
                arguments: {"id": carAttributes.name});
          },
          child: Container(
            width: 5,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: Card(
                child: Container(
                  height: 30,
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 2,
                          ),
                          image: DecorationImage(
                              image: AssetImage(carAttributes.image),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              " ${carAttributes.id}",
                              style: TextStyle(fontSize: 13),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 5),
                //   margin: EdgeInsets.only(left: 5, right: 3),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(
                //         height: 4,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("Car ID :"),
                //           Spacer(),
                //           Text(carAttributes.id)
                //         ],
                //       ),
                //     ],
                //   ),
                // )),
              ),
            ),
          ),
        ));
  }
}
