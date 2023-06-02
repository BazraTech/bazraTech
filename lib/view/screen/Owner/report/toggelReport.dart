import 'package:flutter/material.dart';

class ContainerList extends StatelessWidget {
  final Function(int)? onContainerTap;

  ContainerList({this.onContainerTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Number of containers to display
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onContainerTap!(index);
          },
          child: Container(
            height: 100,
            color: Colors.blue,
            margin: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Container $index',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
