import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../widgets/journal_entry_form.dart';
import '../widgets/journal_scaffold.dart';

class NewEntry extends StatelessWidget {
  static const route = '/newEntry';

  final data;
  final modifier;
  final state;

  NewEntry({Key? key, this.data, this.modifier, this.state}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    final darkModifier = ModalRoute.of(context)?.settings.arguments;

    return JournalScaffold(
      modifier: modifier,
      state: state,
      title: 'New Journal Entry',
      body: JournalEntryForm(modifier: darkModifier)
    );
  }
}