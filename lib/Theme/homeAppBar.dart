import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';

class HomePageCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;
  final Widget child;
  const HomePageCustomAppBar(
      {super.key, required this.child, this.height = kToolbarHeight});
  @override
  Size get preferredSize => Size.fromHeight(height);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      height: preferredSize.height,
      //color: kPrimaryColor,
      alignment: Alignment.center,
      
      // decoration: const BoxDecoration(
      //     color: kPrimaryColor,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(0),
      //       topRight: Radius.circular(0),
      //       bottomLeft: Radius.circular(40),
      //       bottomRight: Radius.circular(40),
      //     )),
    );
  }
}
