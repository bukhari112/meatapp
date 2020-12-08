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

var listofcart = new List<Carttable>();

class DetailsOrderScreen extends StatefulWidget {
  int userid;
  List<Totalcart> list;
  DetailsOrderScreen(this.userid , this.list);

  @override
  _DetailsOrderScreenState createState() => _DetailsOrderScreenState();
}

class _DetailsOrderScreenState extends State<DetailsOrderScreen> {

  bool visible = false ;
  bool unvisible = true ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCartdata();
    print(widget.list[0].level);
    print(widget.list[0].userid);
  }

  _getCartdata() {
    Cart.getCart(widget.list[0].userid.toString(), widget.list[0].level).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        listofcart = list.map((model) => Carttable.fromJson(model)).toList();
      });
    });
  }


  // Methode for edit level data to mysql
  void _nextlevelorder(int level) async {
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
            "http://www.baladisa.com/covid19/nextlevel/${widget.userid}/$level}", data: formData);
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


  nextlevel(int level){
_nextlevelorder(level);
  }

  _configratedmsg (){
    return showDialog(
      context:this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("اضغط علي حسناً لـتأكيد الطلب ",textDirection: TextDirection.rtl,style:TextStyle(fontFamily: 'Sans',color:Colors.red[900],fontWeight: FontWeight.bold)),
          actions: [
            FlatButton(
              child: new Text("حسنا",textDirection: TextDirection.rtl,style:TextStyle(fontFamily: 'Sans',color:Colors.red[500],fontWeight: FontWeight.bold)),
              onPressed: () {
               widget.list[0].level== 1?
                   nextlevel(2):
                   nextlevel(3);
              },
            ),
            FlatButton(
              child: new Text("الغاء", textDirection: TextDirection.rtl,
                  style: TextStyle(fontFamily: 'Sans',
                      color: Colors.red[500],
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  visible = false;
                  unvisible = true;
                });
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
         listofcart.length > 0 ?
         new ListView.builder(
            itemCount: listofcart.length + 1,
            itemBuilder: (BuildContext ctxt, int index) {
              print(index);
              // checking if the index item is the last item of the list or not
              // هذا الشرط لكتابة معلومات المستخدم بعد عرض جميع طلباته الجددية
              if (index == listofcart.length) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Directionality(
                      textDirection:TextDirection.rtl,
                      child: ListTile(
                        leading: IconButton(
                    icon: Icon(Icons.person, color: Colors.red[900],),
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
                          widget.list[0].username,
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
                          widget.list[0].phone,
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
                          widget.list[0].address,
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
                          icon: Icon(Icons.calendar_today, color: Colors.red[900],),
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
                          widget.list[0].dateorder,
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
                          icon: Icon(Icons.motorcycle, color: Colors.red[900],),
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
                          widget.list[0].adminname,
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
                                widget.list[0].level == 1?
                                FloatingActionButton(
                                  heroTag: "btn1",
                                  onPressed: _configratedmsg,
                                  child: new Icon(Icons.motorcycle, color: Colors.white),
                                  backgroundColor: Colors.red[900],)
                                    :
                                FloatingActionButton(
                                  heroTag: "btn2",
                                  onPressed: _configratedmsg,
                                  child: new Icon(Icons.done_all, color: Colors.white),
                                  backgroundColor: Colors.red[900],),


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
                    );
              }
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
                        },
                      ),
                      title: Text(
                        listofcart[index].killo +
                            "\t (كيلو) \t" +
                            "\t\tعدد" +
                            "\t\t " +
                            "(" +
                            listofcart[index].number.toString() +
                            ")",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans'),
                      ),
                      subtitle: Text(
                        "${listofcart[index].cash.toString()}" +
                            "\t\t" +
                            "ريال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans'),
                      ),
                      onTap: () {
                      },
                    ),
                  ));
            })
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
