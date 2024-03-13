import 'dart:convert';
import 'package:book_search/models/book_model.dart';
import 'package:http/http.dart' as http;

class BookService {

  //*Search API Implementation
  Future<Map<String, dynamic>> searchBooks(String query) async {
    // Construct the API query
    String apiUrl = 'https://openlibrary.org/search.json?q=';
    List<String> keywords = query.split(' ');
    String queryParameters = keywords.join('+');
    String url = apiUrl + queryParameters;
    Map<String, dynamic> data = {};

    // Make the HTTP request
    http.Response response = await http.get(Uri.parse(url));

    // Handle the response
    if (response.statusCode == 200) {
      // Parse JSON response
      data = json.decode(response.body);

      // Handle the data...
    } else {
      // Handle errors...
    }

    return data;
  }

  List<Book> get initialBookList => _initialBookList;

  // * I have created this Dummy List of books because I was unable to access the  API you provided to render the books
// ("https://openlibrary.org/people/mekBot/books/already-read.json") --NOT GETTING ANY RESPONSE FROM THIS API--
  final List<Book> _initialBookList = [
    Book(
        author: "Dk Publishing",
        title: "Eyewitness",
        publishedIn: "july 1, 2000",
        coverId: 552862,
        status: false),
    Book(
        author: "Peter Benchely",
        title: "Jaws",
        publishedIn: "1975 - 01",
        coverId: 8440296,
        status: false),
    Book(
        author: "Lewis Carroll",
        title: "The Hunting of the shark",
        publishedIn: "1974",
        coverId: 8243028,
        status: false),
    Book(
        author: "Lauren Tarshis",
        title: "I survived the shark",
        publishedIn: "sep 01, 2010",
        coverId: 7239957,
        status: false),
    Book(
        author: "Theodore Taylor",
        title: "The Cay",
        publishedIn: "july 1995",
        coverId: 234731,
        status: false),
    Book(
        author: "Paula Paulsen",
        title: "Kalender 2021",
        publishedIn: "2020",
        coverId: 0,
        status: false),
    Book(
        author: "Animail colo",
        title: "Color by Number",
        publishedIn: "2020",
        coverId: 0,
        status: false),
    Book(
        author: "Shamrock Logbook",
        title: "Address Book",
        publishedIn: "Feb 17, 2019",
        coverId: 10876772,
        status: false),
    Book(
        author: "Houghton Mifflin Company Staff",
        title: "Hughton Mifflin Science Leveled Reader",
        publishedIn: "2005",
        coverId: 12917356,
        status: false),
    Book(
        author: "Victoria Marcos",
        title: "My Favorite Animal",
        publishedIn: "2021",
        coverId: 13195672,
        status: false),
  ];
}
