import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:meatappapp/screens/add_page.dart';
import 'package:meatappapp/screens/admins.dart';
import 'package:meatappapp/screens/cash_data.dart';
import 'package:meatappapp/screens/main_page.dart';
import 'package:meatappapp/screens/reports_page.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import 'orders.dart';

class ControlPage extends KFDrawerContent {
  ControlPage({
    Key key,
  });

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _visible = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:
      new ListView(
          children: <Widget>[
           Container(
             padding: EdgeInsets.only(top:20.0),
           ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(20) ,
                      width: 120.0,
                      height: 120.0,
                      decoration:BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius:8,
                            offset:Offset(0,3)
                          )
                        ]
                      ),
                      child:  FlatButton(onPressed:
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPageScreen()),
                        );
                      },
color: Colors.white,
                        shape: SuperellipseShape(
                          borderRadius: BorderRadius.circular(28.0),
                        ), // SuperellipseShape
                        child:AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 500),
                       child: Column( children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                         Icon(
                           Icons.add_photo_alternate,
                           color: Colors.red[900],
                           size:60.0,
                         ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                        Text("الاضافات"
                            ,
                          style:TextStyle(
                            fontFamily:"Sans",
                            color:Colors.black                          ) ,
                        ),
                        ]
                        ),
                        ) , // Container
                      )
                  )
                  ,
                  Container(
                      margin: EdgeInsets.all(20) ,
                      width: 120.0,
                      height: 120.0,
                      decoration:BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius:8,
                                offset:Offset(0,3)
                            )
                          ]
                      ),
                      child:  FlatButton(onPressed:
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CashdataPage()),
                        );
                      },

                          color: Colors.white,
                          shape: SuperellipseShape(
                            borderRadius: BorderRadius.circular(28.0),
                          ), // SuperellipseShape
                          child:
                          Column( children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 20.0),
                            ),
                            Icon(
                              Icons.table_chart,
                              color: Colors.red[900],
                              size:60.0,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5.0),
                            ),
                            Text( "البيانات"
                              ,
                              style:TextStyle(
                                  fontFamily:"Sans",
                                  color:Colors.black                          ) ,
                            ),
                          ]
                          )
                        // Container
                      )
                  )
                  ,

                ]
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(20) ,
                      width: 120.0,
                      height: 120.0,
                      decoration:BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius:8,
                                offset:Offset(0,3)
                            )
                          ]
                      ),
                      child:  FlatButton(onPressed:
    () {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderPageScreen()),
        );
      });
    },

                        color: Colors.white,
                        shape: SuperellipseShape(
                          borderRadgit initius: BorderRadius.circular(28.0),
                        ), // SuperellipseShape
                        child:
                        Column( children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.red[900],
                            size:60.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.0),
                          ),
                          Text( "الطلبات"
                            ,
                            style:TextStyle(
                                fontFamily:"Sans",
                                color:Colors.black                          ) ,
                          ),
                        ]
                        )
                        // Container
                      )
                  )
                  ,
                  Container(
                      margin: EdgeInsets.all(20.0) ,
                      width: 120.0,
                      height: 120.0,
                      decoration:BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius:8,
                                offset:Offset(0,3)
                            )
                          ]
                      ),
                      child:  FlatButton(onPressed:
                          () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminScreen()),
                        );
                      },
                        color: Colors.white,
                        shape: SuperellipseShape(
                          borderRadius: BorderRadius.circular(28.0),
                        ), // SuperellipseShape
                        child:
                        Column(

                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 20.0),
                              ),
                              Icon(
                                Icons.supervised_user_circle,
                                color: Colors.red[900],
                                size:60.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5.0),
                              ),
                          Text("المستخدمين"
                            ,
                            style:TextStyle(
                                fontFamily:"Sans",
                                color:Colors.black ) ,
                          ),
                        ]
                        )
                        // Container
                      )
                  )
                  ,

                ]
            ),
/*            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(20) ,
                      width: 120.0,
                      height: 120.0,
                      decoration:BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius:8,
                                offset:Offset(0,3)
                            )
                          ]
                      ),
                      child:  FlatButton(onPressed:
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReportPageScreen()),
                        );
                      },

                          color: Colors.white,
                          shape: SuperellipseShape(
                            borderRadius: BorderRadius.circular(28.0),
                          ), // SuperellipseShape
                          child:
                          Column( children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 20.0),
                            ),
                            Icon(
                              Icons.pie_chart,
                              color: Colors.red[900],
                              size:60.0,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5.0),
                            ),
                            Text( "التقارير"
                              ,
                              style:TextStyle(
                                  fontFamily:"Sans",
                                  color:Colors.black                          ) ,
                            ),
                          ]
                          )
                        // Container
                      )
                  )
                ]
            ),*/
    ],
      )
    );

  }
}
