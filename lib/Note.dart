import 'package:todolist/main.dart';
import 'package:flutter/material.dart';
import 'package:todolist/NotesList.dart';

class Note extends StatefulWidget {
  static String todo1;

  Note(String s) {
    todo1 = s;
  }

  @override
  _NoteState createState() => _NoteState(todo1);
}

class _NoteState extends State<Note> {
  static String todo;
  _NoteState(String t) {
    todo = t;
  }

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController(text: '$todo');
    return Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          actions: <Widget>[
            FlatButton(
              color:Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('SAVE'),
              onPressed: (){
                NotesList.removedata(todo);
                NotesList.addtoList(myController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            // key: data,
            style: TextStyle(height: 1.5), //increases the height of cursor
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            controller:myController,
            maxLines: 100,
          ),
        ));
  }
}
