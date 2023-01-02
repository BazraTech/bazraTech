import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import '../../Model/category.dart';

const sampleFiles = const [
  Category(
    id: 'bazra one',
    title: 'Vehicle',
    color: kPrimaryColor,
    iconData: Icons.directions_car,
  ),
  Category(
    id: 'bazra two',
    title: 'Driver',
    color: Colors.red,
    iconData: Icons.person_add,
  ),
  Category(
    id: 'bazra three',
    title: 'On Route',
    color: Colors.white,
    iconData: Icons.route_outlined,
  ),
  Category(
      id: 'bazra four',
      title: 'Report',
      color: Colors.white,
      iconData: Icons.report),
  Category(
    id: 'bazra five',
    title: 'Available Market',
    color: Colors.white,
    iconData: Icons.store_mall_directory_outlined,
  ),
  Category(
      id: 'bazra six',
      title: 'Trip Managment',
      color: kPrimaryColor,
      iconData: Icons.connecting_airports),
];
