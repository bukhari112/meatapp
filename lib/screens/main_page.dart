import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/cart_page.dart';
import 'package:meatappapp/screens/confirm_page.dart';
import 'package:meatappapp/screens/control_page.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/mycart.dart';
import 'package:meatappapp/screens/orders.dart';
import 'package:meatappapp/utils/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide action;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workmanager/workmanager.dart' ;
import 'api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'edit_user.dart';

List<Cashkillo> cashlistdata = [];

class MainPageScreen extends StatefulWidget {
  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  Timer timer;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;


  Future<List<Cashkillo>> _getCashkillo() async {
    var data = await http.get("https://www.baladisa.com/covid19/datacash");
    var jsonData = json.decode(data.body);
    for (var u in jsonData) {
      Cashkillo cash = Cashkillo(u["id"], u["cash"], u["killo"]);
      cashlistdata.add(cash);
    }
    return cashlistdata;
  }
  String roletest = "1" ;
  String _username;
  String _phone;
  String _email;
  String _address;
  String _password;
  String _id;
  String _role;
  String _rolenotification;
  _getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username  = prefs.getString('realname');
     _phone = prefs.getString('phone');
     _email = prefs.getString('email');
     _address = prefs.getString('address');
     _password = prefs.getString('password');
    _role = prefs.getString('role');
    _id = prefs.getString('id');

  }

  _getnotifucation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _role = prefs.getString('role');
    if (_rolenotification == "2" || _rolenotification == "3") {
      Cashdata.getCashdata().then((response) {
        setState(() {

        });
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    _getCashkillo();
    _getuserdata();
    _loadusername();
    timer = Timer.periodic(Duration(seconds:900), (Timer t) => _demoNotification());
  }


  Future<void> _demoNotification() async {
    /* check users and orders */
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _rolenotification = prefs.getString('role');
    print(_rolenotification);
    if (_rolenotification == "2" || _rolenotification == "3") {
      FormData formData =
      new FormData.fromMap({"role": "role"});
      Response response =
      await Dio().post(
          "http://www.baladisa.com/covid19/noto", data: formData);
      /* end check users and orders */
      if (response.toString() == "yes") {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'channel_ID', 'channel name', 'channel description',
            importance: Importance.Max,
            ticker: 'test ticker');

        var iOSChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(0, 'تنبيه !!',
            'هنالك طلبات في انتظارك يرجى التحقق منها ',
            platformChannelSpecifics,
            payload: 'test oayload');
      }
    }
  }
  void callbackDispatcher() {
    Workmanager.executeTask((task, inputData) async {
      print("hi bukhari this functions is work Good!!!");
      return Future.value(true);
    });

  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new MainPageScreen()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPageScreen()));
              },
            )
          ],
        ));
  }
  _loadusername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      roletest = prefs.getString('role');
    });
  }

  Widget _showpage = new HomePagePage(cashlistdata);

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return HomePagePage(cashlistdata);
        break;

      case 1:
        return ContactPage();
        break;
      case 2:
        return ProfilePage(_id , _role , _username ,_email , _password , _phone , _address);
        break;
      case 3:
        return
          roletest == "3" ?
          ControlPage():
          roletest == "2" ?
          OrderPageScreen():
          roletest == "1"?
          WhousPage():
              WhousPage();
        break;
      default:
        return HomePagePage(cashlistdata);
    }
  }


  clearsessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   await  prefs.clear();
  }
exitfun(){
  // Showing Alert Dialog with Response JSON Message.
  showDialog(
    context: this.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("هل تريد بالتأكيد الخروج", textDirection: TextDirection.rtl,
            style: TextStyle(fontFamily: 'Sans',
                color: Colors.red[900],
                fontWeight: FontWeight.bold)),
        actions: [
          FlatButton(
            child: new Text("  نعم اريد", textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: 'Sans',
                    color: Colors.red[500],
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              clearsessions();
              SystemNavigator.pop();
            },
          ),
          FlatButton(
            child: new Text(" لا اريد", textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: 'Sans',
                    color: Colors.red[500],
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              timer?.cancel();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    //build numberpicker for integer numbers
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red[900],
        centerTitle: true,
        title: Text(
          "لحوم بلدي",
          style: TextStyle(fontFamily: 'Sans'),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed:(){ exitfun(); },
          ),
        ],
      ),
      body: Container(
        color: Colors.transparent,
        child: Center(
          child: _showpage,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.phone,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.perm_contact_calendar,
            size: 30,
            color: Colors.white,
          ),
roletest == "3"?
          Icon(
            Icons.dashboard,
            size: 30,
            color: Colors.white,
          ):
roletest == "2"?
Icon(
  Icons.motorcycle,
  size: 30,
  color: Colors.white,
):roletest == "1"?
Icon(
  Icons.info,
  size: 30,
  color: Colors.white,
):Container(),
        ],
        color: Colors.red[900],
        buttonBackgroundColor: Colors.red[900],
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _showpage = _pageChooser(index);
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

class OrdersPage extends StatefulWidget {
  List<Cashkillo> list;
  OrdersPage(this.list);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int _currentIntValue = 1;
  int total = 0;

  int i = 0;
  bool visible = false;

  bool unvisible = true;

  int _currentItemSelectedcontent = 0;
  String _currentItemSelectedkillo = 'اختر الحجم';
  String _currentItemSelectedmeat = "كامل";
  final _noticeController = TextEditingController();

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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Showing CircularProgressIndicator using State.
      setState(() {
        visible = true;
        unvisible = false;
      });
      String _killo = _currentItemSelectedkillo;
      int _number = _currentIntValue;
      int _cash = _currentItemSelectedcontent;
      int _total = total;
      String _away = _currentItemSelectedmeat;
      String _notice = _noticeController.text;
      String _userid = prefs.getString('id');
      String _username = prefs.getString('realname');
      String _phone = prefs.getString('phone');

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
      if (_notice == '') {
        _notice = "لاتوجد ملاحظات";
      }
      FormData formData =
          // new FormData.fromMap({"name": "bukhari" });
          new FormData.fromMap({
        "killo": _killo,
        "number": _number,
        "cash": _cash,
        "total": _total,
        "away": _away,
        "notice": _notice,
        "userid": _userid,
        "username": _username,
        "phone": _phone,
      });
      Response response = await Dio()
          .post("http://www.baladisa.com/covid19/addtocart", data: formData);
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

  NumberPicker integerNumberPicker;

/*  _handleValueChanged(num value) {
    if (value != null) {
      //`setState` will notify the framework that the internal state of this object has changed.
      if (value is int) {
        setState(() => {
        _currentIntValue = value,
          total= value.toDouble()*_currentItemSelectedcontent,
print(total)
        }
        );
      }
    }
  }*/

  void add() {
    setState(() {
      _currentIntValue += 1;
      total = _currentIntValue * _currentItemSelectedcontent;
    });
  }

  void minus() {
    setState(() {
      if (_currentIntValue > 1) {
        _currentIntValue -= 1;
        total = _currentIntValue * _currentItemSelectedcontent;
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
          step: 1,
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
          title: _currentItemSelectedkillo != 'اختر الحجم'
              ? Text(
                  "\t\t\t" +
                      total.toString() +
                      "\t\t\t" +
                      "(ريال سعودي)" +
                      "\t\t\t" +
                      _currentItemSelectedkillo +
                      "\t\t\t" +
                      "(كيلو)",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Sans',
                  ),
                  textAlign: TextAlign.center,
                )
              : Text(
                  "\t\t\t" +
                      widget.list[0].cash.toString() +
                      "\t\t\t" +
                      "(ريال سعودي)" +
                      "\t\t\t" +
                      widget.list[0].killo +
                      "\t\t\t" +
                      "(كيلو)",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Sans',
                  ),
                  textAlign: TextAlign.center,
                )),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/product.png',
              width: double.infinity,
              height: 130.0,
            ),
          ),
          SizedBox(height: 5.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
Center(
       child:       Container(
                padding: EdgeInsets.all(10.0),
                child: Text("الاحجام",
                    style: TextStyle(
                        fontFamily: 'Sans',
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right),
              ),
),
              Center(
                child: Container(
                  child: DropdownButton<Cashkillo>(
                    dropdownColor: Colors.red[200],
                    hint: _currentItemSelectedkillo != 'اختر الحجم'
                        ? Text(
                      "\t\t\t" +
                          total.toString() +
                          "\t\t\t" +
                          "(ريال سعودي)" +
                          "\t\t\t" +
                          _currentItemSelectedkillo +
                          "\t\t\t" +
                          "(كيلو)",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.red[900],
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Sans',
                      ),
                      textAlign: TextAlign.center,
                    )
                        : Text("اختر الحجم"
                    ),
                    items: widget.list
                        .map((Cashkillo cashkillo) =>
                        DropdownMenuItem<Cashkillo>(
                          child: Expanded(
                            child: Text(
                              "\t\t\t" +
                                  cashkillo.cash.toString() +
                                  "\t\t\t" +
                                  "(ريال سعودي)" +
                                  "\t\t\t" +
                                  cashkillo.killo +
                                  "\t\t\t" +
                                  "(كيلو)",
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
                          value: cashkillo,
                        ))
                        .toList(),
                    onChanged: (Cashkillo newVlaueSelectedcontent) {
                      setState(() {
                        this._currentItemSelectedcontent =
                            newVlaueSelectedcontent.cash;
                        this._currentItemSelectedkillo =
                            newVlaueSelectedcontent.killo;
                        total = this._currentItemSelectedcontent *
                            this._currentIntValue;
                        print(newVlaueSelectedcontent.cash);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Column(
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Center(
               child:Container(
    padding: EdgeInsets.all(10.0),
                child: Text("التقطيع",
                    style: TextStyle(
                        fontFamily: 'Sans',
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right),
              ),
              ),
              Center(
                child: Container(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.red[200],
                    items: <String>['كامل', "انصاف", "ارباع", "ثلاجة", "مفاصل"]
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Expanded(
                          child: new Text(
                            value,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontFamily: 'Sans',
                                color: Colors.red[900],
                                fontSize: 13.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "اختر نوع التقطيع",
                      textDirection: TextDirection.rtl,
                      style:
                      TextStyle(fontFamily: 'Sans', color: Colors.red[900]),
                      textAlign: TextAlign.center,
                    ),
                    onChanged: (String newVlaueSelectedcontent) {
                      setState(() {
                        this._currentItemSelectedmeat = newVlaueSelectedcontent;
                      });
                    },
                    value: _currentItemSelectedmeat,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
              child:Container(
                padding: EdgeInsets.all(5.0),
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
              Center(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "btn1",
                        onPressed: minus,
                        child: new Icon(
                          Icons.minimize,
                          color: Colors.red[900],
                        ),
                        backgroundColor: Colors.white,
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text('$_currentIntValue',
                            style: new TextStyle(fontSize: 15.0)),
                      ),
                      FloatingActionButton(
                        heroTag: "btn2",
                        onPressed: add,
                        child: new Icon(
                          Icons.add,
                          color: Colors.red[900],
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: _noticeController,
                    obscureText: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red[900],
                      fontFamily: 'Sans',
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Colors.red[200], width: 2),
                      ),
                      contentPadding: EdgeInsets.only(top: 20.0),
                      hintText: "ملاحظات اذا وجدت ",
                      labelText: "ملاحظات اضافية اذا وجدت",
                      labelStyle: TextStyle(
                          color: Colors.red[900],
                          fontFamily: 'Sans',
                          fontSize: 12.0),
                      hintStyle: kHintTextStyle,
                      suffixIcon: Icon(
                        Icons.title,
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Colors.red[900], width: 2),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
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
                        letterSpacing: .5,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Visibility(
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
                          "${_currentIntValue}" + 'طلب',
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
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.only(top: 0, bottom: 20.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.4),
          spreadRadius: 3,
          blurRadius: 8,
          offset: Offset(0.0, 3.0),
        )
      ]),
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/slid1.png',
                width: double.infinity,
                height: 150,
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      ' العنوان',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Sans',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    Icon(Icons.map, color: Colors.red[900]),
                  ]),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                'المملكة العربية  -الرياض - شارع مكة',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Sans',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ' : تلفونات',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Icon(Icons.phone, color: Colors.red[900]),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '96624888888888',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      Text(
                        '966248882458',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '96624888888888',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      Text(
                        '966248882458',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ),
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              ' الايميل',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Sans',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            Icon(Icons.alternate_email, color: Colors.red[900]),
                          ]),
                      Text(
                        'example@gmail.com',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sans',
                        ),
                      ),
                    ]),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}

class HomePagePage extends KFDrawerContent {
  List<Cashkillo> list;

  HomePagePage(this.list);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePagePage> {
  bool _visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
      children: <Widget>[
        Container(
          child: Image.asset(
            'assets/header.png',
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0),
        ),
        new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
              margin: EdgeInsets.all(20),
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: Offset(0, 3))
              ]),
              child: FlatButton(
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPageScreen()),
                    );
                  });
                },
                color: Colors.white,
                shape: SuperellipseShape(
                  borderRadius: BorderRadius.circular(28.0),
                ), // SuperellipseShape
                child: AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.red[900],
                      size: 60.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      "متابعة طلباتي",
                      style: TextStyle(fontFamily: "Sans", color: Colors.black),
                    ),
                  ]),
                ), // Container
              )),
          Container(
              margin: EdgeInsets.all(20),
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: Offset(0, 3))
              ]),
              child: FlatButton(
                  onPressed: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrdersPage(widget.list)),
                      );
                    });
                  },
                  color: Colors.white,
                  shape: SuperellipseShape(
                    borderRadius: BorderRadius.circular(28.0),
                  ), // SuperellipseShape
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Icon(
                      Icons.table_chart,
                      color: Colors.red[900],
                      size: 60.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                    ),
                    Text(
                      "طلب ",
                      style: TextStyle(fontFamily: "Sans", color: Colors.black),
                    ),
                  ])
                  // Container
                  )),
        ]),
      ],
    ));
  }
}

class ProfilePage extends StatefulWidget {
  String username ;
  String email ;
  String password ;
  String phone ;
  String address ;
  String id ;
  String role ;

  ProfilePage(this.id, this.role, this.username, this.email, this.password, this.phone, this.address);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body:Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.only(top: 0, bottom: 20.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.4),
          spreadRadius: 3,
          blurRadius: 8,
          offset: Offset(0.0, 3.0),
        )
      ]),
      child: Container(
          color: Colors.white,
          child: ListView(
              children: <Widget>[
                Container(
                  width: 500.0,
                  height: 120.0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      width: double.infinity,
                    ),
                  ),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/profile.png'),
                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 5,
                        blurRadius:2,
                        offset: Offset(0, 3))
                  ]),
                  child: FlatButton(
                    onPressed: () {
                    },
                    color: Colors.white,
                    shape: SuperellipseShape(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: ListTile(leading: IconButton(
                      icon: Icon(Icons.person_pin, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                      },
                    ),
                      title: Text(
                        widget.username,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        )
                        ,),
                      subtitle: Text(
                        widget.email,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize:12.0)
                        ,),
                      onTap: () {

                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 5,
                        blurRadius: 2,
                        offset: Offset(0, 3))
                  ]),
                  child: FlatButton(
                    onPressed: () {
                    },
                    color: Colors.white,
                    shape: SuperellipseShape(
                      borderRadius: BorderRadius.circular(28.0),
                    ),

                    child:ListTile(leading: IconButton(
                      icon: Icon(Icons.lock, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DonePage(orderslistdata)),
              );*/

                      },
                    ),
                      title: Text(
                        "كلمة المرور",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        )
                        ,),
                      subtitle: Text(
                        widget.password,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize:12.0)
                        ,),
                      onTap: () {

                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 5,
                        blurRadius: 2,
                        offset: Offset(0, 3))
                  ]),
                  child: FlatButton(
                    onPressed: () {
                    },
                    color: Colors.white,
                    shape: SuperellipseShape(
                      borderRadius: BorderRadius.circular(28.0),
                    ),

                    child:ListTile(leading: IconButton(
                      icon: Icon(Icons.phone, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                      },
                    ),
                      title: Text(
                        "رقم الهاتف",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        )
                        ,),
                      subtitle: Text(
                        widget.phone,

                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize:12.0)
                        ,),
                      onTap: () {

                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 5,
                        blurRadius:2,
                        offset: Offset(0, 3))
                  ]),
                  child: FlatButton(
                    onPressed: () {
                    },
                    color: Colors.white,
                    shape: SuperellipseShape(
                      borderRadius: BorderRadius.circular(28.0),
                    ),

                    child: ListTile(leading: IconButton(
                      icon: Icon(Icons.map, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPageScreen()),
                      );*/
                      },
                    ),
                      title: Text(
                        "العنوان",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        )
                        ,),
                      subtitle: Text(
                        widget.address,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans',
                            fontSize:12.0)
                        ,),
                      onTap: () {

                      },
                    ),
                  ),
                ),
              ]
          )
      ),
    ),
        floatingActionButton:FloatingActionButton(
          heroTag: "btn1",
          onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EdituserScreen(widget.id,widget.role,widget.username,widget.email,widget.password,widget.phone ,widget.address)),
            );
          },
          child: new Icon(Icons.edit, color: Colors.red[900]),
          backgroundColor: Colors.white,),
      );
  }
}

class WhousPage extends StatefulWidget {

  @override
  _WhousPageState createState() => _WhousPageState();
}

class _WhousPageState extends State<WhousPage> {


  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.only(top: 0, bottom: 20.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.4),
          spreadRadius: 3,
          blurRadius: 8,
          offset: Offset(0.0, 3.0),
        )
      ]),
      child: Container(
          color: Colors.white,
          child: ListView(
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
                      image: new AssetImage('assets/who.jpg'),
                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 5,
                        blurRadius:2,
                        offset: Offset(0, 3))
                  ]),
                  child: FlatButton(
                    onPressed: () {
                    },
                    color: Colors.white,
                    shape: SuperellipseShape(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: ListTile(leading: IconButton(
                      icon: Icon(Icons.info, color: Colors.red[900],size:20.0,),
                      onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                      },
                    ),
                      title: Text(
                      "تطبيق لحوم بلدي",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 15.0,
                        )
                        ,),
                      onTap: () {

                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 5,
                        blurRadius: 2,
                        offset: Offset(0, 3))
                  ]),
                  child: FlatButton(
                    onPressed: () {
                    },
                    color: Colors.white,
                    shape: SuperellipseShape(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child:Center(
                      child:Text(
                        "نَحنُ مجموعة لحوم بلدي نُقدّم أجوَد أنواع اللحوم الطازجة بحُب وإخلاص وبإحترافية بالغة حيثُ نقوم بسلخها وتقطيعها وتوصيلها حَيثما كُنت، فهذا عَمَلنا على مرّ الأزمنة فهو ماضينا، حاضرنا ومُستقبلنا"
                     ,style: TextStyle(color: Colors.black87,fontFamily:'Sans'),
                        textDirection: TextDirection.rtl,
                      )
                    ),
                  ),
                ),
              ]
          )
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
