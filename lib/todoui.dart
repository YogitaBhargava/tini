import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/privacy.dart';


import 'cat.dart';
import 'dbhelper.dart';

class todoui extends StatefulWidget {
  @override
  _todouiState createState() => _todouiState();
}

class _todouiState extends State<todoui> {
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
      children.add(Card(

        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        child: Container(
          color: Colors.grey,
          height: 400,
          padding: EdgeInsets.all(5.0),
          child:Column(children: <Widget>[
            Row(
                mainAxisAlignment:MainAxisAlignment.end,children: <Widget>[
            GestureDetector(
                onTap: () {

                  dbhelper.deletedata(row['id']);
                  setState(() {});
                },
                child: Icon(Icons.delete, color: Colors.black,size: 30, )
            ),]),
            ListTile(

            title: Text(
              row['todo'],
              style: TextStyle(
                fontSize: 48.0,

              ),
            ),


          ),]),
        ),
      ));
    });
    return Future.value(true);
  }

  void showalertdialog() {

    texteditingcontroller.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),

              title: Text(
                "Add Task",
              ),
              content: Container( height: 900,
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
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('    EEEE\n    d MMM').format(now);

    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData == null) {
          return Center(

            child: Text(
              "No Data",
            ),
          );
        } else {
          if (myitems.length == 0) {
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


                body:SingleChildScrollView( child:Column(children: <Widget>[

                  Text(formattedDate,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.white),),
                  Text(
                    'You have ${myitems.where((row) => row.isCompleted == 0).length} tasks to complete',
                    style: Theme.of(context).textTheme.body1.copyWith(
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  Container(
                      height: 400.0,
                      width: 700,



                      child: Card(child:GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>Cat()),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.green,
                        ),),

                      )
                  ),

Container( height: 100, child:
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Icon(Icons.access_alarm),
                      Column(
                        children: children,

                      ),

                    ],
                  ))
                ]))
            );
          } else {
            return Scaffold(

              floatingActionButton: FloatingActionButton(

                onPressed: showalertdialog,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.red,
              ),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: true,

              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(

                  children: children,

                ),
              ),
            );
          }
        }
      },
      future: query(),
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