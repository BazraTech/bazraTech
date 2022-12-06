import 'package:flutter/material.dart';

import '../Models/category_item.dart';
import '../Models/sampleImage.dart';

class category_screen extends StatelessWidget {
  const category_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notications')),
      body: Container(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 251, 250, 250),
                offset: const Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 10.0,
              )
            ],
          ),
          child: GridView(
            padding: const EdgeInsets.all(25),
            children: sampleFiles
                .map((catData) => categoryItem(
                    catData.color, catData.title, catData.iconData))
                .toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 3.5/ 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          ),
        ),
      ),
    );
  }
}
