// import 'package:flutter/material.dart';
// import 'package:orderapp/components/commoncolor.dart';
// import 'package:orderapp/controller/controller.dart';
// import 'package:orderapp/db_helper.dart';
// import 'package:orderapp/service/tableList.dart';
// import 'package:provider/provider.dart';

// class X001OrderBag extends StatefulWidget {
//    String custmerId;
//   String os;
//   String areaId;
//   String areaname;
//   String type;

//   X001OrderBag({
//     required this.areaId,
//     required this.custmerId,
//     required this.os,
//     required this.areaname,
//     required this.type,
//   });

//   @override
//   State<X001OrderBag> createState() => _X001OrderBagState();
// }

// class _X001OrderBagState extends State<X001OrderBag> {
//   @override
//     Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: P_Settings.orderFormcolor,
//         actions: [
//           // IconButton(
//           //     onPressed: () async {
//           //       await OrderAppDB.instance
//           //           .deleteFromTableCommonQuery("salesBagTable", "");
//           //       await OrderAppDB.instance
//           //           .deleteFromTableCommonQuery("salesMasterTable", "");
//           //       await OrderAppDB.instance
//           //           .deleteFromTableCommonQuery("salesDetailTable", "");
//           //     },
//           //     icon: Icon(Icons.delete)),
//           IconButton(
//             onPressed: () async {
//               List<Map<String, dynamic>> list =
//                   await OrderAppDB.instance.getListOfTables();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => TableList(list: list)),
//               );
//             },
//             icon: Icon(Icons.table_bar),
//           ),
//         ],
//       ),
//       body: GestureDetector(onTap: (() {
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus) {
//           currentFocus.unfocus();
//         }
//       }), child: Center(
//         child: Consumer<Controller>(builder: (context, value, child) {
//           if (value.isLoading) {
//             return CircularProgressIndicator();
//           } else {
//             print("value.rateEdit----${value.rateEdit}");
//             print("baglist length...........${value.bagList.length}");

//             return Provider.of<Controller>(context, listen: false)
//                         .bagList
//                         .length ==
//                     0
//                 ? Container(
//                     height: size.height * 0.9,
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             "asset/empty.png",
//                             height: 80,
//                             color: P_Settings.orderFormcolor,
//                             width: 100,
//                           ),
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           Text(
//                             "Your cart is empty !!!",
//                             style: TextStyle(fontSize: 17),
//                           ),
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   primary: P_Settings.orderFormcolor,
//                                   textStyle: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold)),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text("View products"))
//                         ],
//                       ),
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10, right: 10),
//                         child: Row(
//                           children: [
//                             OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 side: BorderSide(
//                                     width: 1.0, color: Colors.transparent),
//                               ),
//                               onPressed: () {},
//                               child: Text(
//                                 "${value.count} Items",
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                     color: P_Settings.collectionbuttnColor),
//                               ),
//                             ),
//                             Spacer(),
//                             OutlinedButton(
//                                 style: OutlinedButton.styleFrom(
//                                   side: BorderSide(
//                                       width: 1.0,
//                                       color: P_Settings.collectionbuttnColor),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text("Add Items",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color:
//                                             P_Settings.collectionbuttnColor))),
//                           ],
//                         ),
//                       ),
//                       // Divider(thickness: 2,),
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: value.bagList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return listItemFunction(
//                                 value.bagList[index]["cartrowno"],
//                                 value.bagList[index]["itemName"],
//                                 value.bagList[index]["rate"],
//                                 value.bagList[index]["totalamount"],
//                                 value.bagList[index]["qty"],
//                                 size,
//                                 value.controller[index],
//                                 index,
//                                 value.bagList[index]["code"],
//                                 value.bagList[index]["unit_name"],
//                                 value.bagList[index]["package"]);
//                           },
//                         ),
//                       ),
//                       GestureDetector(
//                         child: Container(
//                           height: size.height * 0.07,
//                           color: Colors.yellow,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(" Order Total  : ",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15)),
//                               Text(
//                                   "\u{20B9}${value.orderTotal1}",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16))
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   );
//           }
//         }),
//       )),
//     );
//   }
// Widget listItemFunction(
//       int cartrowno,
//       String itemName,
//       String rate,
//       String totalamount,
//       double qty,
//       Size size,
//       TextEditingController _controller,
//       int index,
//       String code,
//       String unit_name,
//       double pkg) {
//     // print("qty-------$qty");
//     _controller.text = qty.toString();

//     return Container(
//       height: size.height * 0.17,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
//         child: Ink(
//           // color: Colors.grey[100],
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             // borderRadius: BorderRadius.circular(20),
//           ),
//           child: ListTile(
//             onTap: () {
//               Provider.of<Controller>(context, listen: false)
//                   .rateController[index]
//                   .text = rate;
//               Provider.of<Controller>(context, listen: false).setQty(qty);
//               Provider.of<Controller>(context, listen: false)
//                   .setAmt(totalamount);
//               showModalBottomSheet<void>(
//                 isScrollControlled: true,
//                 context: context,
//                 builder: (BuildContext context) {
//                   return Consumer<Controller>(
//                     builder: (context, value, child) {
//                       return SingleChildScrollView(
//                         child: Padding(
//                           padding: MediaQuery.of(context).viewInsets,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Container(
//                               child: Wrap(
//                                 children: [
//                                   SizedBox(
//                                     height: size.height * 0.01,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       IconButton(
//                                         icon: Icon(Icons.close),
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       FloatingActionButton.small(
//                                           backgroundColor: Colors.grey,
//                                           child: Icon(Icons.remove),
//                                           onPressed: () {
//                                             if (value.qtyinc! > 1) {
//                                               value.qtyDecrement();
//                                               value.totalCalculation(value
//                                                   .rateController[index].text);
//                                             }
//                                           }),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 15.0, right: 15),
//                                         child: Text(
//                                           value.qtyinc.toString(),
//                                           style: TextStyle(fontSize: 20),
//                                         ),
//                                       ),
//                                       FloatingActionButton.small(
//                                         backgroundColor: Colors.grey,
//                                         child: Icon(Icons.add),
//                                         onPressed: () {
//                                           value.qtyIncrement();
//                                           value.totalCalculation(
//                                               value.rateController[index].text);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: size.height * 0.02,
//                                   ),
//                                   Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .settingsList1[0]["set_value"] ==
//                                           "YES"
//                                       ? Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 8.0, bottom: 8),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Rate :",
//                                                 style: TextStyle(fontSize: 17),
//                                               ),
//                                               Container(
//                                                 width: size.width * 0.2,
//                                                 child: TextField(
//                                                   onTap: () {
//                                                     value.rateController[index]
//                                                             .selection =
//                                                         TextSelection(
//                                                             baseOffset: 0,
//                                                             extentOffset: value
//                                                                 .rateController[
//                                                                     index]
//                                                                 .value
//                                                                 .text
//                                                                 .length);
//                                                   },
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   onSubmitted: (values) {
//                                                     value.totalCalculation(
//                                                         values);
//                                                   },
//                                                   textAlign: TextAlign.right,
//                                                   controller: value
//                                                       .rateController[index],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       : Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 8.0, bottom: 8),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Rate :",
//                                                 style: TextStyle(fontSize: 17),
//                                               ),
//                                               Flexible(
//                                                 child: Text(
//                                                   "\u{20B9}${rate}",
//                                                   style:
//                                                       TextStyle(fontSize: 17),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                   Divider(
//                                     thickness: 1,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 8.0, bottom: 8),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Total Price :",
//                                           style: TextStyle(
//                                               fontSize: 17,
//                                               color: P_Settings.extracolor),
//                                         ),
//                                         Flexible(
//                                           child: Text(
//                                             "\u{20B9}${value.priceval}",
//                                             style: TextStyle(
//                                                 fontSize: 17,
//                                                 color: P_Settings.extracolor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: size.height * 0.02,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             Provider.of<Controller>(context,
//                                                     listen: false)
//                                                 .updateQty(
//                                                     value.qtyinc.toString(),
//                                                     cartrowno,
//                                                     widget.custmerId,
//                                                     value.rateController[index]
//                                                         .text);
//                                             Provider.of<Controller>(context,
//                                                     listen: false)
//                                                 .calculateorderTotal(widget.os,
//                                                     widget.custmerId);
//                                             // Provider.of<Controller>(context,
//                                             //         listen: false)
//                                             //     .getBagDetails(
//                                             //         widget.custmerId,
//                                             //         widget.os);
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text("continue"))
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//             title: Column(
//               children: [
//                 Flexible(
//                   flex: 1,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           bottom: 8.0,
//                         ),
//                         child: Container(
//                           height: size.height * 0.3,
//                           width: size.width * 0.2,
//                           child: Image.network(
//                             'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
//                             fit: BoxFit.cover,
//                           ),
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(
//                         width: size.width * 0.05,
//                         height: size.height * 0.001,
//                       ),
//                       Flexible(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Flexible(
//                                   flex: 5,
//                                   child: Text(
//                                     "${itemName} ",
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18,
//                                         color: P_Settings.wavecolor),
//                                   ),
//                                 ),
//                                 Flexible(
//                                   flex: 3,
//                                   child: Text(
//                                     " (${code})",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14,
//                                         color: Colors.grey),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Flexible(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 5, top: 0),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       "Rate :",
//                                       style: TextStyle(fontSize: 13),
//                                     ),
//                                     SizedBox(
//                                       width: size.width * 0.02,
//                                     ),
//                                     Text(
//                                       "\u{20B9}${double.parse(rate).toStringAsFixed(2)}",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 15),
//                                     ),
//                                     SizedBox(
//                                       width: size.width * 0.3,
//                                     ),
//                                     Flexible(
//                                       child: IconButton(
//                                         onPressed: () {
//                                           showDialog(
//                                             context: context,
//                                             builder: (ctx) => AlertDialog(
//                                               content: Text(
//                                                   "Do you want to delete ($code) ???"),
//                                               actions: <Widget>[
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     ElevatedButton(
//                                                       style: ElevatedButton
//                                                           .styleFrom(
//                                                               primary: P_Settings
//                                                                   .wavecolor),
//                                                       onPressed: () async {
//                                                         Provider.of<Controller>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .deleteFromOrderBagTable(
//                                                                 cartrowno,
//                                                                 widget
//                                                                     .custmerId,
//                                                                 index);
//                                                         Provider.of<Controller>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .getProductList(
//                                                                 widget
//                                                                     .custmerId);
//                                                         Provider.of<Controller>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .calculateorderTotal(
//                                                                 widget.os,
//                                                                 widget
//                                                                     .custmerId);
//                                                         Provider.of<Controller>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .countFromTable(
//                                                           "orderBagTable",
//                                                           widget.os,
//                                                           widget.custmerId,
//                                                         );
//                                                         Navigator.of(ctx).pop();
//                                                       },
//                                                       child: Text("Ok"),
//                                                     ),
//                                                     SizedBox(
//                                                       width: size.width * 0.01,
//                                                     ),
//                                                     ElevatedButton(
//                                                       style: ElevatedButton
//                                                           .styleFrom(
//                                                               primary: P_Settings
//                                                                   .wavecolor),
//                                                       onPressed: () {
//                                                         Navigator.of(ctx).pop();
//                                                       },
//                                                       child: Text("Cancel"),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                         icon: Icon(
//                                           Icons.delete,
//                                           size: 17,
//                                         ),
//                                         color: P_Settings.extracolor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Flexible(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 5, top: 0),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       "Qty :",
//                                       style: TextStyle(fontSize: 13),
//                                     ),
//                                     SizedBox(
//                                       width: size.width * 0.02,
//                                     ),
//                                     Container(
//                                       child: Text(
//                                         "${qty.toString()}  (${unit_name.toString()})   (${pkg.toString()})",
//                                         textAlign: TextAlign.right,
//                                         style: TextStyle(fontSize: 13),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   thickness: 1,
//                   color: Color.fromARGB(255, 182, 179, 179),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Total price : ",
//                         style: TextStyle(fontSize: 13),
//                       ),
//                       Flexible(
//                         child: Text(
//                           "\u{20B9}${double.parse(totalamount).toStringAsFixed(2)}",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                               color: P_Settings.extracolor),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }