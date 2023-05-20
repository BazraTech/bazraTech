import 'package:cargo/shared/customAppbar.dart';

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile",showBackButton: true,),
      body: Container(
        child: Center(child: Text("Trust the process")),
      ),
    );
  }
}
