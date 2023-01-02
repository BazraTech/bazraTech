import 'package:bazralogin/Page/customAppBar.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';

import 'Screen/category_item.dart';
import 'Screen/sampleImage.dart';

class category_screen extends StatelessWidget {
  const category_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: CustomAppBar(
        height: 120,
        child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(top: 60, left: 290),
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                ),
                child: const Icon(
                  Icons.notification_add,
                  color: kPrimaryColor,
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Container(
          decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(20),
              )),
          child: GridView(
            padding: const EdgeInsets.all(25),
            // ignore: sort_child_properties_last
            children: sampleFiles
                .map((catData) => categoryItem(
                    catData.color, catData.title, catData.iconData))
                .toList(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 3.5 / 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          ),
        ),
      ),
    );
  }
}
