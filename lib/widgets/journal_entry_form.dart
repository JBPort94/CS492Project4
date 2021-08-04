import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../db/db_manager.dart';
import '../db/journal_entry_dto.dart';
import '../models/journal_entry.dart';

class JournalEntryForm extends StatefulWidget {
  final entry = JournalEntry();
  final entryInput = JournalEntryDTO();
  final modifier;

  JournalEntryForm({Key ?key, this.modifier}) : super (key : key);

  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final _entryKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _entryKey,
        child: Column(
          children: <Widget>[
            titleInputField(),
            bodyInputField(),
            ratingInputField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                formButton(label: "Cancel", action: () {Navigator.of(context).pop();}),
                formButton(label: "Save", action: () {saveEntry();}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget formButton({label, action}) {
    return ElevatedButton(
      onPressed: action, 
      child: Text(label, 
        style: TextStyle(color: Colors.white)),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
          return Colors.grey.shade600;
          },
        ),
      ), 
    );
  }

  void getDate() {
    var dateFormat = DateFormat('EEEE, MMMM d, y');
    widget.entryInput.date = dateFormat.format(DateTime.now());
  }

  void saveEntry() {
    if(_entryKey.currentState!.validate()){
      getDate();
      final dbManager = DatabaseManager.getInstance();

      _entryKey.currentState?.save();
      dbManager.saveEntry(entry: widget.entryInput);
      widget.modifier(JournalEntry(
        title: widget.entryInput.title,
        body: widget.entryInput.body,
        rating: widget.entryInput.rating,
        date: widget.entryInput.date
      ));

      //Pop back to main screen
      Navigator.of(context).pop();
    }
  }

  Widget titleInputField() {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Title:',
            border: OutlineInputBorder()
          ),
          onSaved: (input) {
            widget.entryInput.title = input;
          },
        ),
      );
  }

  Widget bodyInputField() {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Body:',
            border: OutlineInputBorder()
          ),
          onSaved: (input) {
            widget.entryInput.body = input;
          },
        ),
      );
  }

  Widget ratingInputField() {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Title:',
            border: OutlineInputBorder()
          ),
          keyboardType: TextInputType.number,
          onSaved: (input) {
            widget.entryInput.rating = input;
          },
          validator: (input) {
            if(input == null || input.isEmpty){
              return 'Please Input a valid integer 1 to 4.';
            } else {
              int? value = int.tryParse(input);
              if(value! < 1 || value > 4) {
                return 'Please Input a valid integer 1 to 4.';
              } else {
                return null;
              }
            }
          },
        ),
      );
  }
}