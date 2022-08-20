import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customSearchTile.dart';
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/components/showMoadal.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:badges/badges.dart';
import 'package:orderapp/screen/ORDER/8_cartList.dart';
import 'package:orderapp/screen/ORDER/filterProduct.dart';
import 'package:orderapp/screen/RETURN/return_cart.dart';
import 'package:provider/provider.dart';

class ItemSelection extends StatefulWidget {
  // List<Map<String,dynamic>>  products;
  String customerId;
  String os;
  String areaId;
  String areaName;
  String type;
  bool _isLoading = false;

  ItemSelection(
      {required this.customerId,
      required this.areaId,
      required this.os,
      required this.areaName,
      required this.type});

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  String rate1 = "1";
  TextEditingController searchcontroll = TextEditingController();
  ShowModal showModal = ShowModal();
  List<Map<String, dynamic>> products = [];
  SearchTile search = SearchTile();
  DateTime now = DateTime.now();
  List<String> s = [];
  String? date;
  bool loading = true;
  bool loading1 = false;
  CustomSnackbar snackbar = CustomSnackbar();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    searchcontroll.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.type===${widget.type}");
    print("areaId---${widget.customerId}");
    products = Provider.of<Controller>(context, listen: false).productName;
    print("products---${products}");

    Provider.of<Controller>(context, listen: false).getOrderno();
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    s = date!.split(" ");
    // Provider.of<Controller>(context, listen: false)
    //     .getProductList(widget.customerId);
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.type == "sale order"
            ? P_Settings.wavecolor
            : P_Settings.returnbuttnColor,
        actions: [
          Badge(
            animationType: BadgeAnimationType.scale,
            toAnimate: true,
            badgeColor: Colors.white,
            badgeContent: Consumer<Controller>(
              builder: (context, value, child) {
                return Text(
                  widget.type == "sale order"
                      ? "${value.count}"
                      : "${value.returnCount}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                );
              },
            ),
            position: const BadgePosition(start: 33, bottom: 25),
            child: IconButton(
              onPressed: () async {
                String oos = "O" + "${widget.os}";

                if (widget.customerId == null || widget.customerId.isEmpty) {
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (widget.type == "sale order") {
                    Provider.of<Controller>(context, listen: false)
                        .selectFromSettings('SO_RATE_EDIT');
                    Provider.of<Controller>(context, listen: false)
                        .getBagDetails(widget.customerId, oos);

                    List<Map<String, dynamic>> result =
                        await OrderAppDB.instance.selectAllcommon(
                            'settingsTable', "set_code='SO_RATE_EDIT'");
                    // print("hfjdh------$result");

                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => CartList(
                          areaId: widget.areaId,
                          custmerId: widget.customerId,
                          os: oos,
                          areaname: widget.areaName,
                          type: widget.type,
                        ),
                      ),
                    );
                  } else if (widget.type == "return") {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => ReturnCart(
                          areaId: widget.areaId,
                          custmerId: widget.customerId,
                          os: widget.os,
                          areaname: widget.areaName,
                          type: widget.type,
                        ),
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 3.0,
          ),
          Consumer<Controller>(
            builder: (context, _value, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  Provider.of<Controller>(context, listen: false)
                      .filteredeValue = value;

                  if (value == "0") {
                    setState(() {
                      Provider.of<Controller>(context, listen: false)
                          .filterCompany = false;
                    });

                    Provider.of<Controller>(context, listen: false)
                        .filteredProductList
                        .clear();
                    // Provider.of<Controller>(context, listen: false)
                    //     .getProductList(widget.customerId);
                  } else {
                    print("value---$value");
                    Provider.of<Controller>(context, listen: false)
                        .filterCompany = true;
                    Provider.of<Controller>(context, listen: false)
                        .filterwithCompany(
                            widget.customerId, value, "sale order");
                  }
                },
                itemBuilder: (context) => _value.productcompanyList
                    .map((item) => PopupMenuItem<String>(
                          value: item["comid"],
                          child: Text(
                            item["comanme"],
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          // Provider.of<Controller>(context, listen: false)
          //     .getProductList(widget.customerId);
          print("value.returnirtemExists------${value.returnirtemExists}");
          return Column(
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: size.width * 0.95,
                  height: size.height * 0.09,
                  child: TextField(
                    controller: searchcontroll,
                    onChanged: (value) {
                      Provider.of<Controller>(context, listen: false)
                          .setisVisible(true);
                      value = searchcontroll.text;
                    },
                    decoration: InputDecoration(
                      hintText: "Search with  Product code/Name/category",
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                      suffixIcon: value.isVisible
                          ? Wrap(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.done,
                                      size: 20,
                                    ),
                                    onPressed: () async {
                                      // Provider.of<Controller>(context,
                                      //         listen: false)
                                      //     .getBagDetails(
                                      //         widget.customerId, widget.os);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .searchkey = searchcontroll.text;
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .setIssearch(true);
                                      Provider.of<Controller>(context,
                                                  listen: false)
                                              .filterCompany
                                          ? Provider.of<Controller>(context,
                                                  listen: false)
                                              .searchProcess(
                                                  widget.customerId,
                                                  widget.os,
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .filteredeValue!,
                                                  "sale order")
                                          : Provider.of<Controller>(context,
                                                  listen: false)
                                              .searchProcess(widget.customerId,
                                                  widget.os, "", "sale order");
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getProductList(widget.customerId);

                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .setIssearch(false);

                                      value.setisVisible(false);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .newList
                                          .clear();
                                      searchcontroll.clear();
                                      print(
                                          "rtsyt----${Provider.of<Controller>(context, listen: false).returnirtemExists}");
                                    }),
                              ],
                            )
                          : Icon(
                              Icons.search,
                              size: 20,
                            ),
                    ),
                  ),
                ),
              ),
              value.isLoading
                  ? Container(
                      child: CircularProgressIndicator(
                          color: widget.type == "sale order"
                              ? P_Settings.wavecolor
                              : P_Settings.returnbuttnColor))
                  : value.prodctItems.length == 0
                      ? _isLoading
                          ? CircularProgressIndicator()
                          : Container(
                              height: size.height * 0.6,
                              child: Text(
                                "No Products !!!",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                      : Expanded(
                          child: value.isSearch
                              ? value.isListLoading
                                  ? Center(
                                      child: SpinKitCircle(
                                        color: widget.type == "sale order"
                                            ? P_Settings.wavecolor
                                            : P_Settings.returnbuttnColor,
                                        size: 40,
                                      ),
                                    )
                                  : value.newList.length == 0
                                      ? Container(
                                          child: Text("No data Found!!!!"),
                                        )
                                      : ListView.builder(
                                          itemExtent: 55,
                                          shrinkWrap: true,
                                          itemCount: value.newList.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.4, right: 0.4),
                                              child: ListTile(
                                                title: Text(
                                                  '${value.newList[index]["code"]}' +
                                                      '-' +
                                                      '${value.newList[index]["item"]}',
                                                  style: TextStyle(
                                                      // color: value.selected[index]
                                                      //     ? Colors.green
                                                      //     : Colors.grey[700],
                                                      color: widget.type ==
                                                              "sale order"
                                                          ? value.selected[
                                                                  index]
                                                              ? Colors.green
                                                              : Colors.grey[700]
                                                          : Colors.grey[700],
                                                      fontSize: 16),
                                                ),
                                                subtitle: Text(
                                                  '\u{20B9}${value.newList[index]["rate1"]}',
                                                  style: TextStyle(
                                                    color: P_Settings.ratecolor,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                        width:
                                                            size.width * 0.06,
                                                        child: TextFormField(
                                                          controller:
                                                              value.qty[index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "1"),
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                      ),
                                                      onPressed: () async {
                                                        String oos = "O" +
                                                            "${value.ordernum[0]["os"]}";

                                                        setState(() {
                                                          if (value.selected[
                                                                  index] ==
                                                              false) {
                                                            value.selected[
                                                                    index] =
                                                                !value.selected[
                                                                    index];
                                                            // selected = index;
                                                          }

                                                          if (value.qty[index]
                                                                      .text ==
                                                                  null ||
                                                              value
                                                                  .qty[index]
                                                                  .text
                                                                  .isEmpty) {
                                                            value.qty[index]
                                                                .text = "1";
                                                          }
                                                        });
                                                        if (widget.type ==
                                                            "sale order") {
                                                          int max = await OrderAppDB
                                                              .instance
                                                              .getMaxCommonQuery(
                                                                  'orderBagTable',
                                                                  'cartrowno',
                                                                  "os='${oos}' AND customerid='${widget.customerId}'");

                                                          print("max----$max");
                                                          // print("value.qty[index].text---${value.qty[index].text}");

                                                          rate1 = value.newList[
                                                              index]["rate1"];
                                                          var total = int.parse(
                                                                  rate1) *
                                                              int.parse(value
                                                                  .qty[index]
                                                                  .text);
                                                          print(
                                                              "total rate $total");

                                                          var res = await OrderAppDB
                                                              .instance
                                                              .insertorderBagTable(
                                                                  value.newList[
                                                                          index]
                                                                      ["item"],
                                                                  s[0],
                                                                  s[1],
                                                                  oos,
                                                                  widget
                                                                      .customerId,
                                                                  max,
                                                                  value.newList[
                                                                          index]
                                                                      ["code"],
                                                                  int.parse(value
                                                                      .qty[
                                                                          index]
                                                                      .text),
                                                                  rate1,
                                                                  total
                                                                      .toString(),
                                                                  0);
                                                          snackbar.showSnackbar(
                                                              context,
                                                              "${value.newList[index]["code"] + "-" + (value.newList[index]['item'])} - Added to cart",
                                                              "sale order");
                                                          Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .countFromTable(
                                                            "orderBagTable",
                                                            oos,
                                                            widget.customerId,
                                                          );
                                                        }
                                                        if (widget.type ==
                                                            "return") {
                                                          rate1 = value.newList[
                                                              index]["rate1"];
                                                          var total = int.parse(
                                                                  rate1) *
                                                              int.parse(value
                                                                  .qty[index]
                                                                  .text);
                                                          Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .addToreturnList({
                                                            "item": value
                                                                    .newList[
                                                                index]["item"],
                                                            "date": s[0],
                                                            "time": s[1],
                                                            "os": value
                                                                    .ordernum[0]
                                                                ["os"],
                                                            "customer_id":
                                                                widget
                                                                    .customerId,
                                                            "code": value
                                                                    .newList[
                                                                index]["code"],
                                                            "qty": int.parse(
                                                                value.qty[index]
                                                                    .text),
                                                            "rate": rate1,
                                                            "total": total
                                                                .toString(),
                                                            "status": 0
                                                          });
                                                          snackbar.showSnackbar(
                                                              context,
                                                              "${value.newList[index]["code"] + "-" + (value.newList[index]['item'])} - Added to cart",
                                                              "return");
                                                        }

                                                        /////////////////////////
                                                        (widget.customerId
                                                                        .isNotEmpty ||
                                                                    widget.customerId !=
                                                                        null) &&
                                                                (products[index]
                                                                            [
                                                                            "code"]
                                                                        .isNotEmpty ||
                                                                    products[index]
                                                                            [
                                                                            "code"] !=
                                                                        null)
                                                            ? Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .calculateorderTotal(
                                                                    oos,
                                                                    widget
                                                                        .customerId)
                                                            : Text("No data");

                                                        // Provider.of<Controller>(context,
                                                        //         listen: false)
                                                        //     .getProductList(
                                                        //         widget.customerId);
                                                      },
                                                      color: Colors.black,
                                                    ),
                                                    IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 18,
                                                          // color: Colors.redAccent,
                                                        ),
                                                        onPressed: widget
                                                                    .type ==
                                                                "sale order"
                                                            ? value.newList[index]
                                                                        [
                                                                        "cartrowno"] ==
                                                                    null
                                                                ? value.selected[
                                                                        index]
                                                                    ? () async {
                                                                        String
                                                                            oos =
                                                                            "O" +
                                                                                "${value.ordernum[0]["os"]}";

                                                                        String
                                                                            item =
                                                                            value.newList[index]["code"] +
                                                                                value.newList[index]["item"];

                                                                        showModal.showMoadlBottomsheet(
                                                                            oos,
                                                                            widget.customerId,
                                                                            item,
                                                                            size,
                                                                            context,
                                                                            "newlist just added",
                                                                            value.newList[index]["code"],
                                                                            index,
                                                                            "no filter",
                                                                            "",
                                                                            value.qty[index],
                                                                            "sale order");
                                                                      }
                                                                    : null
                                                                : () async {
                                                                    String oos =
                                                                        "O" +
                                                                            "${value.ordernum[0]["os"]}";

                                                                    String item = value.newList[index]
                                                                            [
                                                                            "code"] +
                                                                        value.newList[index]
                                                                            [
                                                                            "item"];

                                                                    showModal.showMoadlBottomsheet(
                                                                        oos,
                                                                        widget
                                                                            .customerId,
                                                                        item,
                                                                        size,
                                                                        context,
                                                                        "newlist already in cart",
                                                                        value.newList[index]
                                                                            [
                                                                            "code"],
                                                                        index,
                                                                        "no filter",
                                                                        "",
                                                                        value.qty[
                                                                            index],
                                                                        "sale order");
                                                                  }
                                                            : value.selected[
                                                                    index]
                                                                ? () async {
                                                                    String oos =
                                                                        "O" +
                                                                            "${value.ordernum[0]["os"]}";

                                                                    String item = value.newList[index]
                                                                            [
                                                                            "code"] +
                                                                        value.newList[index]
                                                                            [
                                                                            "item"];

                                                                    showModal.showMoadlBottomsheet(
                                                                        oos,
                                                                        widget
                                                                            .customerId,
                                                                        item,
                                                                        size,
                                                                        context,
                                                                        "return",
                                                                        value.newList[index]
                                                                            [
                                                                            "code"],
                                                                        index,
                                                                        "no filter",
                                                                        "",
                                                                        value.qty[
                                                                            index],
                                                                        "sale order");
                                                                  }
                                                                : null)
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                              : value.filterCompany
                                  ? FilteredProduct(
                                      type: widget.type,
                                      customerId: widget.customerId,
                                      os: widget.os,
                                      s: s,
                                      value: Provider.of<Controller>(context,
                                              listen: false)
                                          .filteredeValue)
                                  : value.isLoading
                                      ? CircularProgressIndicator()
                                      : ListView.builder(
                                          itemExtent: 55,
                                          shrinkWrap: true,
                                          itemCount: value.productName.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.4, right: 0.4),
                                              child: ListTile(
                                                title: Text(
                                                  '${value.productName[index]["code"]}' +
                                                      '-' +
                                                      '${value.productName[index]["item"]}',
                                                  style: TextStyle(
                                                      color: widget.type ==
                                                              "sale order"
                                                          ? value.productName[
                                                                          index][
                                                                      "cartrowno"] ==
                                                                  null
                                                              ? value.selected[
                                                                      index]
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .grey[700]
                                                              : Colors.green
                                                          : widget.type ==
                                                                  "return"
                                                              ? value.returnirtemExists[
                                                                      index]
                                                                  ? Colors
                                                                      .grey[700]
                                                                  : Colors
                                                                      .grey[700]
                                                              : Colors
                                                                  .green[700],
                                                      // value.selected[
                                                      //         index]
                                                      //     ? Color
                                                      //         .fromARGB(
                                                      //             255,
                                                      //             224,
                                                      //             61,
                                                      //             11)
                                                      //     : Colors
                                                      //         .grey[700],

                                                      fontSize: 16),
                                                ),
                                                subtitle: Text(
                                                  '\u{20B9}${value.productName[index]["rate1"]}',
                                                  style: TextStyle(
                                                    color: P_Settings.ratecolor,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                        width:
                                                            size.width * 0.06,
                                                        child: TextFormField(
                                                          controller:
                                                              value.qty[index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "1"),
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                      ),
                                                      onPressed: () async {
                                                        String oos = "O" +
                                                            "${value.ordernum[0]["os"]}";

                                                        setState(() {
                                                          if (value.selected[
                                                                  index] ==
                                                              false) {
                                                            value.selected[
                                                                    index] =
                                                                !value.selected[
                                                                    index];
                                                            // selected = index;
                                                          }

                                                          if (value.qty[index]
                                                                      .text ==
                                                                  null ||
                                                              value
                                                                  .qty[index]
                                                                  .text
                                                                  .isEmpty) {
                                                            value.qty[index]
                                                                .text = "1";
                                                          }
                                                        });
                                                        if (widget.type ==
                                                            "sale order") {
                                                          int max = await OrderAppDB
                                                              .instance
                                                              .getMaxCommonQuery(
                                                                  'orderBagTable',
                                                                  'cartrowno',
                                                                  "os='${oos}' AND customerid='${widget.customerId}'");

                                                          print("max----$max");
                                                          // print("value.qty[index].text---${value.qty[index].text}");

                                                          rate1 = value
                                                                  .productName[
                                                              index]["rate1"];
                                                          var total = int.parse(
                                                                  rate1) *
                                                              int.parse(value
                                                                  .qty[index]
                                                                  .text);
                                                          print(
                                                              "total rate $total");

                                                          var res = await OrderAppDB
                                                              .instance
                                                              .insertorderBagTable(
                                                                  products[
                                                                          index]
                                                                      ["item"],
                                                                  s[0],
                                                                  s[1],
                                                                  oos,
                                                                  widget
                                                                      .customerId,
                                                                  max,
                                                                  products[
                                                                          index]
                                                                      ["code"],
                                                                  int.parse(value
                                                                      .qty[
                                                                          index]
                                                                      .text),
                                                                  rate1,
                                                                  total
                                                                      .toString(),
                                                                  0);

                                                          snackbar.showSnackbar(
                                                              context,
                                                              "${products[index]["code"] + "-" + (products[index]['item'])} - Added to cart",
                                                              "sale order");
                                                          Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .countFromTable(
                                                            "orderBagTable",
                                                            oos,
                                                            widget.customerId,
                                                          );
                                                        }
                                                        if (widget.type ==
                                                            "return") {
                                                          rate1 = value
                                                                  .productName[
                                                              index]["rate1"];
                                                          var total = int.parse(
                                                                  rate1) *
                                                              int.parse(value
                                                                  .qty[index]
                                                                  .text);
                                                          Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .addToreturnList({
                                                            "item":
                                                                products[index]
                                                                    ["item"],
                                                            "date": s[0],
                                                            "time": s[1],
                                                            "os": value
                                                                    .ordernum[0]
                                                                ["os"],
                                                            "customer_id":
                                                                widget
                                                                    .customerId,
                                                            "code":
                                                                products[index]
                                                                    ["code"],
                                                            "qty": int.parse(
                                                                value.qty[index]
                                                                    .text),
                                                            "rate": rate1,
                                                            "total": total
                                                                .toString(),
                                                            "status": 0
                                                          });
                                                          snackbar.showSnackbar(
                                                              context,
                                                              "${products[index]["code"] + "-" + (products[index]['item'])} - Added to cart",
                                                              "return");

                                                          // Provider.of<Controller>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .keyContainsListcheck(
                                                          //         products[
                                                          //                 index]
                                                          //             ["code"],
                                                          //         index);

                                                          // print("exist----$exist");
                                                        }

                                                        /////////////////////////
                                                        (widget.customerId
                                                                        .isNotEmpty ||
                                                                    widget.customerId !=
                                                                        null) &&
                                                                (products[index]
                                                                            [
                                                                            "code"]
                                                                        .isNotEmpty ||
                                                                    products[index]
                                                                            [
                                                                            "code"] !=
                                                                        null)
                                                            ? Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .calculateorderTotal(
                                                                    oos,
                                                                    widget
                                                                        .customerId)
                                                            : Text("No data");
                                                      },
                                                      color: Colors.black,
                                                    ),
                                                    IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 18,
                                                          // color: Colors.redAccent,
                                                        ),
                                                        onPressed: widget
                                                                    .type ==
                                                                "sale order"
                                                            ? value.productName[
                                                                            index]
                                                                        [
                                                                        "cartrowno"] ==
                                                                    null
                                                                ? value.selected[
                                                                        index]
                                                                    ? () async {
                                                                        String
                                                                            oos =
                                                                            "O" +
                                                                                "${widget.os}";
                                                                        String
                                                                            item =
                                                                            products[index]["code"] +
                                                                                products[index]["item"];
                                                                        showModal.showMoadlBottomsheet(
                                                                            oos,
                                                                            widget.customerId,
                                                                            item,
                                                                            size,
                                                                            context,
                                                                            "just added",
                                                                            products[index]["code"],
                                                                            index,
                                                                            "no filter",
                                                                            "",
                                                                            value.qty[index],
                                                                            "sale order");
                                                                      }
                                                                    : null
                                                                : () async {
                                                                    String oos =
                                                                        "O" +
                                                                            "${widget.os}";
                                                                    String item = products[index]
                                                                            [
                                                                            "code"] +
                                                                        products[index]
                                                                            [
                                                                            "item"];
                                                                    showModal.showMoadlBottomsheet(
                                                                        oos,
                                                                        widget
                                                                            .customerId,
                                                                        item,
                                                                        size,
                                                                        context,
                                                                        "already in cart",
                                                                        products[index]
                                                                            [
                                                                            "code"],
                                                                        index,
                                                                        "no filter",
                                                                        "",
                                                                        value.qty[
                                                                            index],
                                                                        "sale order");
                                                                  }
                                                            : value.selected[
                                                                    index]
                                                                ? () async {
                                                                    String oos =
                                                                        "O" +
                                                                            "${widget.os}";
                                                                    String item = products[index]
                                                                            [
                                                                            "code"] +
                                                                        products[index]
                                                                            [
                                                                            "item"];
                                                                    showModal.showMoadlBottomsheet(
                                                                        oos,
                                                                        widget
                                                                            .customerId,
                                                                        item,
                                                                        size,
                                                                        context,
                                                                        "return",
                                                                        products[index]
                                                                            [
                                                                            "code"],
                                                                        index,
                                                                        "no filter",
                                                                        "",
                                                                        value.qty[
                                                                            index],
                                                                        "sale order");
                                                                  }
                                                                : null)
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                        ),
            ],
          );
        },
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
}
