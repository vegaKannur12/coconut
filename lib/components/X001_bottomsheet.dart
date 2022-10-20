import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class CoconutSheet {
  List rawCalcResult = [];
  List splitted = [];
  String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);
  showsalesMoadlBottomsheet(
      String item,
      String code,
      // String hsn,
      double? qty,
      double? rate,
      // double? dis_per,
      // double? dis_amt,
      // double? tax_per,
      double? tax_amt,
      // double? cess_per,
      // double? cess_amt,
      // double? net_amt,
      // double gross,
      BuildContext context,
      Size size,
      // int index,
      // String customerId,
      // String os,
      double pkg,
      List? unitList) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          print("param---$pkg-----$rate--$item....$code....$qty--$unitList--");
          // rawCalcResult = Provider.of<Controller>(context,listen: false).rawCalculation(rate,qty.toDouble(), 0.0, 100,tax_per, 0.0, "0", 0);

          // value.discount_prercent[index].text = dis_per.toString();
          // value.discount_amount[index].text = dis_amt.toString();
          // value.salesqty[index].text = qty.toString();
          return Consumer<Controller>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                child: Container(
                  // height: size.height * 0.96,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: value.isLoading
                        ? SpinKitFadingCircle(
                            color: Colors.green,
                          )
                        : Column(
                            // mainAxisSize:MainAxisSize.min ,
                            // spacing: 5,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: P_Settings.extracolor,
                                      )),
                                ],
                              ),

                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                      Text("-"),
                                      Text(
                                        code,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Divider(
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    // Text(
                                    //   "Unit :",
                                    //   style: TextStyle(fontSize: 15),
                                    // ),
                                    // Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: dropDownRoute(size),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Qty",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                      "qty",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Rate",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                      "rate",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(15.0),
                              //   child: Row(
                              //     children: [
                              //       Text(
                              //         "Qty",
                              //         style: TextStyle(fontSize: 15),
                              //       ),
                              //       Spacer(),
                              //       Container(
                              //         width: size.width * 0.2,
                              //         child: TextField(
                              //           onTap: () {
                              //             // value.salesqty[index].selection =
                              //             //     TextSelection(
                              //             //         baseOffset: 0,
                              //             //         extentOffset: value.salesqty[index]
                              //             //             .value.text.length);
                              //           },
                              //           // autofocus: true,
                              //           style: TextStyle(
                              //             fontSize: 15.0,
                              //           ),
                              //           decoration: InputDecoration(
                              //             isDense: true,
                              //             contentPadding: EdgeInsets.all(0),
                              //             //border: InputBorder.none
                              //           ),

                              //           // maxLines: 1,
                              //           // minLines: 1,
                              //           keyboardType: TextInputType.number,
                              //           onSubmitted: (values) {
                              //             print("values----$values");
                              //             double valueqty = 0.0;
                              //             // value.discount_amount[index].text=;
                              //             if (values.isNotEmpty) {
                              //               print("emtyyyy");
                              //               valueqty = double.parse(values);
                              //             } else {
                              //               valueqty = 0.00;
                              //             }
                              //             Provider.of<Controller>(context,
                              //                     listen: false)
                              //                 .fromDb = false;
                              //             // Provider.of<Controller>(context,
                              //             //         listen: false)
                              //             //     .rawCalculation(
                              //             //         double.parse(
                              //             //             value.salesrate[index].text),
                              //             //         valueqty,
                              //             //         dis_per!,
                              //             //         dis_amt!,
                              //             //         tax_per!,
                              //             //         0.0,
                              //             //         value.settingsList1[1]['set_value']
                              //             //             .toString(),
                              //             //         0,
                              //             //         index,
                              //             //         true,
                              //             //         "qty");
                              //           },
                              //           textAlign: TextAlign.right,
                              //           // controller: value.salesqty[index],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Provider.of<Controller>(context, listen: false)
                              //             .settingsList1[0]["set_value"] ==
                              //         "YES"
                              //     ? Padding(
                              //         padding: const EdgeInsets.all(15.0),
                              //         child: Row(
                              //           children: [
                              //             Text(
                              //               "Rate",
                              //               style: TextStyle(fontSize: 15),
                              //             ),
                              //             Spacer(),
                              //             Container(
                              //               width: size.width * 0.2,
                              //               child: TextField(
                              //                 onTap: () {
                              //                   // value.salesrate[index].selection =
                              //                   //     TextSelection(
                              //                   //         baseOffset: 0,
                              //                   //         extentOffset: value
                              //                   //             .salesrate[index]
                              //                   //             .value
                              //                   //             .text
                              //                   //             .length);
                              //                 },
                              //                 style: TextStyle(
                              //                   fontSize: 15.0,
                              //                 ),
                              //                 decoration: InputDecoration(
                              //                   isDense: true,
                              //                   contentPadding: EdgeInsets.all(
                              //                       0), //  <- you can it to 0.0 for no space

                              //                   //border: InputBorder.none
                              //                 ),
                              //                 keyboardType: TextInputType.number,
                              //                 onSubmitted: (values) {
                              //                   print("values----$values");
                              //                   double valuerate = 0.0;
                              //                   // value.discount_amount[index].text=;
                              //                   if (values.isNotEmpty) {
                              //                     print("emtyyyy");
                              //                     valuerate = double.parse(values);
                              //                   } else {
                              //                     valuerate = 0.00;
                              //                   }
                              //                   Provider.of<Controller>(context,
                              //                           listen: false)
                              //                       .fromDb = false;

                              //                   // Provider.of<Controller>(context,
                              //                   //         listen: false)
                              //                   //     .rawCalculation(
                              //                   //         valuerate,
                              //                   //         double.parse(value
                              //                   //             .salesqty[index].text),
                              //                   //         dis_per!,
                              //                   //         dis_amt!,
                              //                   //         tax_per!,
                              //                   //         0.0,
                              //                   //         value.settingsList1[1]
                              //                   //                 ['set_value']
                              //                   //             .toString(),
                              //                   //         0,
                              //                   //         index,
                              //                   //         true,
                              //                   //         "qty");
                              //                 },
                              //                 textAlign: TextAlign.right,
                              //                 // decoration: InputDecoration(
                              //                 //   border: InputBorder.none,
                              //                 // ),
                              //                 // controller: value.salesrate[index],
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       )
                              //     : Padding(
                              //         padding: const EdgeInsets.all(15.0),
                              //         child: Row(
                              //           children: [
                              //             Text(
                              //               "Rate",
                              //               style: TextStyle(fontSize: 15),
                              //             ),
                              //             Spacer(),
                              //             Text("\u{20B9}${rate!.toStringAsFixed(2)}")
                              //           ],
                              //         ),
                              //       ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Packing",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                      "pkg.toString()",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Unit name",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                      " unit_name",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Gross value",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                      "gross",
                                      // value.fromDb!
                                      //     ? "\u{20B9}gross.toStringAsFixed(2)"
                                      //     : "\u{20B9}${value.gross.toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(15.0),
                              //   child: Row(
                              //     children: [
                              //       Text(
                              //         "Discount %",
                              //         style: TextStyle(fontSize: 15),
                              //       ),
                              //       Spacer(),
                              //       Container(
                              //         width: size.width * 0.2,
                              //         child: TextField(
                              //           onTap: () {
                              //             // value.discount_prercent[index].selection =
                              //             //     TextSelection(
                              //             //         baseOffset: 0,
                              //             //         extentOffset: value
                              //             //             .discount_prercent[index]
                              //             //             .value
                              //             //             .text
                              //             //             .length);
                              //           },
                              //           style: TextStyle(
                              //             fontSize: 15.0,
                              //           ),
                              //           decoration: InputDecoration(
                              //             //labelText: "Phone number",
                              //             // hintText: "Phone number",
                              //             isDense: true,
                              //             contentPadding: EdgeInsets.all(
                              //                 0), //  <- you can it to 0.0 for no space

                              //             //border: InputBorder.none
                              //           ),
                              //           keyboardType: TextInputType.number,
                              //           onSubmitted: (values) {
                              //             double valuediscper = 0.0;
                              //             print("values---$values");
                              //             if (values.isNotEmpty) {
                              //               print("emtyyyy");
                              //               valuediscper = double.parse(values);
                              //             } else {
                              //               valuediscper = 0.00;
                              //             }
                              //             Provider.of<Controller>(context,
                              //                     listen: false)
                              //                 .fromDb = false;

                              //             // Provider.of<Controller>(context,
                              //             //         listen: false)
                              //             //     .rawCalculation(
                              //             //         double.parse(
                              //             //             value.salesrate[index].text),
                              //             //         double.parse(
                              //             //             value.salesqty[index].text),
                              //             //         valuediscper,
                              //             //         double.parse(value
                              //             //             .discount_amount[index].text),
                              //             //         tax_per!,
                              //             //         0.0,
                              //             //         value.settingsList1[1]['set_value']
                              //             //             .toString(),
                              //             //         0,
                              //             //         index,
                              //             //         true,
                              //             //         "disc_per");
                              //           },
                              //           // controller: value.discount_prercent[index],
                              //           textAlign: TextAlign.right,
                              //           // decoration: InputDecoration(
                              //           //   border: InputBorder.none,
                              //           // ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(15.0),
                              //   child: Row(
                              //     children: [
                              //       Text(
                              //         "Discount Amount",
                              //         style: TextStyle(fontSize: 15),
                              //       ),
                              //       Spacer(),
                              //       Container(
                              //         width: size.width * 0.2,
                              //         child: TextField(
                              //           onTap: () {
                              //             // value.discount_amount[index].selection =
                              //             //     TextSelection(
                              //             //         baseOffset: 0,
                              //             //         extentOffset: value
                              //             //             .discount_amount[index]
                              //             //             .value
                              //             //             .text
                              //             //             .length);
                              //           },
                              //           style: TextStyle(
                              //             fontSize: 15.0,
                              //           ),
                              //           decoration: InputDecoration(
                              //             //labelText: "Phone number",
                              //             // hintText: "Phone number",
                              //             isDense: true,
                              //             contentPadding: EdgeInsets.all(
                              //                 0), //  <- you can it to 0.0 for no space

                              //             //border: InputBorder.none
                              //           ),
                              //           keyboardType: TextInputType.number,
                              //           onSubmitted: (values) {
                              //             double valuediscamt = 0.0;
                              //             // value.discount_amount[index].text=;
                              //             if (values.isNotEmpty) {
                              //               print("emtyyyy");
                              //               valuediscamt = double.parse(values);
                              //             } else {
                              //               valuediscamt = 0.0000;
                              //             }
                              //             Provider.of<Controller>(context,
                              //                     listen: false)
                              //                 .fromDb = false;
                              //             print(
                              //                 "discount amount..........$valuediscamt");
                              //             // Provider.of<Controller>(context,
                              //             //         listen: false)
                              //             //     .rawCalculation(
                              //             //         double.parse(
                              //             //             value.salesrate[index].text),
                              //             //         double.parse(
                              //             //             value.salesqty[index].text),
                              //             //         double.parse(value
                              //             //             .discount_prercent[index].text),
                              //             //         valuediscamt,
                              //             //         tax_per!,
                              //             //         0.0,
                              //             //         value.settingsList1[1]['set_value']
                              //             //             .toString(),
                              //             //         0,
                              //             //         index,
                              //             //         true,
                              //             //         "disc_amt");
                              //           },
                              //           // controller: value.discount_amount[index],
                              //           textAlign: TextAlign.right,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Tax %",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                      "tax_per!.toStringAsFixed(2)",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Tax amount",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    // tax_amt! < 0.00
                                    //     ? Text(
                                    //         "\u{20B9}0.00",
                                    //       )
                                    //     : Text(
                                    //         value.fromDb!
                                    //             ? "\u{20B9}${tax_amt.toStringAsFixed(2)}"
                                    //             : "\u{20B9}${value.tax.toStringAsFixed(2)}",
                                    //         style: TextStyle(fontSize: 15),
                                    //       )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Cess %",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                      "cess_per!.toStringAsFixed(2)",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Cess amount",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    // cess_amt! < 0.00
                                    //     ? Text(
                                    //         "\u{20B9}0.00",
                                    //       )
                                    //     : Text(
                                    //         value.fromDb!
                                    //             ? "\u{20B9}${cess_amt.toStringAsFixed(2)}"
                                    //             : "\u{20B9}${value.cess.toStringAsFixed(2)}",
                                    //         style: TextStyle(fontSize: 15),
                                    // )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(children: [
                                  Text(
                                    "Net Amount",
                                    style: TextStyle(
                                        color: P_Settings.extracolor,
                                        fontSize: 15),
                                  ),
                                  Spacer(),
                                  // net_amt! < 0.00
                                  //     ? Text("\u{20B9}0.00",
                                  //         style: TextStyle(
                                  //             color: P_Settings.extracolor,
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 15))
                                  //     : Text(
                                  //         value.fromDb!
                                  //             ? "\u{20B9}${net_amt.toStringAsFixed(2)}"
                                  //             : "\u{20B9}${value.net_amt.toStringAsFixed(2)}",
                                  //         style: TextStyle(
                                  //             color: P_Settings.extracolor,
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 15),
                                  //       ),
                                ]),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(15.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Container(
                              //           width: size.width * 0.4,
                              //           child: ElevatedButton(
                              //               style: ElevatedButton.styleFrom(
                              //                 primary: P_Settings.salewaveColor,
                              //               ),
                              //               onPressed: () async {
                              //                 // int indexCalc = index + 1;
                              //                 // print(
                              //                 //     "indexxxxxx.${value.discount_amount[index].text}");
                              //                 // await OrderAppDB.instance.upadteCommonQuery(
                              //                 //     "salesBagTable",
                              //                 //     "rate=${value.salesrate[index].text},unit_rate=${value.taxable_rate},net_amt=${value.net_amt},discount_per=${value.discount_prercent[index].text},discount_amt=${value.discount_amount[index].text},qty=${value.salesqty[index].text},totalamount=${value.gross},tax_amt=${value.tax},cgst_amt=${value.cgst_amt},sgst_amt=${value.sgst_amt},igst_amt=${value.igst_amt}",
                              //                 //     "code='$code' and customerid='$customerId' and unit_name='$unit_name'");
                              //                 // print("calculate new total");
                              //                 // await Provider.of<Controller>(context,
                              //                 //         listen: false)
                              //                 //     .calculatesalesTotal(
                              //                 //         os, customerId);
                              //                 // Provider.of<Controller>(context,
                              //                 //         listen: false)
                              //                 //     .getSaleBagDetails(customerId, os);

                              //                 // Navigator.pop(context);
                              //               },
                              //               child: Text("Apply")))
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                  ),
                ),
              );
            },
          );
        });
  }

  //////////////////
  Widget dropDownRoute(Size size) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            width: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: P_Settings.blue1,
                  style: BorderStyle.solid,
                  width: 0.4),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selected,
              // isDense: true,
              hint: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Select Route"),
              ),
              autofocus: true,
              underline: SizedBox(),
              elevation: 0,

              items: value.productUnit_X001
                  .map((item) => DropdownMenuItem<String>(
                      value: "${item.pid},${item.unit_name}",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.unit_name,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )))
                  .toList(),
              onChanged: (item) {
                print("clicked");
                if (item != null) {
                  selected = item;

                  splitted = selected!.split(",");
                  if (selected != null) {
                    visible.value = false;
                  } else {
                    visible.value = true;
                  }
                  print("route id-----${splitted[0]}");
                }
              },
            ),
          ),
        );
      },
    );
  }
}
