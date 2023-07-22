// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';
import 'AcceptedCargo.dart';
import 'Active.dart';
import 'FinishedCargo.dart';

class Work_BottomNav extends StatefulWidget {
  Work_BottomNav({super.key});

  @override
  _Work_BottomNavState createState() => _Work_BottomNavState();
}

class _Work_BottomNavState extends State<Work_BottomNav>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final backgroundColor = Color.fromRGBO(178, 142, 22, 1);
    return WillPopScope(
      onWillPop: () async {
        if (_tabController!.index > 0) {
          _tabController!.animateTo(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: _tabController,
          children: const [
            ActiveCargo(),
            AcceptedCargo(),
            FinishedCargo(),
          ],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.1,
          decoration: BoxDecoration(color: backgroundColor),
          child: SizedBox(
            width: screenWidth,
            child: Center(
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                indicatorColor: Colors.white,
                isScrollable: false,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.remove_circle_outline),
                    child: Text(
                      AppLocalizations.of(context)?.translate("Active") ??
                          "Active",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Tab(
                      icon: Icon(Icons.thumb_up),
                      child: Text(
                        "Accepted",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    icon: const Icon(Icons.verified),
                    child: Text(
                      AppLocalizations.of(context)?.translate("Finished") ??
                          "Finished",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}