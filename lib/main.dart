import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/admins.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/main_page.dart';
import 'package:meatappapp/screens/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/class_builder.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
List<Admins> admindata =[];
void main() {
  ClassBuilder.registerClasses();
  runApp(new MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds:5,
      navigateAfterSeconds: new LoginScreen(),
      title:
      Text('مرحبا بكم ' ,
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          fontFamily: 'Sans',
          color:Colors.red[900]
        ),
      ),
      image: Image.asset(
        'assets/logo.png',
        fit:BoxFit.cover,
      ),
      backgroundColor:Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      loaderColor:Colors.red[900],
    );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  KFDrawerController _drawerController;




  @override
  void initState() {
    super.initState();


    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('MainPage'),
      items: [
        /*KFDrawerItem.initWithPage(
          text: Text('تطبيق نفحة الخيري ',
              style: TextStyle(color: Colors.white ,fontFamily:'Sans'
                  ,fontSize:15.0)),
          icon: Icon(Icons.developer_mode, color: Colors.white),
          page: MainPage(),
        ),

        KFDrawerItem.initWithPage(
          text: Text('هذا التطبيق صدقة جارية علي  ',
              style: TextStyle(color: Colors.white,fontSize:10.0,fontFamily: 'Sans')),
          icon: Icon(Icons.perm_identity, color: Colors.white),
          page: MainPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(' روح المرحوم جدي عبدالفتاح حسين أحمد ',
              style: TextStyle(color: Colors.white,fontSize:10.0,fontFamily: 'Sans')),
          icon: Icon(Icons.perm_identity, color: Colors.white),
          page: MainPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(' روح المرحوم  اسامة عبد العظيم  ',
              style: TextStyle(color: Colors.white,fontSize:10.0,fontFamily: 'Sans')),
          icon: Icon(Icons.perm_identity, color: Colors.white),
          page: MainPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('   كل من نشر التطبيق  ',
              style: TextStyle(color: Colors.white,fontSize:10.0,fontFamily: 'Sans')),
          icon: Icon(Icons.people_outline, color: Colors.white),
          page: MainPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('  جميع المسلمين وامهات واباء المسلمين    ',
              style: TextStyle(color: Colors.white,fontSize:10.0,fontFamily: 'Sans')),
          icon: Icon(Icons.people_outline, color: Colors.white),
          page: MainPage(),
        ),*/
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: KFDrawer(
//        borderRadius: 0.0,
//        shadowBorderRadius: 0.0,
//        menuPadding: EdgeInsets.all(0.0),
//        scrollable: true,
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Image.asset(
              'assets/nafha.png',
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'عن المطور ',
            style: TextStyle(color: Colors.white,fontSize:10.0,fontFamily: 'Sans'),
          ),
          icon: Icon(
            Icons.code,
            color: Colors.white,
          ),
          onPressed: () {
            /*Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return AuthPage();
              },
            ));*/
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(31, 122, 31, .8), Color.fromRGBO(51, 204, 51, .8)],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool visible = false;
  bool unvisible = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  SharedPreferences localStorage;
var ident;
  Future _getAdmindata() async {
    try {
      // Showing CircularProgressIndicator using State.
      setState(() {
        visible = true;
        unvisible = false;
      });
      String _email = _emailController.text.trim();
      String _password = _passwordController.text.trim();
      if (_email == '' || _password == '') {
        setState(() {
          visible = false;
          unvisible = true;
        });
        showDialog(
          context: this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("عفوا : ادخل الايميل وكلمة المرور",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontFamily: 'Sans',
                      color: Colors.red[900],
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold)),
              actions: [
                FlatButton(
                  child: new Text("حسنا", textDirection: TextDirection.rtl,
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
      } else {
        var formData ={"email": _email, "password": _password};
        var response =
        await http.post(
            "http://semicolon-sd.com/covid19/loginmeat", body: formData);
        print("File upload response: $response");
      var jsonData = json.decode(response.body);
        for (var u in jsonData) {
          Admins admin = Admins(
              u["id"],
              u["email"],
              u["password"],
              u["realname"],
              u["phone"],
              u["address"],
              u["role"]);
          admindata.add(admin);

        }

        if(admindata[0].email == _email)
        {
          localStorage = await SharedPreferences.getInstance();
          localStorage.setString('id', admindata[0].id.toString());
          localStorage.setString('email', admindata[0].email);
          localStorage.setString('password', admindata[0].password);
          localStorage.setString('realname', admindata[0].realname);
          localStorage.setString('address', admindata[0].address);
          localStorage.setString('phone', admindata[0].phone);
          localStorage.setString('role', admindata[0].role.toString());
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPageScreen()),
              );
            });
        }else{
          return AlertDialog(
            title: new Text("عفوا :بياناتك غير صحيحة",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: 'Sans',
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold
                ,fontSize: 13.0
                )),
            actions: [
              FlatButton(
                child: new Text("حسنا", textDirection: TextDirection.rtl,
                    style: TextStyle(fontFamily: 'Sans',
                        color: Colors.red[500],
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
//print(admindata[0].realname);
        // If Web call Success than Hide the CircularProgressIndicator.
/*        if (response.statusCode == 200) {
          setState(() {
            visible = false;
            unvisible = true;
          });
        }*/

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


  Widget _buildEmailTF() {
return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: <Widget>[
       /* Center(
          child: _image == null ? Text('No image selected.') : Image.file(_image),
        ),*/
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
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[900], width: 2),
              ),
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
            controller: _passwordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontFamily: 'Sans',
            ),
            decoration: InputDecoration(
              border:  OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.red[900], width: 2),
    ),
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'كلمة المرور',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red[900], width: 2),
              ),
              suffixIcon: Icon(
                Icons.lock,
                color: Colors.red[900],
              ),
            ),

          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'نسيت كلمة المرور ؟',
          style:TextStyle( fontFamily: 'Sans', color: Colors.red[900],fontWeight:FontWeight.normal),
        ),
      ),
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
        onPressed:_getAdmindata,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.red[900],
        child: Text(
          ' تسجيل دخول',
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


  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap:     () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
        );
      },
      child:Center(
      child:RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '\t سجل الآن',
              style: TextStyle(
                color: Colors.red[900],
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Sans',
              ),
            ),
            TextSpan(
              text: '\t لاتمتلك حساب؟',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sans',
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        child:ListView(
          children: <Widget>[
      Image.asset(
            'assets/header.png',
            fit: BoxFit.cover,
       ),
            SizedBox(
              height: 20.0,
            ),

            Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildEmailTF())
            ,
            SizedBox(
              height: 5.0,
            ),
            Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildPasswordTF())
            ,
            SizedBox(
              height: 5.0,
            ),
            Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildForgotPasswordBtn())
            ,
            SizedBox(
              height: 5.0,
            ),
            Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildLoginBtn()),
            SizedBox(
              height: 5.0,
            ),
            Container(padding:EdgeInsets.only(left:20.0,right:20.0),child:_buildSignupBtn()),
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
      ]
      ),
      )
    );
  }
}

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}