import 'package:book_search/models/book_model.dart';
import 'package:book_search/services/books_services.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchCtrl = TextEditingController();
  Book? searchedBook;

  Map<String, dynamic>? book;
  List<Book> booksList = BookService().initialBookList;
  bool toggelSearch = false;

// * Search Function
  Future<void> searchBook(String text) async {
    if (text.isEmpty) {
      return null;
    } else {
      booksList.clear();
      setState(() {});
      book = await BookService().searchBooks(text);
      // booksList.clear();
      // setState(() {});
      for (int i = 0; i <= book?['docs'].length; i++) {
        searchedBook = Book(
            author: book?['docs'][i]['author_name'][0] ?? 'Not Found',
            title: book?['docs'][i]['title'] ?? 'Not Found',
            publishedIn: book?['docs'][i]['publish_date'][0] ?? 'Not Found',
            coverId: book?['docs'][i]['cover_i'] ?? 0,
            status: false);
        booksList.add(searchedBook!);
        setState(() {});
      }
       setState(() {});
    }
    toggelSearch = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: _searchCtrl,
                  onEditingComplete: () {
                    searchBook(_searchCtrl.text);
                    toggelSearch = true;
                    setState(() {});
                  },
                  // onChanged: (val) {
                  //   _searchCtrl.text.isEmpty;
                  //   booksList = BookService().initialBookList;
                  //   setState(() {
                      
                  //   });
                  // },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10),
                      hintText: 'Search',
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          searchBook(_searchCtrl.text);
                          toggelSearch = true;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.blue,
                        ),
                      )),
                ),
              ),
            ),
          ),
          (booksList.isEmpty)
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 180,
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: ListView.builder(
                      itemCount: booksList.length,
                      itemBuilder: (_, index) {
                        return Card(
                          elevation: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 4),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            height: 200,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 180,
                                  width: 120,
                                  color: Colors.red,
                                  child: (booksList[index].coverId == 0)
                                      ? Center(child: Text("Img Not Found"))
                                      : Image.network(
                                          "https://covers.openlibrary.org/b/id/${booksList[index].coverId}-M.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        "${booksList[index].title}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text("Author : ${booksList[index].author}", style: TextStyle(overflow: TextOverflow.ellipsis),)),
                                    Text(
                                        "Published : ${booksList[index].publishedIn}"),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        booksList[index].status =
                                            !booksList[index].status;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              (booksList[index].status == false)
                                                  ? Colors.transparent
                                                  : Colors.green,
                                          border: (booksList[index].status ==
                                                  false)
                                              ? Border.all()
                                              : Border.all(color: Colors.green),
                                        ),
                                        child: Center(
                                            child: (booksList[index].status ==
                                                    false)
                                                ? Text("Unread")
                                                : Text("Read")),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
        ],
      )),
    );
  }
}
