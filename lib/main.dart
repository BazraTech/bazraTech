import 'dart:convert';
import 'package:cargo/shared/storage_hepler.dart';
import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:cargo/views/Post/histrory.dart';
import 'package:cargo/views/Post/practice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cargo/views/login.dart';

import 'Components/Available.dart';
import 'Components/Home_Page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Cargo_login(),
  ));
}
