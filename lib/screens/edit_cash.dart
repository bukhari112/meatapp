import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/control_page.dart';
import 'package:meatappapp/screens/islamic.dart';

import 'main_page.dart';

class EditCashScreen extends StatefulWidget {
  int index;
  List list= new List<Cash>();
  EditCashScreen(this.list,this.index);
  @override
  _EditCashScreenState createState() => _EditCashScreenState();
}

class _EditCashScreenState extends State<EditCashScreen> {
  bool visible = false ;
  bool unvisible = true ;
  final _cashController = TextEditingController();
  final _killoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  insertdata(){
    _adddata();
  }
  // Methode for insert data to mysql
  void _adddata() async {
    try {
      // Showing CircularProgressIndicator using State.
      setState(() {
        visible = true ;
        unvisible = false;
      });
      String _cash = _cashController.text;
      String _killo = _killoController.text;
      if(_cash=='' || _killo==''){
        showDialog(
          context:this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("عفوا : املأ جميع الحقول",textDirection: TextDirection.rtl,style:TextStyle(fontFamily: 'Sans',color:Colors.red[900],fontWeight: FontWeight.bold)),
              actions: [
                FlatButton(
                  child: new Text("حسنا",textDirection: TextDirection.rtl,style:TextStyle(fontFamily: 'Sans',color:Colors.red[500],fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }else {
        FormData formData =
        // new FormData.fromMap({"name": "bukhari" });
        new FormData.fromMap({"cash": _cash, "killo": _killo});
        Response response =
        await Dio().post(
            "http://semicolon-sd.com/covid19/editcash/${widget.list[widget
                .index].id}", data: formData);
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
      }
      // Show the incoming message in snakbar
      //_showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }
  _deletedata(){
    _deletefile();
  }
  // Methode for file upload
  void _deletefile() async {
    // Get base file name

    try {
      FormData formData =
      // new FormData.fromMap({"name": "bukhari" });
      new FormData.fromMap({"data":"delete"});
      Response response =
      await Dio().post("http://semicolon-sd.com/covid19/deletedata/Cashdata/${widget.list[widget.index].id}", data: formData);
      // print("File upload response: $response");
      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context:this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("$response",textDirection: TextDirection.rtl,style:TextStyle(fontFamily: 'Sans',color:Colors.blue,fontWeight: FontWeight.bold)),
            actions: [
              FlatButton(
                child: new Text("حسنا",textDirection: TextDirection.rtl,style:TextStyle(fontFamily: 'Sans',color:Colors.blue,fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => MainPageScreen()),
                      ModalRoute.withName('/'));
                },
              ),
            ],
          );
        },
      );
      // Show the incoming message in snakbar
      //_showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }
  Widget _buildCash() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            controller: _cashController..text = "${widget.list[widget.index].cash}",
            obscureText: false,
            keyboardType: TextInputType.number,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Sans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[200], width: 2),
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'ادخل المبلغ',
              suffixIcon: Icon(
                Icons.monetization_on,
                color: Colors.red[900],
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[900], width: 2),
              ),
            ),

          ),
        ),
      ],
    );
  }
  Widget _buildKillo() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            controller: _killoController..text = "${widget.list[widget.index].killo}",
            obscureText: false,
            keyboardType: TextInputType.number,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Sans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[200], width: 2),
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'ادخل الحجم ',
              suffixIcon: Icon(
                Icons.kitchen,
                color: Colors.red[900],
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[900], width: 2),
              ),
            ),

          ),
        ),
      ],
    );
  }
  Widget _buildCashBtn() {
    return Visibility(
      visible: unvisible,
      child:Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: insertdata,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.red[900],
          child: Text(
            'موافق',
            style: TextStyle(
              color: Colors.white,
              letterSpacing:.5,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sans',
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width:double.infinity ,
            height:300.0,
            child:Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                width: double.infinity,
              ),
            ),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/slid1.png'),
                fit: BoxFit.cover,
              ),

            ),
          ),
          Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildKillo()),
          Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildCash()),
          SizedBox(
            height: 5.0,
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
          SizedBox(
            height: 5.0,
          ),
          Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildCashBtn())
          ,
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed:_deletedata,
        tooltip: 'حذف ',
        backgroundColor: Colors.red[900],
        child: new Icon(Icons.delete,color: Colors.white,),),
    );
  }
}
