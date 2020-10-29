import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/edit_cash.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/api.dart';

var cashlist = new List<Cash>();

class CashdataPage extends KFDrawerContent {

  CashdataPage({
    Key key,
  });

  @override
  _CashdataPageState createState() => _CashdataPageState();
}

class _CashdataPageState extends State<CashdataPage> {
  bool _visible = true;

  _getCashdata() {
    Cashdata.getCashdata().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        cashlist = list.map((model) => Cash.fromJson(model)).toList();
      });
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCashdata();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("لحوم بلدي",
      ),
          ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          cashlist.length > 0 ?
          new ListView.builder
            (
              itemCount: cashlist.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Container(
                    alignment: Alignment.centerRight,
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child:Center(
                      child: ListTile(
                        /*  leading:  IconButton(
                  icon: Icon(Icons.delete,color: Colors.pink,),
                  onPressed: _deletedata(cashlist[index].id),
                ),*/
                        title: Text(
                          "كيلو"+cashlist[index].killo,
                          textDirection: TextDirection.rtl,
                          style:TextStyle(color:Colors.red[900] ,fontWeight:FontWeight.bold, fontFamily:'Sans')
                          ,),
                        subtitle: Text(
                         "ريال"+"${cashlist[index].cash.toString()}" ,
                          textDirection: TextDirection.rtl,
                          style:TextStyle(color:Colors.black54 ,fontWeight:FontWeight.bold, fontFamily:'Sans')
                          ,) ,
                        onTap:    () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditCashScreen(cashlist,index)),
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
      ),
    );
  }
}
