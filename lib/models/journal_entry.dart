class JournalEntry {
  final String title;
  final String body;
  final int rating;
  final String date;

  JournalEntry({required this.title, required this.body, required this.rating, required this.date});

  String toString(){
    return 'Title: $title, Body: $body, Rating: $rating, Date: $date';
  }
}