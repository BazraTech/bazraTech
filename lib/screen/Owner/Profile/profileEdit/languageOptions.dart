import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';

import '../../../../../controller/Localization.dart';



class languageOption extends StatefulWidget {
  const languageOption({super.key});

  @override
  State<languageOption> createState() => _languageOptionState();
}

class _languageOptionState extends State<languageOption> {
  TextEditingController englishcontoller = TextEditingController();
  TextEditingController amahariccontoller = TextEditingController();
  TextEditingController afanoromocontoller = TextEditingController();
  bool isSelect = false;
  bool isamaharic = false;
  bool _isChecked = false;
  bool isafanoromo = false;
  var locale;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final TranslationController controller = Get.put(TranslationController());
    print(Locale('hi', 'IN'));

    return Scaffold(
      body: Container(
        height: screenHeight,
        margin: EdgeInsets.only(top: screenHeight * 0.1),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Ionicons.chevron_back)),
                Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.1),
                    child: Text(
                      TranslationUtil.text('Language'),
                      style: TextStyle(fontSize: 23),
                    )),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                      height: screenHeight * 0.1,
                      width: screenWidth - 32,
                      child: Card(
                        child: Row(
                          children: [
                            Checkbox(
                                shape: CircleBorder(),
                                activeColor: Colors.green,
                                value: isSelect,
                                onChanged: ((value) {
                                  setState(() {
                                    isSelect = value!;
                                    locale = 'en_us';
                                    final translationController =
                                        Get.put(TranslationController());
                                    translationController
                                        .loadTranslations(locale);
                                    Get.updateLocale(Locale(locale));
                                  });
                                })),
                            Text("English"),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                    width: screenWidth - 32,
                    child: Card(
                      child: Row(
                        children: [
                          Checkbox(
                              shape: CircleBorder(),
                              activeColor: Colors.green,
                              value: isamaharic,
                              onChanged: ((value) {
                                setState(() {
                                  isamaharic = value!;
                                  locale = 'am_AM';
                                  final translationController =
                                      Get.put(TranslationController());
                                  translationController
                                      .loadTranslations(locale);
                                  Get.updateLocale(Locale(locale));
                                });
                              })),
                          Text("Amaharic")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(
                      height: screenHeight * 0.1,
                      width: screenWidth - 32,
                      child: Card(
                        child: Row(children: [
                          Checkbox(
                              activeColor: Colors.green,
                              shape: CircleBorder(),
                              value: isafanoromo,
                              onChanged: ((value) {
                                setState(() {
                                  isafanoromo = value!;
                                  locale = 'a_OR';

                                  final translationController =
                                      Get.put(TranslationController());
                                  translationController
                                      .loadTranslations(locale);
                                  Get.updateLocale(Locale(locale));
                                });
                              })),
                          Text('Afaan Oromo')
                        ]),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Row(
            //   children: [
            //     Container(
            //       width: screenWidth - 32,
            //       height: screenHeight * 0.07,
            //       child: ElevatedButton(
            //         onPressed: () async {},
            //         child: Center(
            //             child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               " Save",
            //               style: TextStyle(
            //                   fontWeight: FontWeight.w500, fontSize: 18),
            //             ),
            //           ],
            //         )),
            //         style: ButtonStyle(
            //             backgroundColor:
            //                 MaterialStateProperty.resolveWith((states) {
            //               if (states.contains(MaterialState.pressed)) {
            //                 return Color.fromRGBO(255, 148, 165, 223);
            //               }
            //               // 98, 172, 181
            //               return Colors.lightBlue;
            //             }),
            //             shape:
            //                 MaterialStateProperty.all<RoundedRectangleBorder>(
            //                     RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(6)))),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
