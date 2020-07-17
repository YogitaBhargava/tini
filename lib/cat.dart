import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/main.dart';

import 'dbhelper.dart';


class Cat extends StatefulWidget {
  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
  final dbhelper = Databasehelper.instance;

  final texteditingcontroller = TextEditingController();
  bool validated = true;
  String errtext = "";
  String todoedited = "";
  var myitems = List();
  List<Widget> children = new List<Widget>(

  );


  void addtodo() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName: todoedited,
    };
    final id = await dbhelper.insert(row);
    print(id);
    Navigator.pop(context);
    todoedited = "";
    setState(() {
      validated = true;
      errtext = "";
    });
  }

  Future<bool> query() async {
    myitems = [];
    children = [];
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      myitems.add(row.toString());
      children.add( Column(children: <Widget>[ Container(height: 298,width: 360, child:
      Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child:Column(children: <Widget>
          [ Row(
                mainAxisAlignment:MainAxisAlignment.end,children: <Widget>[
              GestureDetector(
                  onTap: () {

                    dbhelper.deletedata(row['id']);
                    setState(() {});
                  },
                  child: Icon(Icons.delete, color: Colors.white,size: 30, )
              ),]),

            Container(

              padding: EdgeInsets.all(5.0),
              child: ListTile(
                title: Text(
                  row['todo'],
                  style: TextStyle(
                    fontSize: 18.0,

                  ),
                ),

              ),
            ),
          ])))]));
    });
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Privacy Policy",
            style: TextStyle(
                fontSize: 22,  color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black26),
        ),
        body: Container( height: 900,
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              TextField(
                controller: texteditingcontroller,
                autofocus: true,
                onChanged: (_val) {
                  todoedited = _val;
                },
                style: TextStyle(
                  fontSize: 18.0,

                ),
                decoration: InputDecoration(
                  errorText: validated ? null : errtext,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        if (texteditingcontroller.text.isEmpty) {
                          setState(() {
                            errtext = "Can't Be Empty";
                            validated = false;
                          });
                        } else if (texteditingcontroller.text.length >
                            512) {
                          setState(() {
                            errtext = "Too may Chanracters";
                            validated = false;
                          });
                        } else {
                          addtodo();
                        }
                      },
                      color: Colors.purple,
                      child: Text("Create New Card",
                          style: TextStyle(
                            fontSize: 18.0,

                          )),
                    )
                  ],
                ),
              ),
            ],
          ),)


    );
  }}