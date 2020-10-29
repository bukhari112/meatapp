import 'dart:async';
import 'dart:convert';
import 'package:flutter/scheduler.dart';
import 'package:meatappapp/screens/api.dart';
import 'package:meatappapp/screens/control_page.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/utils/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'control_page.dart';
import 'main_page.dart';

var adminslist = new List<Admins>();
var userslist = new List<Admins>();
var usersfiltter = new List<Admins>();
var adminsfiltter = new List<Admins>();
int _landiscape = 0;

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  String _filePath;
  bool _rememberMe = false;
  final _debouncer = Debouncer(2000);

  _getadmindata() {
    Admin.getUsers(2).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        adminslist = list.map((model) => Admins.fromJson(model)).toList();
        adminsfiltter = adminslist;
      });
    });
  }

  _getuserdta() {
    Admin.getUsers(1).then((response) {
      setState(() {
        Iterable listuser = json.decode(response.body);
        userslist = listuser.map((model) => Admins.fromJson(model)).toList();
        usersfiltter = userslist;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getuserdta();
    _getadmindata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page == 0
              ?
      usersfiltter.length > 0
      ? new ListView.builder(
                  itemCount: usersfiltter.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    if (index == 0) {
                      return Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextField(
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red[900],
                              fontFamily: 'Sans',
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Colors.red[900], width: 2),
                              ),
                              contentPadding: EdgeInsets.only(top: 14.0),
                              hintText: 'ابحث هنا',
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Colors.red[900], width: 2),
                              ),
                              suffixIcon: Icon(
                                Icons.youtube_searched_for,
                                color: Colors.red[900],
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            onChanged: (string) {
                              _debouncer.run(() {
                                setState(() {
                                  usersfiltter = userslist
                                      .where((u) =>
                                  (u.realname
                                      .toLowerCase()
                                      .contains(string.toLowerCase())))
                                      .toList();
                                });
                              });
                            },
                          ),
                        ),
                        /* هذا ال container  مضاف عشان مايتكرر الاسم مرتين*/
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
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPageScreen()),
                                  );
                                });
                              },
                              color: Colors.white,
                              shape: SuperellipseShape(
                                borderRadius: BorderRadius.circular(28.0),
                              ), // SuperellipseShape
                              child: ListTile(
                                leading: IconButton(
                                  icon: Icon(
                                    Icons.person_pin,
                                    color: Colors.red[900],
                                    size: 50.0,
                                  ),
                                  onPressed: () {
                      /*    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                                  },
                                ),
                                title: Text(
                                  usersfiltter[index].realname,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: Colors.red[900],
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sans',
                                    fontSize: 15.0,
                                  ),
                                ),
                                subtitle: Text(
                                  "زبون",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Sans',
                                      fontSize: 12.0),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPageScreen()),
                                  );
                                },
                              ),
                            )
                        )
                      ]
                      );
                    } else {
                      return Container(
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
                              SchedulerBinding.instance.addPostFrameCallback((
                                  _) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPageScreen()),
                                );
                              });
                            },
                            color: Colors.white,
                            shape: SuperellipseShape(
                              borderRadius: BorderRadius.circular(28.0),
                            ), // SuperellipseShape
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  Icons.person_pin,
                                  color: Colors.red[900],
                                  size: 50.0,
                                ),
                                onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                                },
                              ),
                              title: Text(
                                usersfiltter[index].realname,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sans',
                                  fontSize: 15.0,
                                ),
                              ),
                              subtitle: Text(
                                "زبون",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sans',
                                    fontSize: 12.0),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPageScreen()),
                                );
                              },
                            ),
                          ));
                    }
                  }):
      Column(children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Sans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                    color: Colors.red[900], width: 2),
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'ابحث هنا',
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                    color: Colors.red[900], width: 2),
              ),
              suffixIcon: Icon(
                Icons.youtube_searched_for,
                color: Colors.red[900],
                textDirection: TextDirection.rtl,
              ),
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  usersfiltter = userslist
                      .where((u) =>
                  (u.realname
                      .toLowerCase()
                      .contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
        ),
      ]
      )
          : adminsfiltter.length > 0
              ?new ListView.builder(
          itemCount: adminsfiltter.length,
          itemBuilder: (BuildContext ctxt, int index) {
            if (index == 0) {
              return Column(children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red[900],
                      fontFamily: 'Sans',
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Colors.red[900], width: 2),
                      ),
                      contentPadding: EdgeInsets.only(top: 14.0),
                      hintText: 'ابحث هنا',
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Colors.red[900], width: 2),
                      ),
                      suffixIcon: Icon(
                        Icons.youtube_searched_for,
                        color: Colors.red[900],
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    onChanged: (string) {
                      _debouncer.run(() {
                        setState(() {
                          adminsfiltter = userslist
                              .where((u) =>
                          (u.realname
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                              .toList();
                        });
                      });
                    },
                  ),
                ),
                /* هذا ال container  مضاف عشان مايتكرر الاسم مرتين*/
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
                        SchedulerBinding.instance
                            .addPostFrameCallback((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPageScreen()),
                          );
                        });
                      },
                      color: Colors.white,
                      shape: SuperellipseShape(
                        borderRadius: BorderRadius.circular(28.0),
                      ), // SuperellipseShape
                      child: ListTile(
                        leading: IconButton(
                          icon: adminsfiltter[index].role == 3
                              ? Icon(
                            Icons.person_pin,
                            color: Colors.red[900],
                            size: 50.0,
                          )
                              : Icon(
                            Icons.motorcycle,
                            color: Colors.red[900],
                            size: 50.0,
                          ),
                          onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                          },
                        ),
                        title: Text(
                          adminsfiltter[index].realname,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize: 15.0,
                          ),
                        ),
                        subtitle: adminsfiltter[index].role == 3
                            ? Text(
                          "مدير",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sans',
                              fontSize: 12.0),
                        )
                            : Text(
                          "موصل طلبات",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sans',
                              fontSize: 12.0),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPageScreen()),
                          );
                        },
                      ),
                    )
                )
              ]
              );
            } else {
              return Container(
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
                      SchedulerBinding.instance.addPostFrameCallback((
                          _) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPageScreen()),
                        );
                      });
                    },
                    color: Colors.white,
                    shape: SuperellipseShape(
                      borderRadius: BorderRadius.circular(28.0),
                    ), // SuperellipseShape
                    child: ListTile(
                      leading: IconButton(
                        icon: adminsfiltter[index].role == 3
                            ? Icon(
                          Icons.person_pin,
                          color: Colors.red[900],
                          size: 50.0,
                        )
                            : Icon(
                          Icons.motorcycle,
                          color: Colors.red[900],
                          size: 50.0,
                        ),
                        onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                        },
                      ),
                      title: Text(
                        adminsfiltter[index].realname,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        ),
                      ),
                      subtitle: adminsfiltter[index].role == 3
                          ? Text(
                        "مدير",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize: 12.0),
                      )
                          : Text(
                        "موصل طلبات",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize: 12.0),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPageScreen()),
                        );
                      },
                    ),
                  ));
            }
          }):
      Column(children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Sans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                    color: Colors.red[900], width: 2),
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'ابحث هنا',
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                    color: Colors.red[900], width: 2),
              ),
              suffixIcon: Icon(
                Icons.youtube_searched_for,
                color: Colors.red[900],
                textDirection: TextDirection.rtl,
              ),
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  usersfiltter = userslist
                      .where((u) =>
                  (u.realname
                      .toLowerCase()
                      .contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
        ),
      ]
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.supervisor_account,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person_pin,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: Colors.red[900],
        buttonBackgroundColor: Colors.red[900],
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
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

class Debouncer {
  final int milliseconds;

  VoidCallback action;

  Timer _timer;

  Debouncer(this.milliseconds);

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
