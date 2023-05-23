import 'package:flutter/material.dart';

import '../shared/tapbar.dart';
import '../shared/constant.dart';

import '../views/Bill/Bill.dart';
import '../views/Notification/Notification.dart';
import '../views/Report/Report.dart';
import '../views/Work/Acticve_Work.dart';

class CargoHome extends StatefulWidget {
  const CargoHome({super.key});
  @override
  State<CargoHome> createState() => _CargoHomeState();
}

int _selectedIndex = 0;

class _CargoHomeState extends State<CargoHome> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        toolbarHeight: 80,
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          padding: const EdgeInsets.all(2.0),
          child: const CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.blue,
            ),
          ),
        ),
        title: const Text(
          "Hello Alex",
          style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontFamily: 'Roboto',
              letterSpacing: 1,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: 15),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Notifications()),
                    );
                  },
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        padding: EdgeInsets.all(10),
        child: GridView.count(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          children: [
            Container(
              color: kBackgroundColor,
              child: buildMenuItem(context, 'Active Work',
                  getCircleIcon(Icons.work, Colors.orange), 0),
            ),
            buildMenuItem(context, 'Bill',
                getCircleIcon(Icons.attach_money, Colors.blue), 1),
            buildMenuItem(context, 'Post Cargo Work',
                getCircleIcon(Icons.local_shipping, Colors.green), 2),
            buildMenuItem(context, 'Report',
                getCircleIcon(Icons.insert_chart, Colors.red), 3),
          ],
        ),
      ),
    );
  }

  Widget getCircleIcon(IconData icon, Color color) {
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.2)),
      child: Icon(icon, size: 80, color: color),
      padding: EdgeInsets.all(8),
    );
  }

  Widget buildMenuItem(
      BuildContext context, String title, Widget icon, int index) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.grey.shade600,
      margin: EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => getPageBasedOnIndex(_selectedIndex)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontFamily: 'Roboto',
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPageBasedOnIndex(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return Active_Work();
      case 1:
        return BillStatus();
      case 2:
        return TabNavigate();
      case 3:
        return Report();
      default:
        return SizedBox.shrink();
    }
  }
}

class PageScreen extends StatelessWidget {
  final String title;

  PageScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
          child: Container(
        color: kBackgroundColor,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
        ),
      )),
    );
  }
}
