
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/edit_cash.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/api.dart';

class EditOrdersPage extends StatefulWidget {
  int index;
  List<Carttable> list;
  EditOrdersPage(this.list , this.index);

  @override
  _EditOrdersPageState createState() => _EditOrdersPageState();
}

class _EditOrdersPageState extends State<EditOrdersPage> {


   int _currentIntValue = 0;
  var total = 0;
  int i= 0;
   bool visible = false;

   bool unvisible = true;
  num _currentItemSelectedcontent = 0;
  final _noticeController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIntValue = widget.list[widget.index].number;
  }


  NumberPicker integerNumberPicker;
/*  _handleValueChanged(num value) {
    if (value != null) {
      //`setState` will notify the framework that the internal state of this object has changed.
      if (value is int) {
        setState(() => {
          _currentIntValue = value,
          total= value *_currentItemSelectedcontent,
          print(total)
        }
        );
      }
    }
  }*/
// Methode for insert data to mysql
  void _editdata() async {
    try {
      // Showing CircularProgressIndicator using State.
      setState(() {
        visible = true;
        unvisible = false;
      });
      int _number = _currentIntValue;
      int _cash = _currentItemSelectedcontent;
      int _total = total;
      /*showDialog(
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
     */
      FormData formData =
      // new FormData.fromMap({"name": "bukhari" });
      new FormData.fromMap({
        "number": _number,
        "cash": _cash,
        "total": _total,
      });
      Response response = await Dio()
          .post("http://www.baladisa.com/covid19/editcart/${widget.list[widget.index].id}", data: formData);
      print("File upload response: $response");
      // If Web call Success than Hide the CircularProgressIndicator.
/*        if (response.statusCode == 200) {
          setState(() {
            visible = false;
            unvisible = true;
          });
        }*/
      // Showing Alert Dialog with Response JSON Message.

      showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("${response}",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontFamily: 'Sans',
                    color: Colors.red[900],
                    fontSize: 13.0,
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
      // Show the incoming message in snakbar
      //_showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  void add() {
    setState(() {
      if(_currentIntValue == 0 ){
        _currentIntValue = widget.list[widget.index].number;
      }
      if(_currentItemSelectedcontent == 0.0){
        _currentItemSelectedcontent = widget.list[widget.index].cash;
      }
      _currentIntValue +=1;
      total= _currentIntValue *_currentItemSelectedcontent;
    });
  }

  void minus() {
    setState(() {
      if(_currentIntValue == 0){
        _currentIntValue = widget.list[widget.index].number;
      }
      if(_currentItemSelectedcontent == 0.0){
        _currentItemSelectedcontent = widget.list[widget.index].cash;
      }
      if(_currentIntValue > 1) {
        _currentIntValue -= 1;
        total= _currentIntValue*_currentItemSelectedcontent;
      }
    });
  }


  _handleValueChangedExternally(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
        integerNumberPicker.animateInt(value);
      }
    }
  }
  Future _showIntegerDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 1,
          maxValue: 100,
          step: 10,
          initialIntegerValue: _currentIntValue,
        );
      },
    ).then(_handleValueChangedExternally);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.red[900],
          centerTitle: true,
          title:
              total== 0 ?
          Text(
            "\t\t\t"+widget.list[widget.index].total.toString()+"\t\t\t"+ "(ريال سعودي)"+"\t\t\t"+ widget.list[widget.index].killo +"\t\t\t"+ "(كيلو)",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'Sans',
            ),
            textAlign: TextAlign.center,
          ):  Text(
                "\t\t\t"+total.toString()+"\t\t\t"+ "(ريال سعودي)"+"\t\t\t"+ widget.list[widget.index].killo +"\t\t\t"+ "(كيلو)",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Sans',
                ),
                textAlign: TextAlign.center,
              )
      ),
      body:
      ListView(
        padding:EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/product.png',
              width:double.infinity,
              height:250.0,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child:  Center(child:
                Text(
                  "\t\t\t"+widget.list[widget.index].killo.toString()+"\t\t\t"+ "(كيلو)",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Sans',
                  ),
                  textAlign: TextAlign.center,
                ),
                ),
              ),
                Expanded(child: Container(
                padding:EdgeInsets.all(10.0),
                child: Text(
                  'الحجم',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sans',
                  ),
                ),
              ),
                ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child:  Center(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      widget.list[widget.index].level == 0?
                      FloatingActionButton(
                        heroTag: "btn1",
                        onPressed: minus,
                        child: new Icon(Icons.minimize, color: Colors.red[900],),
                        backgroundColor: Colors.white,):
                      Container(),
                      Container(padding:EdgeInsets.all(20.0),
                        child:
                        _currentIntValue == 0?
                        Text('${widget.list[widget.index].number}',
                            style: new TextStyle(fontSize: 15.0,color:Colors.red[900])):
                        Text('$_currentIntValue',
                            style: new TextStyle(fontSize: 15.0,color: Colors.red[900]))
                        ,),
                      widget.list[widget.index].level == 0?
                      FloatingActionButton(
                        heroTag: "btn2",
                        onPressed: add,
                        child: new Icon(Icons.add, color: Colors.red[900],),
                        backgroundColor: Colors.white,):
                      Container(),
                    ],
                  ),
                ),
              ),
    Expanded(child:Container(
                padding:EdgeInsets.all(10.0),
                child: Text(
                  'الكمية',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sans',
                  ),
                ),
              ),
    ),
            ],
          ),
          SizedBox(height:5.0,),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Expanded(
    child:  Center(child:
    total== 0 ?
    Text(
    "\t\t\t"+widget.list[widget.index].total.toString()+"\t\t\t"+ "(ريال سعودي)",
    textDirection: TextDirection.rtl,
    style: TextStyle(
      color: Colors.red[900],
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    fontFamily: 'Sans',
    ),
    textAlign: TextAlign.center,
    ):  Text(
    "\t\t\t"+total.toString()+"\t\t\t"+ "(ريال سعودي)",
    textDirection: TextDirection.rtl,
    style: TextStyle(
      color: Colors.red[900],
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    fontFamily: 'Sans',
    ),
    textAlign: TextAlign.center,
    ),
    ),
    ),
    Expanded(child:Container(
    padding:EdgeInsets.all(10.0),
    child: Text(
    'مجموع المبلغ',
    textDirection: TextDirection.rtl,
    style: TextStyle(
    color: Colors.black,
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sans',
    ),
    ),
    ),
    ),
    ],
    ),

          SizedBox(
            height: 5.0,
          ),
          widget.list[widget.index].level == 0?
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child:
              Container(
                padding: EdgeInsets.all( 10.0),
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () => _showIntegerDialog(),
                  padding: EdgeInsets.all(5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.red[900],
                  child: Text(
                    'مشاركة',
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
              ),
              Expanded(child:Container(
                padding: EdgeInsets.all( 10.0),
    child: Visibility(
    visible: unvisible,
    child: Container(
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {_editdata(); },
                  padding: EdgeInsets.all(5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.red[900],
                  child: Text(
                    '($_currentIntValue)'+'طلب',
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
              ),
    ),
              )
            ],
          ):Container(),
          SizedBox(height: 20.0),
          widget.list[widget.index].level==2?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
    Expanded(child: Container(
                child:  Center(child:
                Text(
                  "\t\t\t"+widget.list[widget.index].adminname.toString()+"\t\t\t",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Sans',
                  ),
                  textAlign: TextAlign.center,
                ),
                ),
              ),
    ),
    Expanded(child: Container(
                padding:EdgeInsets.all(10.0),
                child: Text(
                  'اسم الموصل',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sans',
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
            ],
          ):Container(),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}