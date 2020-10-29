import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/Progress_page.dart';
import 'package:meatappapp/screens/confirm_page.dart';
import 'package:meatappapp/screens/control_page.dart';
import 'package:meatappapp/screens/details_order.dart';
import 'package:meatappapp/screens/done_page.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/main_page.dart';
import 'package:meatappapp/screens/mycart.dart';
import 'package:meatappapp/utils/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:numberpicker/numberpicker.dart';
import 'api.dart';
import 'package:http/http.dart' as http;
List<Totalcart> orderslistdata =[];

class CartPageScreen extends StatefulWidget {
  @override
  _CartPageScreenState createState() => _CartPageScreenState();
}

class _CartPageScreenState extends State<CartPageScreen> {


  GlobalKey _bottomNavigationKey = GlobalKey();


/*
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DonePage(donelis)),
          );
        });
*/



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //build numberpicker for integer numbers
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red[900],
          centerTitle: true,
          title: Text("لحوم بلدي",
            style: TextStyle(fontFamily: 'Sans'),),
        ),
        body:ListView(
            children: <Widget>[
              Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 8,
                          offset: Offset(0, 3))
                    ]),
            child: FlatButton(
              onPressed: () {
              },
              color: Colors.white,
              shape: SuperellipseShape(
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: ListTile(leading: IconButton(
                      icon: Icon(Icons.check_circle, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                      },
                    ),
                      title: Text(
                        "طلبات في انتظار التأكيد",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        )
                        ,),
                      subtitle: Text(
                        "طلبات في انتظار تأكيدها"
                        ,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize:12.0)
                        ,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MycartPage(0)),
                        );
                      },
                    ),
                  ),
              ),
    Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 5,
    blurRadius: 8,
    offset: Offset(0, 3))
    ]),
    child: FlatButton(
    onPressed: () {
    },
    color: Colors.white,
    shape: SuperellipseShape(
    borderRadius: BorderRadius.circular(28.0),
    ),

    child:ListTile(leading: IconButton(
                      icon: Icon(Icons.timer, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DonePage(orderslistdata)),
              );*/
                        print(orderslistdata[0].username);
                      },
                    ),
                      title: Text(
                        " طلباتي الجديدة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        )
                        ,),
                      subtitle: Text(
                        "في انتظار استلامها من العاملين وتوصليها"
                        ,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize:12.0)
                        ,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MycartPage(1)),
                        );
                        print(orderslistdata);
                      },
                    ),
    ),
              ),
    Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 5,
    blurRadius: 8,
    offset: Offset(0, 3))
    ]),
    child: FlatButton(
    onPressed: () {
    },
    color: Colors.white,
    shape: SuperellipseShape(
    borderRadius: BorderRadius.circular(28.0),
    ),

    child:ListTile(leading: IconButton(
                      icon: Icon(Icons.motorcycle, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                      },
                    ),
                      title: Text(
                        "طلباتي قيد التوصيل",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        )
                        ,),
                      subtitle: Text(
                        "طلبات تم استلامها وجاري توصيلها"
                        ,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize:12.0)
                        ,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MycartPage(2)),
                        );
                      },
                    ),
    ),
              ),
    Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 5,
    blurRadius: 8,
    offset: Offset(0, 3))
    ]),
    child: FlatButton(
    onPressed: () {
    },
    color: Colors.white,
    shape: SuperellipseShape(
    borderRadius: BorderRadius.circular(28.0),
    ),

    child: ListTile(leading: IconButton(
                      icon: Icon(Icons.done_all, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPageScreen()),
                      );*/
                      },
                    ),
                      title: Text(
                        "طلباتي السابقة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        )
                        ,),
                      subtitle: Text(
                        "طلبات تم تسليمها"
                        ,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize:12.0)
                        ,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MycartPage(3)),
                        );
                      },
                    ),
              ),
    ),
            ]
        )
    );
  }
/* void _getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.any);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState((){this._filePath = filePath;});
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }*/
}


class Cashkillo{
  final int id;
  final int cash;
  final String killo;
  Cashkillo(this.id, this.cash, this.killo);

}