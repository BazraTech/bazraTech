import 'package:bazralogin/Model/item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feedproducts extends StatefulWidget {
  Feedproducts({super.key});

  @override
  State<Feedproducts> createState() => _FeedproductsState();
}

class _FeedproductsState extends State<Feedproducts> {
  @override
  Widget build(BuildContext context) {
    Car carAttributes = Provider.of<Car>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context)
          //     .pushNamed(AppRoutes.mapTracking, arguments: carAttributes.id);
        },
        child: Container(
          width: 10,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).backgroundColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 45),
                          width: double.infinity,
                          constraints: BoxConstraints(
                              minHeight: 100,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.4),
                          child: Image.network(
                            carAttributes.image,
                            //   fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Car name :"),
                        Spacer(),
                        Text(
                          carAttributes.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Car ID :"),
                        Spacer(),
                        Text(carAttributes.id)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Time :"),
                        Spacer(),
                        Text(carAttributes.time)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Distance :"),
                        Spacer(),
                        Text("${carAttributes.distance}"),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
