import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/Progress_page.dart';
import 'package:meatappapp/screens/confirm_page.dart';
import 'package:meatappapp/screens/control_page.dart';
import 'package:meatappapp/screens/details_order.dart';
import 'package:meatappapp/screens/done_page.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/main_page.dart';
import 'package:meatappapp/screens/mycart.dart';
import 'package:meatappapp/screens/report_today.dart';
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

List<Totalcart> orderslistdata =[];
List<Totalcart> customreportlist =[];

class ReportPageScreen extends StatefulWidget {
  @override
  _ReportPageScreenState createState() => _ReportPageScreenState();
}

class _ReportPageScreenState extends State<ReportPageScreen> {

  DateTime selectedDate = DateTime.now();

  GlobalKey _bottomNavigationKey = GlobalKey();

  _getordersdata() {
    Cart.getOrders(2).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        orderslistdata = list.map((model) => Totalcart.fromJson(model)).toList();
      });
    });
  }


/*

        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DonePage(donelis)),
          );
        });
*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getordersdata();

  }


  @override
  Widget build(BuildContext context) {
    //build numberpicker for integer numbers
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red[900],
          centerTitle: true,
          title: Text("لحوم بلدي",
            style: TextStyle(fontFamily: 'Sans'),),
        ),
        body:ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.centerRight,
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: ListTile(leading: IconButton(
                      icon: Icon(Icons.today, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DonePage(orderslistdata)),
              );*/
                        print(orderslistdata[0].username);
                      },
                    ),
                      title: Text(
                        "تقارير اليوم",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 17.0,
                        )
                        ,),
                      subtitle: Text(
                      "تقارير بتاريخ" +"\t\t"+ "${selectedDate.toLocal()}".split(' ')[0]
                        ,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans')
                        ,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportToday(orderslistdata)),
                        );
                      },
                    ),
                  )
              ),
              Container(
                  alignment: Alignment.centerRight,
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: ListTile(leading: IconButton(
                      icon: Icon(Icons.table_chart, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage(orderslistdata)),
                      );*/
                      },
                    ),
                      title: Text(
                        "تقارير مخصصة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 17.0,
                        )
                        ,),
                      subtitle: Text(
                        "تقارير حسب التواريخ المدخلة"
                        ,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans')
                        ,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgressPage()),
                        );
                      },
                    ),
                  )
              ),
              Container(
                  alignment: Alignment.centerRight,
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: ListTile(leading: IconButton(
                      icon: Icon(Icons.people, color: Colors.red[900],size:50.0,),
                      onPressed: () {
/*                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPageScreen()),
                      );*/
                      },
                    ),
                      title: Text(
                        "تقارير المستخدمين",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans',
                          fontSize: 17.0,
                        )
                        ,),
                      subtitle: Text(
                        "تقارير مختلفة للمستخدمين"
                        ,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans')
                        ,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DonePage()),
                        );
                      },
                    ),
                  )
              ),
            ]
        )
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






class WaitingPage extends StatefulWidget {
  List<Totalcart> list;
  WaitingPage(this.list);

  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  bool _visible = true;
  final _addressController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "لحوم بلدي",
        ),
      ),
      body:
      widget.list != 0 ?
      ListView.builder
        (
          itemCount:widget.list.length,
          itemBuilder: (BuildContext ctxt, int index) {
            if(widget.list[index].level == 1) {
              return Container(
                  alignment: Alignment.centerRight,
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: ListTile(leading: IconButton(
                      icon: Icon(Icons.menu, color: Colors.red[900],),
                      onPressed: () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailsOrderScreen(widget.list[index].userid,widget.list)),
                          );
                        });
                      },
                    ),
                      title: Text(
                        widget.list[index].username,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.red[900],
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans')
                        ,),
                      subtitle: Text(
                        "${ widget.list[index].total.toString()}" + "\t\t" +
                            "ريال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sans')
                        ,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsOrderScreen(widget.list[index].userid,widget.list)),
                        );
                      },
                    ),
                  )
              );
            }
          }
      ): Center(
        child: LoadingDoubleFlipping.square(
          size: 50,
          backgroundColor: Colors.red[900],
        ),
      ),
    );
  }
}




class Cashkillo{
  final int id;
  final int cash;
  final String killo;
  Cashkillo(this.id, this.cash, this.killo);

}