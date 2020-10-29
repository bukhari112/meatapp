import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/main.dart';
import 'package:meatappapp/screens/confirm_page.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/main_page.dart';
import 'package:meatappapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';


var doaa = new List<Islamic>();
int _landiscape = 0 ;
class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Getting value from TextField widget.
  final _emailController = TextEditingController();
  final _PasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _RealNameController = TextEditingController();
  final _AddressController = TextEditingController();
  final _RePassordController = TextEditingController();

  bool visible = false;
  bool unvisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  insertdata() {
    _adddata();
  }

  // Methode for insert data to mysql
  void _adddata() async {
    try {
      // Showing CircularProgressIndicator using State.
      setState(() {
        visible = true;
        unvisible = false;
      });
      String email = _emailController.text;
      String password = _PasswordController.text;
      String repassword = _RePassordController.text;
      String realname = _RealNameController.text;
      String phone = _phoneNumberController.text;
      String address = _AddressController.text;
      if (password != repassword) {
        // Showing Alert Dialog with Response JSON Message.
        showDialog(
          context: this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(
                  "كلمات المرور ليست متشابهة", textDirection: TextDirection.rtl,
                  style: TextStyle(fontFamily: 'Sans',
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold)),
              actions: [
                FlatButton(
                  child: new Text("حسنا", textDirection: TextDirection.rtl,
                      style: TextStyle(fontFamily: 'Sans',
                          color: Colors.red[500],
                          fontWeight: FontWeight.bold)),
                  onPressed:  () {
                    Navigator.of(context).pop();
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
      } else {
        FormData formData =
        // new FormData.fromMap({"name": "bukhari" });
        new FormData.fromMap({
          'email': email,
          'password': password,
          'realname': realname,
          'phone': phone,
          'address': address
        });
        Response response =
        await Dio().post(
            "http://semicolon-sd.com/covid19/addadminsmeat", data: formData);
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
                  onPressed:
                      () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
                        ModalRoute.withName('/'));
                  }
                  ,
                ),
              ],
            );
          },
        );
        // Show the incoming message in snakbar
      } //_showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }


  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Sans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[200], width: 2),),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'اسم المستخدم',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[900], width: 2),
              ),
              suffixIcon: Icon(
                Icons.person_pin,
                color: Colors.red[900],
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            controller: _PasswordController,
            obscureText: true,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Sans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[200], width: 2),),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'كلمة المرور',
              suffixIcon: Icon(
                Icons.lock,
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

  Widget _buildRepasswordTF() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            controller: _RePassordController,
            obscureText: true,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Sans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[200], width: 2),),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'اعادة كلمة المرور',
              suffixIcon: Icon(
                Icons.lock_outline,
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

  Widget _buildRealname() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            controller: _RealNameController,
            obscureText: false,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Sans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[200], width: 2),),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'الاسم الحقيقي',
              suffixIcon: Icon(
                Icons.person,
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

  Widget _buildPhone() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            obscureText: false,
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
              hintText: 'رقم الهاتف',
              suffixIcon: Icon(
                Icons.phone,
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

  Widget _buildMap() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerRight,
          child: TextField(
            controller: _AddressController,
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
              hintText: 'عنوان السكن',
              suffixIcon: Icon(
                Icons.map,
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

  Widget _buildLoginBtn() {
    return Visibility(
        visible: unvisible,
        child: Container(
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
          'تسجيل البيانات',
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
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
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
                    image: new AssetImage('assets/slid1.png'),
                    fit: BoxFit.cover,
                  ),

                ),
              ),
              Container(padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: _buildEmailTF())
              ,
              SizedBox(
                height: 5.0,
              ),
              Container(padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: _buildPasswordTF())
              ,
              SizedBox(
                height: 5.0,
              ),
              Container(padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: _buildRepasswordTF())
              ,
              SizedBox(
                height: 5.0,
              ),
              Container(padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: _buildRealname()),
              SizedBox(
                height: 5.0,
              ),
              Container(padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: _buildPhone()),
              SizedBox(
                height: 5.0,
              ),
              Container(padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: _buildMap()),
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
              Container(padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: _buildLoginBtn()),
            ]
        )
    );
  }
}







