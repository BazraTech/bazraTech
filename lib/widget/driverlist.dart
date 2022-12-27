import 'package:bazralogin/Model/car.dart';
import 'package:bazralogin/Model/communica.dart';
import 'package:bazralogin/Page/Screen/communication/Communication.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feeddriver extends StatefulWidget {
  final Function? selectAll;
  Feeddriver({super.key, required this.selectAll});

  @override
  State<Feeddriver> createState() => _FeeddriverState();
}

List<Communications> productk = [];
List multipleSelected = [];

class _FeeddriverState extends State<Feeddriver> {
  @override
  Widget build(BuildContext context) {
    Communications carAttributes = Provider.of<Communications>(context);

    return Scaffold(
      body: Card(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  carAttributes.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              // Spacer(),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 0, 2, 0),
                child: Transform.scale(
                  scale: 0.8,
                  child: InkWell(
                    onTap: (){},
                    child: Checkbox(
                        activeColor: Colors.green,
                        value: carAttributes.value,
                        onChanged: (value) => setState(() {
                              carAttributes.value = !carAttributes.value;
                              selectAll(value);
                            })),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(carAttributes.Status),
              )
            ],
          ),
        ],
      )),
    );
  }

  void selectAll(bool? value) {
    setState(() {
      productk.clear();
      for (var element in productk) {
        if (element.value == false) {
          element.value = true;
          multipleSelected.add(element);
          print(element);
        } else {
          element.value = false;
          multipleSelected.remove(element);
        }
      }
    });
  }
}
