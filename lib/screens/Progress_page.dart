import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/add_page.dart';
import 'package:meatappapp/screens/cash_data.dart';
import 'package:meatappapp/screens/details_order.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/main_page.dart';
import 'package:meatappapp/screens/orders.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import 'api.dart';

List<Totalcart> listprogress =[];

class ProgressPage extends KFDrawerContent {

@override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  bool _visible = true;

  _getordersdata() {
    Cart.getOrders(2).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        listprogress = list.map((model) => Totalcart.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getordersdata();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "لحوم بلدي",
        ),
      ),
        body:
          listprogress.length > 0 ?
        ListView.builder
          (
            itemCount:listprogress.length,
            itemBuilder: (BuildContext ctxt, int index) {
                return Container(
                    alignment: Alignment.centerRight,
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: ListTile(leading: IconButton(
                        icon: Icon(Icons.menu, color: Colors.red[900],),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsOrderScreen(listprogress[index].userid,listprogress)),
                          );
                        },
                      ),
                        title: Text(
                          listprogress[index].username,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.red[900],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sans')
                          ,),
                        subtitle: Text(
                          "${ listprogress[index].total.toString()}" + "\t\t" +
                              "ريال",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sans')
                          ,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsOrderScreen(index,listprogress)),
                          );
                        },
                      ),
                    )
                );
            }
        ):
      Center(
      child: LoadingDoubleFlipping.square(
      size: 50,
      backgroundColor: Colors.red[900],
    ),
    )
    );

  }
}
