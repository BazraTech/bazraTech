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
    final backgroundColor = Color.fromRGBO(178, 142, 22, 1);
    final textColor = determineTextColor(backgroundColor);
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
          decoration: BoxDecoration(color: backgroundColor),
          child: Container(
            width: screenWidth,
            child: Center(
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(12),
                indicatorColor: Colors.white,
                isScrollable: false,
                indicatorWeight: 3,
                labelPadding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    child: Text(
                      AppLocalizations.of(context)?.translate("Home") ?? "Home",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontFamily: 'Roboto',
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
                        fontSize: 13,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.messenger),
                    child: Text(
                      AppLocalizations.of(context)?.translate("Message") ??
                          "Message",
                      style: const TextStyle(
                        fontSize: 13,
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

Color determineTextColor(Color backgroundColor) {
  // Calculate the luminance of the background color
  final luminance = (0.299 * backgroundColor.red +
          0.587 * backgroundColor.green +
          0.114 * backgroundColor.blue) /
      255;

  // If the luminance is greater than 0.5, use black text color, otherwise use white text color
  return luminance > 0.5 ? Colors.black : Colors.white;
}
