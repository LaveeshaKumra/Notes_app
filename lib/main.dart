import 'package:flutter/material.dart';
import 'package:todolist/New.dart';
import 'package:todolist/Note.dart';
import 'package:todolist/NotesList.dart';
import 'package:todolist/settings.dart';
import 'package:todolist/theme.dart';
import 'custom_theme.dart';


void main() {
  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.LIGHT,
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.of(context),
      home: Lists(),
    );
  }
}

class Lists extends StatefulWidget {
  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists>  {


  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: NotesList.getlist1(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              navigateToSubPage(context);
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Add new note",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => New()));
          },
      ),

      body:futureBuilder,
    );
  }
}


Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
   List<String> values = snapshot.data;

  return new ListView.builder(
    itemCount: values.length,
    itemBuilder: (BuildContext context, int index) {
      return new Column(
        children: <Widget>[
          new ListTile(
            title: new Text(values[index]),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Note(values[index])));
            },
            onLongPress: () {
              _asyncConfirmDialog(context ,values[index]);
            },
          ),
          new Divider(height: 2.0,),
        ],
      );
    },
  );
}



enum ConfirmAction { CANCEL, ACCEPT }
Future<ConfirmAction> _asyncConfirmDialog(BuildContext context,String s) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      NotesList list =new NotesList();
      return AlertDialog(
        title: Text('Delete Note'),
        content: const Text(
            'This will permanently delete this note from your app.'),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
          ),
          FlatButton(
            child: const Text('DELETE'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
              NotesList.removedata(s);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          )
        ],
      );
    },
  );
}
