import 'dart:ui';

class Book {
  String title;
  String author;
  String publishedIn;
  int coverId;
  bool status;

  Book({
    required this.author,
    required this.title,
    required this.publishedIn,
    required this.coverId,
    required this.status
  });
}
