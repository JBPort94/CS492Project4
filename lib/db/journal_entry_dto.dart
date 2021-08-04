class JournalEntryDTO {
  late String title;
  late String body;
  late int rating;
  late String date;

  void setTitle(title) { title = title; }
  void setBody(body) { body = body; }
  void setRating(rating) { rating = rating; }
  void setdateTime(date) { date = date; }
  

  String toString() => 
    "Title: $title, Body: $body, Rating: $rating, Date: $date";

}