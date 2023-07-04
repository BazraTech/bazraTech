import 'package:cargo/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import '../Components/Communicate.dart';
import 'usermanagement/Profile.dart';
import '../Components/Tracking.dart';
import '../shared/constant.dart';
import '../Components/Home_Page.dart';

class BottomNav extends StatefulWidget {
  BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
          children: [
            CargoOWnerHomePage(),
            Tracking(),
            Communicate(),
            Profile(),
          ],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.1,
          decoration: const BoxDecoration(color: kPrimaryColor),
          child: Container(
            width: screenWidth,
            child: Center(
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(12),
                indicatorColor: Colors.white,
                isScrollable: true,
                indicatorWeight: 3,
                labelPadding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    child: Text(
                      AppLocalizations.of(context)?.translate("Home") ?? "Home",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.location_on),
                    child: Text(
                      AppLocalizations.of(context)?.translate("Tracking") ??
                          "Tracking",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.messenger),
                    child: Text(
                      AppLocalizations.of(context)?.translate("Communicate") ??
                          "Communicate",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    child: Text(
                      AppLocalizations.of(context)?.translate("Profile") ??
                          "Profile",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        letterSpacing: 2.0,
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
