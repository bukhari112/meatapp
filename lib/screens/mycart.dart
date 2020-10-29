import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/edit_cash.dart';
import 'package:meatappapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/api.dart';
import 'edit_order.dart';
import 'main_page.dart';

var cartlist = new List<Carttable>();

class MycartPage extends KFDrawerContent {
  int level;

  MycartPage(this.level);
  @override
  _MycartPageState createState() => _MycartPageState();
}

class _MycartPageState extends State<MycartPage> {
  bool _visible = true;
  final _addressController = TextEditingController();
  bool visible = false;

  bool unvisible = true;

  _getCartdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Cart.getCart(prefs.getString('id'),widget.level).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        cartlist = list.map((model) => Carttable.fromJson(model)).toList();
      });
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Methode for edit level data to mysql
  void _confirmtotal() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Showing CircularProgressIndicator using State.
      setState(() {
        visible = true;
        unvisible = false;
      });

      String _username = prefs.getString('realname');
      String _userid = prefs.getString('id');
      String _phone = prefs.getString('phone');
      String _dateorder = "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}";
String address = _addressController.text;
      FormData formData =
          // new FormData.fromMap({"name": "bukhari" });
          new FormData.fromMap({
        "username": _username,
        "phone": _phone,
            "dateorder": _dateorder,
            "address": address,
        "userid": _userid
      });
      Response response = await Dio().post(
          "http://semicolon-sd.com/covid19/confirmtotal",
          data: formData);
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
            title: new Text("$response",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontFamily: 'Sans',
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold)),
            actions: [
              FlatButton(
                child: new Text("حسنا",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Sans',
                        color: Colors.red[500],
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainPageScreen()),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCartdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "لحوم بلدي",
        ),
      ),
      body: Stack(children: <Widget>[
        cartlist.length > 0
            ? new ListView.builder(
                itemCount: cartlist.length + 1,
                itemBuilder: (BuildContext ctxt, int index) {
                  // checking if the index item is the last item of the list or not
                  if (index == cartlist.length) {
                    if(widget.level == 0) {
                      return Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 25.0),
                            width: double.infinity,
                            child: RaisedButton(
                              elevation: 5.0,
                              padding: EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              color: Colors.red[200],
                              onPressed: () => _selectDate(context),
                              child: Text(
                                "^" +
                                    "\t\t\t" +
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                controller: _addressController,
                                obscureText: false,
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
                                        color: Colors.red[200], width: 2),
                                  ),
                                  contentPadding: EdgeInsets.only(top: 20.0),
                                  hintText: " عنوان التوصيل ",
                                  labelText: "عنوان التوصيل",
                                  labelStyle: TextStyle(
                                    color: Colors.red[900],
                                    fontFamily: 'Sans',
                                    fontSize: 12.0,
                                  ),
                                  hintStyle: kHintTextStyle,
                                  suffixIcon: Icon(
                                    Icons.title,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Colors.red[900], width: 2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: unvisible,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 5.0,
                                onPressed: _confirmtotal,
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.red[900],
                                child: Text(
                                  'تأكيد الطلب ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sans',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: visible,
                              child: Container(
                                  margin: EdgeInsets.all(30.0),
                                  child: LoadingDoubleFlipping.square(
                                    size: 30,
                                    backgroundColor: Colors.red[200],
                                  ))),
                        ]),
                      );
                    }
                  } else {
                    return Container(
                        alignment: Alignment.centerRight,
                        color: Colors.white,
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.red[900],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditOrdersPage(cartlist, index)),
                                );
                              },
                            ),
                            title: Text(
                              cartlist[index].killo +
                                  "\t (كيلو) \t" +
                                  "\t\tعدد" +
                                  "\t\t " +
                                  "(" +
                                  cartlist[index].number.toString() +
                                  ")",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sans'),
                            ),
                            subtitle: Text(
                              "${cartlist[index].cash.toString()}" +
                                  "\t\t" +
                                  "ريال",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sans'),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditOrdersPage(cartlist, index)),
                              );
                            },
                          ),
                        ));
                  }
                }
                  )
            : Center(
                child: LoadingDoubleFlipping.square(
                  size: 50,
                  backgroundColor: Colors.red[900],
                ),
              ),
      ]),
    );
  }
}
