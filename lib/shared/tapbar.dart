import 'package:cargo/shared/constant.dart';
import 'package:flutter/material.dart';

import '../views/Post/Posts.dart';
import '../views/Post/histrory.dart';
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
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5),
            labelStyle: TextStyle(
                letterSpacing: 2.0,
                wordSpacing: 1,
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
            isScrollable: false,
            indicatorWeight: 4,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(Icons.history),
                text: "Cargo History",
              ),
              Tab(
                icon: Icon(Icons.add),
                text: "Post Cargo",
              ),
            ],
          ),
          title: const Text("Today's cargo Price"),
        ),
        body: TabBarView(
          children: [
            CargoListView(),
            Posts(),
          ],
        ),
      ),
    );
  }
}
