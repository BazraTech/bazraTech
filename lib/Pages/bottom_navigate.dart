import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class bottom_Navigate extends StatefulWidget {
  const bottom_Navigate({super.key});

  @override
  State<bottom_Navigate> createState() => _bottom_NavigateState();
}

class _bottom_NavigateState extends State<bottom_Navigate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:null,
       bottomNavigationBar: BottomNavigationBar(
        
         type: BottomNavigationBarType.fixed, // Fixed 
  backgroundColor: Color.fromARGB(255, 168, 166, 166), // <-- This works for fixed
  selectedItemColor: Color.fromARGB(255, 240, 105, 172),
  unselectedItemColor: Color.fromARGB(255, 211, 208, 208),
             items: const <BottomNavigationBarItem>[
              
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            
            label:'Home',
  
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label:'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
          label: 'communicate'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
          label: 'Profile'
          ),
        ],
    ));
    
  }
}