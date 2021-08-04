import 'package:flutter/material.dart';
import '../widgets/journal_drawer.dart';

class JournalScaffold extends StatefulWidget {
  static const route = '/';

  final body;
  final floatingActionButton;
  final modifier;
  final state;
  String title;

  JournalScaffold({
    Key ?key,
    required this.body,
    this.floatingActionButton,
    required this.title,
    this.modifier,
    this.state
  }) : super(key : key);

  @override
  _JournalScaffoldState createState() => _JournalScaffoldState();
}

class _JournalScaffoldState extends State<JournalScaffold> {
  final entryMap = List<Map>.generate(200, (index) {
    return {
      'title' : 'Journal Entry $index',
      'subtitle' : 'Subtitle Text $index'
    };
  });

  @override
  Widget build(BuildContext context) {
    return JournalDrawer(
      key: widget.key,
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
      modifier: widget.modifier,
      state: widget.state,
      title: widget.title,
    );
  }
}