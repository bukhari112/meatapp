import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/confirm_page.dart';
import 'package:meatappapp/screens/control_page.dart';
import 'package:meatappapp/screens/edit_user.dart';
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


class DetailsUsersScreen extends StatefulWidget {
  int index;
  List<Admins> list;
  DetailsUsersScreen(this.index , this.list);

  @override
  _DetailsUsersScreenState createState() => _DetailsUsersScreenState();
}

class _DetailsUsersScreenState extends State<DetailsUsersScreen> {

  bool visible = false ;
  bool unvisible = true ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "لحوم بلدي",
        ),
      ),
      body:
      widget.list.length > 0 ?
      new ListView(
                children: <Widget>[
                  Container(
                    width: 500.0,
                    height: 150.0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                      ),
                    ),
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage('assets/profile.png'),
                      ),

                    ),
                  ),
                  SizedBox(height:10.0),
                  Directionality(
                    textDirection:TextDirection.rtl,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.verified_user, color: Colors.red[900],),
                        onPressed: () {
/*                    SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsOrderScreen(widget.list[index].userid,widget.list)),
                    );
                    });*/
                        },
                      ),
                      title:
                        Text(
                          "الصلاحية",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.red[500],
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Sans',
                          ),
                        ) ,
                      subtitle:                       widget.list[widget.index] == "3"?
                      Text("مدير",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ) :
                      widget.list[widget.index] == "2"?
                      Text("موصل طلبات",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ):
                      Text("مستخدم",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Directionality(
                    textDirection:TextDirection.rtl,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.person_pin, color: Colors.red[900],),
                        onPressed: () {
/*                    SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsOrderScreen(widget.list[index].userid,widget.list)),
                    );
                    });*/
                        },
                      ),
                      title: Text(
                        widget.list[widget.index].realname,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ) ,
                      subtitle: Text(
                        widget.list[widget.index].email,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.red[500],
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ) ,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Directionality(
                    textDirection:TextDirection.rtl,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.lock, color: Colors.red[900],),
                        onPressed: () {
/*                    SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsOrderScreen(widget.list[index].userid,widget.list)),
                    );
                    });*/
                        },
                      ),
                      title: Text(
                        widget.list[widget.index].password,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  new Directionality(
                    textDirection:TextDirection.rtl,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.phone, color: Colors.red[900],),
                        onPressed: () {
/*                    SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsOrderScreen(widget.list[index].userid,widget.list)),
                    );
                    });*/
                        },
                      ),
                      title: Text(
                        widget.list[widget.index].phone,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ) ,
                    ),
                  ),
                  new Directionality(
                    textDirection:TextDirection.rtl,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.map, color: Colors.red[900],),
                        onPressed: () {
/*                    SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsOrderScreen(widget.list[index].userid,widget.list)),
                    );
                    });*/
                        },
                      ),
                      title: Text(
                        widget.list[widget.index].address,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ) ,
                    ),
                  ),
                  SizedBox(height:10.0),
                ],
              )
          : Center(
        child: LoadingDoubleFlipping.square(
          size: 50,
          backgroundColor: Colors.red[900],
        ),
      ),
    );
  }
}

class Cashkillo {
  final int id;
  final int cash;
  final String killo;
  Cashkillo(this.id, this.cash, this.killo);
}
