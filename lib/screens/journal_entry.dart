import 'package:flutter/material.dart';
import '../widgets/journal_scaffold.dart';
import '../models/journal_entry.dart';

class JournalEntryScreen extends StatelessWidget {
  static const route = 'journalEntry';

  final entryData;
  final modifier;
  final state;

  JournalEntryScreen({Key? key, this.entryData, this.state, this.modifier}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return JournalScaffold(
    title: entryData.date,
    state: state,
    modifier: modifier,
    body: journalEntryDisplay(),
    );
  }

  Widget journalEntryDisplay() {
    return Column(
      children: <Widget>[
        Text(entryData.title, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
        Text(entryData.body, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}