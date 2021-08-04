import 'package:flutter/material.dart';

class JournalDrawer extends StatefulWidget {

  final body;
  final floatingActionButton;
  final modifier;
  final state;
  String title;

  JournalDrawer({
    Key ?key,
    required this.body,
    this.floatingActionButton,
    this.modifier,
    this.state,
    required this.title
  }) : super(key : key);

  @override
  _JournalDrawerState createState() => _JournalDrawerState();
}

class _JournalDrawerState extends State<JournalDrawer> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          Builder(builder: (context) => 
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: DrawerHeader(
                child: Text('Settings',),
              )
            ),
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text('Dark Mode'),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Switch(
                    value: widget.state,
                    onChanged: (value) {
                      widget.modifier(value);
                    }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: checkFloatingActionButton(),
      body: widget.body,
    );
  }

  Widget checkFloatingActionButton() {
    return widget.floatingActionButton ?? Container();
  }
}