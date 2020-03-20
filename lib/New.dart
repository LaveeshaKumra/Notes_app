import 'package:flutter/material.dart';
import 'package:todolist/NotesList.dart';
import 'package:todolist/main.dart';

class New extends StatefulWidget {
  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
  static String data;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: <Widget>[
          FlatButton(
            color:Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text('SAVE'),
            onPressed: (){
              NotesList.addtoList(data);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),

        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter Data',

          ),
          onChanged:(text){ setState(() {
            data=text;
          });},
          maxLines: 100,
        ),

      ),
      );

  }
}

