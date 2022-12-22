// ignore: file_names
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
          padding: const EdgeInsets.all(0.0),
          child: Container(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 45),
                    height: 220,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: SizedBox(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width - 16,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: TextFormField(
                                      minLines: 5,
                                      maxLines: 6,
                                      controller: _controller,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        hintText: " write message",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.black!, width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 35,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                    onPressed: (() {
                                    }),
                                    child: const Text("send"),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return ColorsConsts.backgroundColor;
                                          }
                                          return const Color.fromRGBO(
                                              69, 92, 128, 1);
                                        }),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color: Color.fromRGBO(
                                                        162, 184, 212, 1)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        22)))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 210,
                    width: MediaQuery.of(context).size.width,
                    child: const Searchdriver(
                      onChangeman: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
