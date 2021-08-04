import '../models/journal_entry.dart';

class Journal {
  List<JournalEntry> entries = [];

  Journal({required this.entries});

  void addEntry(newEntry) {
    if (entries.isEmpty) {
      entries = [newEntry];
    } else {
      entries.add(newEntry);
    }
  }
}