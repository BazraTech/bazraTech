import 'package:cargo/shared/constant.dart';
import 'package:flutter/material.dart';

import '../views/Post/Posts.dart';
import '../views/Work/CargoType/cargo_type.dart';

class TabNavigate extends StatefulWidget {
  const TabNavigate({super.key});

  @override
  State<TabNavigate> createState() => _TabNavigateState();
}

class _TabNavigateState extends State<TabNavigate> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.price_check),
                text: "Price",
              ),
              Tab(
                icon: Icon(Icons.category),
                text: "Cargo Type",
              ),
            ],
          ),
          title: const Text("Today's cargo Price"),
        ),
        body: const TabBarView(
          children: [
            Posts(),
            Cargo_Type(),
          ],
        ),
      ),
    );
  }
}
