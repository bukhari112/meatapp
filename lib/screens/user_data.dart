
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:superellipse_shape/superellipse_shape.dart';


int _landiscape = 0 ;
class UserPage extends KFDrawerContent {

  UserPage({
    Key key,
  });

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _visible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _landiscape == 1 ?
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]): SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp]);


  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text('Arts'),
  ),
  body: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Table(
//          defaultColumnWidth:
//          defaultColumnWidth:
//              FixedColumnWidth(MediaQuery.of(context).size.width / 3),
    border: TableBorder.all(
        color: Colors.cyan, width: 1, style: BorderStyle.solid),
    children: [
      TableRow(children: [
        TableCell(child: Center(child: Text('الاجراءات ',style: TextStyle(fontFamily: 'Sans',fontWeight:FontWeight.bold,color:Colors.blue),))),
        TableCell(child: Center(child: Text(' البيان',style: TextStyle(fontFamily: 'Sans',fontWeight:FontWeight.bold,color:Colors.blue),)),),
      ]),
      TableRow(children: [

        TableCell(child: Center(child:FlatButton(onPressed:
            () {}
            ,
            color: Colors.cyan,
            shape: SuperellipseShape(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Column( children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text("التفاصيل"
                  ,
                  style:TextStyle(
                      fontFamily:"Sans",
                      color:Colors.black) ,
                ),
              ]
              ),

            )


          // Container
        )
        ),
        ),
        TableCell(child: Center(child: Text('detalis',style: TextStyle(fontFamily: 'Sans',fontWeight:FontWeight.bold,color:Colors.blue),))),
      ]),
      TableRow(children: [

        TableCell(child: Center(child:FlatButton(onPressed:
            () {

        },
            color: Colors.cyan,
            shape: SuperellipseShape(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Column( children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text("التفاصيل"
                  ,
                  style:TextStyle(
                      fontFamily:"Sans",
                      color:Colors.black) ,
                ),
              ]
              ),

            )


          // Container
        )
        ),
        ),
        TableCell(child: Center(child: Text('detalis',style: TextStyle(fontFamily: 'Sans',fontWeight:FontWeight.bold,color:Colors.blue),))),
      ]),
      TableRow(children: [

        TableCell(child: Center(child:FlatButton(onPressed:
            () {

        },
            color: Colors.cyan,
            shape: SuperellipseShape(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Column( children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                Text("التفاصيل"
                  ,
                  style:TextStyle(
                      fontFamily:"Sans",
                      color:Colors.black) ,
                ),
              ]
              ),

            )


          // Container
        )
        ),
        ),
        TableCell(child: Center(child: Text('detalis',style: TextStyle(fontFamily: 'Sans',fontWeight:FontWeight.bold,color:Colors.blue),))),
      ]),
    ],
  ),
  ),
  );
  }
  }
