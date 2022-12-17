import 'package:bazralogin/Page/Screen/communication/seachdriver.dart';
import 'package:bazralogin/const/color.dart';
import 'package:flutter/material.dart';

class Communication extends StatefulWidget {
  const Communication({super.key});

  @override
  State<Communication> createState() => _CommunicationState();
}

class _CommunicationState extends State<Communication> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // decoration: BoxDecoration(boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 1,
                          //     spreadRadius: 1,
                          //   )
                          // ]),
                          child: TextFormField(
                            minLines: 5,
                            maxLines: 6,
                            controller: _controller,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: " write message",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.black!, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width,
                    child: Seardriver(
                      onChangeman: null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: (() {
                            print(_controller.text);
                          }),
                          child: Text("send"),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return ColorsConsts.backgroundColor;
                                }
                                return const Color.fromRGBO(69, 92, 128, 1);
                              }),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color:
                                              Color.fromRGBO(162, 184, 212, 1)),
                                      borderRadius:
                                          BorderRadius.circular(22)))),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
