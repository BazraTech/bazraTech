import 'package:bazralogin/Model/Reportmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:date_format/date_format.dart';
class Testwidget extends StatefulWidget {
  String ? date;
  Testwidget({
    super.key,
    required this.date,
  });

  @override
  State<Testwidget> createState() => _TestwidgetState();
}

class _TestwidgetState extends State<Testwidget> {
  
  @override
  Widget build(BuildContext context) {
    
    
    var evenNumbers;
    final carData = Provider.of<TravelReportinfo>(context);
  List<TravelReport> find = [];
  
    
    final productsList = carData.products;
    
  

  
    return SingleChildScrollView(
      child: Container(
        
      ),
    );
  }
}
