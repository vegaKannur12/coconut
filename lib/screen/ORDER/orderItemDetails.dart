import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class OrderItemDetails {
  List rawCalcResult = [];
  showorderMoadlBottomsheet(
      String item,
      String code,
      double qty,
      double rate,
      double net_amt,
      double gross,
      BuildContext context,
      Size size,
      int index,
      String customerId,
      String os,
      double pkg,
      String unit_name) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          // rawCalcResult = Provider.of<Controller>(context,listen: false).rawCalculation(rate,qty.toDouble(), 0.0, 100,tax_per, 0.0, "0", 0);
          return Consumer<Controller>(
            builder: (context, value, child) {
              // value.discount_prercent[index].text = dis_per.toString();
              // value.discount_amount[index].text = dis_amt.toString();
              // value.salesqty[index].text = qty.toString();
              return SingleChildScrollView(
                child: Container(
                  // height: size.height * 0.96,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
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
                                      color:P_Settings.wavecolor),
                                ),
                                Text("-"),
                                Text(
                                  "( $code)",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                              Text(
                                "Qty",
                                style: TextStyle(fontSize: 15),
                              ),
                              Spacer(),
                              Container(
                                width: size.width * 0.2,
                                child: TextField(
                                  onTap: () {
                                    value.qty[index].selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            value.qty[index].value.text.length);
                                  },
                                  // autofocus: true,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(0),
                                    //border: InputBorder.none
                                  ),

                                  // maxLines: 1,
                                  // minLines: 1,
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (values) {
                                    print("values----$values");
                                    double valueqty = 0.0;
                                    // value.discount_amount[index].text=;
                                    if (values.isNotEmpty) {
                                      print("emtyyyy");
                                      valueqty = double.parse(values);
                                      value.calculateOrderNetAmount(
                                          index,
                                          double.parse(
                                              value.orderrate[index].text),
                                          double.parse(value.qty[index].text));
                                    } else {
                                      valueqty = 0.00;
                                    }
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .fromDb = false;
                                  },
                                  textAlign: TextAlign.right,
                                  controller: value.qty[index],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                pkg.toString(),
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
                                unit_name,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Provider.of<Controller>(context, listen: false)
                                    .settingsList1[0]["set_value"] ==
                                "YES"
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rate :",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Container(
                                      width: size.width * 0.2,
                                      child: TextField(
                                        onTap: () {
                                          value.orderrate[index].selection =
                                              TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: value
                                                      .orderrate[index]
                                                      .value
                                                      .text
                                                      .length);
                                        },
                                        keyboardType: TextInputType.number,
                                        onSubmitted: (values) {
                                           value.calculateOrderNetAmount(
                                          index,
                                          double.parse(
                                              value.orderrate[index].text),
                                          double.parse(value.qty[index].text));
                                             Provider.of<Controller>(context,
                                            listen: false)
                                        .fromDb = false;
                                        },
                                        textAlign: TextAlign.right,
                                        controller: value.orderrate[index],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rate :",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "\u{20B9}${rate}",
                                        style: TextStyle(fontSize: 17),
                                      ),
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
                                value.fromDb!
                                    ? "\u{20B9}${gross.toStringAsFixed(2)}"
                                    : "\u{20B9}${value.orderNetAmount.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 15),
                              )
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
                                  color: P_Settings.extracolor, fontSize: 15),
                            ),
                            Spacer(),
                            net_amt < 0.00
                                ? Text("\u{20B9}0.00",
                                    style: TextStyle(
                                        color: P_Settings.extracolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))
                                : Text(
                                    value.fromDb!
                                        ? "\u{20B9}${net_amt.toStringAsFixed(2)}"
                                        : "\u{20B9}${value.orderNetAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: P_Settings.extracolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: size.width * 0.4,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: P_Settings.wavecolor,
                                      ),
                                      onPressed: () async {
                                        // int indexCalc = index + 1;
                                        await OrderAppDB.instance.upadteCommonQuery(
                                            "orderBagTable",
                                            "rate=${value.orderrate[index].text},totalamount=${value.orderNetAmount},qty=${value.qty[index].text}",
                                            "code='$code' and customerid='$customerId' and unit_name='${value.selectedItem}'");
                                        print("calculate new total");
                                        await Provider.of<Controller>(context,
                                                listen: false)
                                            .calculateorderTotal(
                                                os, customerId);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getBagDetails(customerId, os);

                                        Navigator.pop(context);
                                      },
                                      child: Text("Apply")))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
