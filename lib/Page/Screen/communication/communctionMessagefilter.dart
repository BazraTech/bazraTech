// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:substring_highlight/substring_highlight.dart';

// class Seaccar extends StatefulWidget {
//   const Seaccar({super.key});

//   @override
//   State<Seaccar> createState() => _SeaccarState();
// }

// class _SeaccarState extends State<Seaccar> {
//   bool isLoading = false;

//   late List<String> autoCompleteData;

//   late TextEditingController controller;

//   Future fetchAutoCompleteData() async {
//     setState(() {
//       isLoading = true;
//     });

//     final String stringData = await rootBundle.loadString("assets/data.json");

//     final List<dynamic> json = jsonDecode(stringData);

//     final List<String> jsonStringData = json.cast<String>();

//     setState(() {
//       isLoading = false;
//       autoCompleteData = jsonStringData;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchAutoCompleteData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//           body: Column(
//         children: [
//           Container(
//             child: isLoading
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Container(
//                       child: Column(
//                         children: [
//                           Autocomplete(
//                             optionsBuilder:
//                                 (TextEditingValue textEditingValue) {
//                               if (textEditingValue.text.isEmpty) {
//                                 return const Iterable<String>.empty();
//                               } else {
//                                 return autoCompleteData.where((word) => word
//                                     .toLowerCase()
//                                     .contains(
//                                         textEditingValue.text.toLowerCase()));
//                               }
//                             },
//                             optionsViewBuilder: (context,
//                                 Function(String) onSelected, options) {
//                               return Container(
//                                 height: 60,
//                                 width: 200,
//                                 child: Material(
//                                   elevation: 4,
//                                   child: Container(
//                                     child: ListView.separated(
//                                       padding: EdgeInsets.zero,
//                                       itemBuilder: (context, index) {
//                                         final option = options.elementAt(index);

//                                         return Container(
//                                           child: ListTile(
//                                             // title: Text(option.toString()),
//                                             title: SubstringHighlight(
//                                               text: option.toString(),
//                                               term: controller.text,
//                                               textStyleHighlight: TextStyle(
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                             subtitle: Text("This is subtitle"),
//                                             onTap: () {
//                                               onSelected(option.toString());
//                                             },
//                                           ),
//                                         );
//                                       },
//                                       separatorBuilder: (context, index) =>
//                                           Divider(),
//                                       itemCount: options.length,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                             onSelected: (selectedString) {
//                               print(selectedString);
//                             },
//                             fieldViewBuilder: (context, controller, focusNode,
//                                 onEditingComplete) {
//                               this.controller = controller;

//                               return Container(
//                                 child: TextField(
//                                   controller: controller,
//                                   focusNode: focusNode,
//                                   onEditingComplete: onEditingComplete,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide:
//                                           BorderSide(color: Colors.grey[300]!),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide:
//                                           BorderSide(color: Colors.grey[300]!),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide:
//                                           BorderSide(color: Colors.grey[300]!),
//                                     ),
//                                     hintText: "Search Something",
//                                     prefixIcon: Icon(Icons.search),
//                                   ),
//                                 ),
//                               );
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       )),
//     );
//   }
// }
