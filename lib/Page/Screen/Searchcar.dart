// import 'package:bazralogin/Model/car.dart';
// import 'package:bazralogin/widget/carlist.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Searchscreen extends StatefulWidget {
//   const Searchscreen({super.key});

//   @override
//   State<Searchscreen> createState() => _SearchscreenState();
// }

// class _SearchscreenState extends State<Searchscreen> {
//   TextEditingController? _searchTextController;
//   final FocusNode _node = FocusNode();
//   void initState() {
//     super.initState();
//     _searchTextController = TextEditingController();
//     _searchTextController?.addListener(() {
//       setState(() {
//         isWidget = true;
//       });
//     });
//   }

//   bool isWidget = false;
//   @override
//   void dispose() {
//     super.dispose();
//     _node.dispose();
//     _searchTextController?.dispose();
//   }

//   List<Car> _searchList = [];
//   @override
//   Widget build(BuildContext context) {
//     final carData = Provider.of<Carinfo>(context);
//     final productsList = carData.products;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 60),
//               child: TextField(
//                 controller: _searchTextController,
//                 minLines: 1,
//                 focusNode: _node,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(
//                       width: 0,
//                       style: BorderStyle.none,
//                     ),
//                   ),
//                   prefixIcon: Icon(
//                     Icons.search,
//                   ),
//                   hintText: 'Search',
//                   filled: true,
//                   fillColor: Theme.of(context).cardColor,
//                   suffixIcon: IconButton(
//                     onPressed: _searchTextController!.text.isEmpty
//                         ? null
//                         : () {
//                             _searchTextController!.clear();
//                             _node.unfocus();
//                           },
//                     icon: Icon(Icons.close,
//                         color: _searchTextController!.text.isNotEmpty
//                             ? Colors.red
//                             : Colors.grey),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   _searchTextController!.text.toLowerCase();
//                   setState(() {
//                     _searchList = carData.searchQuery(value);
//                     isWidget = true;
//                   });
//                 },
//               ),
//             ),
//             Container(
//                 child: _searchTextController!.text.isNotEmpty &&
//                         _searchList.isEmpty
//                     ? Column(
//                         children: [
//                           SizedBox(
//                             height: 50,
//                           ),
//                           Icon(
//                             Icons.search,
//                             size: 60,
//                           ),
//                           SizedBox(
//                             height: 50,
//                           ),
//                           Text(
//                             'No results found',
//                             style: TextStyle(
//                                 fontSize: 30, fontWeight: FontWeight.w700),
//                           ),
//                         ],
//                       )
//                     : isWidget
//                         ? null
//                         : Container(
//                             height: MediaQuery.of(context).size.height - 300,
//                             child: ListView(
//                               physics: NeverScrollableScrollPhysics(),
//                               children: List.generate(
//                                   _searchTextController!.text.isEmpty
//                                       ? 4
//                                       : _searchList.length, (index) {
//                                 return ChangeNotifierProvider.value(
//                                   value: _searchTextController!.text.isEmpty
//                                       ? productsList[index]
//                                       : _searchList[index],
//                                   child:
//                                       Container(height: 65, child: Feedcar()),
//                                 );
//                               }),
//                             ),
//                           )
//                 // : GridView(
//                 //     physics: NeverScrollableScrollPhysics(),
//                 //     gridDelegate:
//                 //         const SliverGridDelegateWithMaxCrossAxisExtent(
//                 //       childAspectRatio: 3.5 / 4,
//                 //       maxCrossAxisExtent: 220,
//                 //       crossAxisSpacing: 20,
//                 //       mainAxisSpacing: 20,
//                 //     ),
//                 //     shrinkWrap: true,
//                 //     children: List.generate(
//                 //         _searchTextController!.text.isEmpty
//                 //             ? productsList.length
//                 //             : _searchList.length, (index) {
//                 //       return ChangeNotifierProvider.value(
//                 //         value: _searchTextController!.text.isEmpty
//                 //             ? productsList[index]
//                 //             : _searchList[index],
//                 //         child: Feedproducts(),
//                 //       );
//                 //     }),
//                 //   ),
//                 )
//           ],
//         ),
//       ),
//     );
//   }
// }
