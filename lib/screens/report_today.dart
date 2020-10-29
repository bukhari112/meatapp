import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:meatappapp/screens/add_page.dart';
import 'package:meatappapp/screens/cash_data.dart';
import 'package:meatappapp/screens/details_order.dart';
import 'package:meatappapp/screens/islamic.dart';
import 'package:meatappapp/screens/main_page.dart';
import 'package:meatappapp/screens/orders.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class ReportToday extends KFDrawerContent {
  List<Totalcart> listdone;
  ReportToday(this.listdone);

  @override
  _ReportTodayState createState() => _ReportTodayState();
}

class _ReportTodayState extends State<ReportToday> {
  bool _visible = true;
  num total =0;
  DateTime selectedDate = DateTime.now();
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
          "التقرير اليومي" + "${total}",
          ),
        ),
        body:
        widget.listdone != 0 ?
        ListView.builder
          (
            itemCount:widget.listdone.length,
            itemBuilder: (BuildContext ctxt, int index) {
              if(widget.listdone[index].dateorder == "2020-08-27") {
                return Container(
                    alignment: Alignment.centerRight,
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: ListTile(leading: IconButton(
                        icon: Icon(Icons.menu, color: Colors.red[900],),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsOrderScreen(widget.listdone[index].userid,widget.listdone)),
                          );
                        },
                      ),
                        title: Text(
                          widget.listdone[index].username,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.red[900],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sans')
                          ,),
                        subtitle: Text(
                          "${ widget.listdone[index].total.toString()}" + "\t\t" +
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
                                builder: (context) => DetailsOrderScreen(index,widget.listdone)),
                          );
                        },
                      ),
                    )
                );
              }
            }
        ):
        Center(
          child: LoadingDoubleFlipping.square(
            size: 50,
            backgroundColor: Colors.red[900],
          ),
        )
    );

  }
}
