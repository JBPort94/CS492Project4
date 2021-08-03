import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/journal_entry_list.dart';
import 'screens/new_entry.dart';

class App extends StatefulWidget {
  
  final SharedPreferences preferences;
  App({Key? key, required this.preferences}) : super(key:key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const THEME = 'dark';

  bool get theme => widget.preferences.getBool(THEME) ?? false;

  @override
  Widget build(BuildContext context) {
    final routes = {
      JournalEntryList.route: (context) => JournalEntryList(modifier: themeChange, state: theme),
      JournalEntryForm.route: (context) => JournalEntryForm(modifier: themeChange, state: theme)
    };

    return MaterialApp(
      title: 'Journal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: getTheme(),
      ),

      routes: routes,  
    );
  }

  void themeChange(state) {
    setState( () {
      widget.preferences.setBool(THEME, state);
    });
  }

  Brightness getTheme() => theme ? Brightness.dark : Brightness.light;
}