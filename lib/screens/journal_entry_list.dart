import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

import '../db/db_manager.dart';
import '../models/journal.dart';
import '../models/journal_entry.dart';
import '../screens/welcome.dart';
import '../screens/journal_entry.dart';
import '../screens/new_entry.dart';
import '../widgets/journal_scaffold.dart';

class JournalEntryList extends StatefulWidget {
  static const route = '/';

  String title = 'Welcome';
  final modifier;
  final state;

  JournalEntryList({Key ?key, this.modifier, this.state}) : super(key: key);

  @override
  _JournalEntryListState createState() => _JournalEntryListState();
}

class _JournalEntryListState extends State<JournalEntryList> {
  Journal journal;

  @override
  void initState() {
    super.initState();
    loadEntries();
  }

  loadEntries() async {
    final dbManager = DatabaseManager.getInstance();
    List<JournalEntry> savedEntries = await dbManager.entries();

    if(savedEntries.isNotEmpty) {
      setState(() {
        journal = Journal(entries: savedEntries);
        widget.title = 'Your Journal Entries';
      });
    }
  }

  final entryMap = List<Map>.generate(200, (index) {
    return {
      'title' : 'Journal Entry $index',
      'subtitle' : 'Subtitle Text $index'
    };
  });

  void newEntry(BuildContext context) {
    Navigator.of(context).pushNamed('/newEntryForm', arguments: journalUpdate);
  }

  void entryView(BuildContext context, JournalEntry data) {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => JournalEntry(data: data)));
  }

  void journalUpdate(entry) {
    journal ??= Journal();
    setState(() {
      journal.addEntry(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return JournalScaffold(
      title: chooseTitle(),
      state: widget.state,
      modifier: widget.modifier,
      floatingActionButton: FloatingActionButton(
        onPressed: () {newEntry(context);},
        child: Icon(Icons.add)
        ),
      body: LayoutBuilder(builder: layoutSwitch)
    );
  }

  String chooseTitle() {
    if(journal == null) {
      widget.title = 'Welcome';
      return widget.title;
    } else {
      widget.title = 'Your Journal Entries';
      return widget.title;
    }
  }

  Widget layoutSwitch(BuildContext context, BoxConstraints constraints) {
    return constraints.maxWidth < 600 ? chooseLayout(context, entriesListView) : chooseLayout(context, entriesMasterView);
  }

  Widget chooseLayout(BuildContext context, layout) {
    if(journal == null) {
      return Welcome();
    } else {
      return entryList(context, layout);
    }
  }

  Widget entryList(BuildContext context, layout) {
    return ListView.builder(
      itemBuilder: (context, index) {
          return entryCard(context, index, layout);
      },
      itemCount: journal.entries.length
    );
  }

  Widget entryCard(BuildContext context, index, layout) {
    return GestureDetector(
      child: layout(index),
      onTap: () {entryView(context, journal.entries[index]);}
    );
  }

  Widget entriesListView(index) {
    return Card(
      child: ListTile(
        title: Text('${journal.entries[index].title}'),
        subtitle: Text('${journal.entries[index].date}')
      ),
    );
  }

  Widget entriesMasterView(index) {
    return Row(
      children: [

      ]
    );
  }
}