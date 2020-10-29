import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/confirm_page.dart';
import 'package:meatappapp/screens/control_page.dart';
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

  // Methode for edit level data to mysql
  void _nextlevelorder(int role) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _adminname = prefs.getString('realname');
      // Showing CircularProgressIndicator using State.
      setState(() {
        visible = true ;
        unvisible = false;
      });
      FormData formData =
      // new FormData.fromMap({"name": "bukhari" });
      new FormData.fromMap({"adminname": _adminname});
      Response response =
      await Dio().post(
          "http://semicolon-sd.com/covid19/edirrole/${widget.index}/$role}", data: formData);
      print("File upload response: $response");
      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        setState(() {
          visible = false;
          unvisible = true;
        });
      }
      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("$response", textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: 'Sans',
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold)),
            actions: [
              FlatButton(
                child: new Text("حسنا", textDirection: TextDirection.rtl,
                    style: TextStyle(fontFamily: 'Sans',
                        color: Colors.red[500],
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ControlPage()),
                      ModalRoute.withName('/'));
                },
              ),

            ],
          );
        },
      );
      setState(() {
        visible = false;
        unvisible = true;
      });
      // Show the incoming message in snakbar
      //_showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }


  nextlevel(int level){
    _nextlevelorder(level);
  }

  _configratedmsg (int role){
    return showDialog(
      context:this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("اضغط علي حسناً لـتأكيد العملية ",textDirection: TextDirection.rtl,style:TextStyle(fontFamily: 'Sans',color:Colors.red[900],fontWeight: FontWeight.bold)),
          actions: [
            FlatButton(
              child: new Text("حسنا",textDirection: TextDirection.rtl,style:TextStyle(fontFamily: 'Sans',color:Colors.red[500],fontWeight: FontWeight.bold)),
              onPressed: () {
                nextlevel(role);
              },
            ),
            FlatButton(
              child: new Text("الغاء", textDirection: TextDirection.rtl,
                  style: TextStyle(fontFamily: 'Sans',
                      color: Colors.red[500],
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                  SizedBox(height: 10.0),
                  Directionality(
                    textDirection:TextDirection.rtl,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.alternate_email, color: Colors.red[900],),
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
                        widget.list[widget.index].email,
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
                  SizedBox(
                    height: 10.0,
                  ),
                  new Directionality(
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
                      ) ,
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
                    ),
                  ),
                  SizedBox(height: 10.0),
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
                  Visibility(
                    visible: unvisible,
                    child:
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          widget.list[widget.index].role == 1?
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                          FloatingActionButton(
                            heroTag: "btn1",
                            onPressed: _configratedmsg(2),
                            child: new Icon(Icons.motorcycle, color: Colors.white),
                            backgroundColor: Colors.red[900],),
                          FloatingActionButton(
                            heroTag: "btn2",
                            onPressed: _configratedmsg(3),
                            child: new Icon(Icons.airline_seat_recline_normal, color: Colors.white),
                            backgroundColor: Colors.red[900],)
                           ]):
                          widget.list[widget.index].role == 2?
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FloatingActionButton(
                                  heroTag: "btn3",
                                  onPressed: _configratedmsg(3),
                                  child: new Icon(Icons.airline_seat_recline_normal, color: Colors.white),
                                  backgroundColor: Colors.red[900],),
                                FloatingActionButton(
                                  heroTag: "btn4",
                                  onPressed: _configratedmsg(1),
                                  child: new Icon(Icons.person, color: Colors.white),
                                  backgroundColor: Colors.red[900],)
                              ]) :
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FloatingActionButton(
                                  heroTag: "btn5",
                                  onPressed: _configratedmsg(2),
                                  child: new Icon(Icons.motorcycle, color: Colors.white),
                                  backgroundColor: Colors.red[900],),
                                FloatingActionButton(
                                  heroTag: "btn6",
                                  onPressed: _configratedmsg(1),
                                  child: new Icon(Icons.person, color: Colors.white),
                                  backgroundColor: Colors.red[900],)
                              ]),
                        ]),
                  ),
                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.all(30.0),
                          child:LoadingDoubleFlipping.square(
                            size: 30,
                            backgroundColor: Colors.red[200],
                          )
                      )
                  ),
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
