import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(key));
  }

  save(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

 class NotesList {
  static List<String> list_stored = [];

  static  SharedPref p = new SharedPref();

  NotesList() {
    p.save('notes_list', list_stored);
  }

  static Future<List<String>> getlist1() async {
   await p.read('notes_list').then((data) {
      list_stored = data;
    });
   print("yha read $list_stored");

   return list_stored;

  }

  static Future<void> addtoList(String s) async {
    await p.read('notes_list').then((data) {
      list_stored=data;
      list_stored.insert(0,s);

    });

    p.save('notes_list', list_stored);

    getlist1();

  }

  static Future<void> removedata(String s) async {
    await p.read('notes_list').then((data) {
      list_stored=data;
      list_stored.remove(s);
    });

    p.save('notes_list', list_stored);
    getlist1();
  }
}
