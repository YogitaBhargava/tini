
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/privacy.dart';
import 'package:todo/todoui.dart';



void main() => runApp(
  MyApp(),
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: todoui(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('    EEEE\n    d MMM').format(now);
    return Scaffold(
        backgroundColor: Colors.pink,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          elevation: 0,

          actions: <Widget>[
        PopupMenuButton<int>(
        itemBuilder: (context) => [
      PopupMenuItem(
      value: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Privacy()),
          );
        },
        child: Text("Privacy Policy"),),
    ), ],

          child:  Icon(Icons.more_vert,color: Colors.white,),
        ),

          ],

        ),


        body:ListView(children: <Widget>[

            Text(formattedDate,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.white),),
          Container(
            height: 400.0,



            child: Card(child: Text("pari"),)
          ),
        ])

    );
  }
}

Widget _simplePopup() => PopupMenuButton<int>(
  itemBuilder: (context) => [
  PopupMenuItem(
  value: 1,
  child: Text("Privacy Policy"),
),
    ],

);