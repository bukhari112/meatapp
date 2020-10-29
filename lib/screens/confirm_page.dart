import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';

class ConfirmPageScreen extends StatefulWidget {
  @override
  _ConfirmPageScreenState createState() => _ConfirmPageScreenState();
}

class _ConfirmPageScreenState extends State<ConfirmPageScreen> {
  bool visible = false ;
  bool unvisible = true ;
  final _codeController = TextEditingController();

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
      String _code = _codeController.text;
      FormData formData =
      // new FormData.fromMap({"name": "bukhari" });
      new FormData.fromMap({"code":_code});
      Response response =
      await Dio().post("http://semicolon-sd.com/covid19/confirm", data: formData);
      print("File upload response: $response");
      // If Web call Success than Hide the CircularProgressIndicator.
      if(response.statusCode == 200){
        setState(() {
          visible = false;
          unvisible = true;
        });
      }
      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context:this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("$response",textDirection: TextDirection.rtl,style:TextStyle(fontFamily: 'Sans',color:Colors.red[900],fontWeight: FontWeight.bold)),
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
      // Show the incoming message in snakbar
      //_showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }
  Widget _buildCode() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            controller: _codeController,
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
              hintText: 'ادخل كود التأكيد',
              suffixIcon: Icon(
                Icons.fiber_pin,
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
  Widget _buildConfirmBtn() {
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
            'تأكيد',
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
          SizedBox(
            height: 5.0,
          ),
          Text(
            'ادخل كود التأكيد الذي وصلك في الايميل',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.red[900],
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'Sans',

            ),

          ),
          SizedBox(
            height: 5.0,
          ),
          Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildCode())
          ,
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
          Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildConfirmBtn())
          ,
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
