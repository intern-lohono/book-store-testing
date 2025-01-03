import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letstalkbooksfinished/api/books.pbgrpc.dart';
import 'package:letstalkbooksfinished/isar/managers/book_manager.dart';
import 'package:letstalkbooksfinished/widgets/add_books_db.dart';
import 'package:letstalkbooksfinished/isar/tables/book_model.dart';
import 'package:letstalkbooksfinished/providers/api/grpc_service.dart';
import 'package:letstalkbooksfinished/widgets/fetch_data/fetch_data_screen.dart';
import 'package:letstalkbooksfinished/widgets/reactive_form/dynamic_form/dynamic_form_screen.dart';
import 'package:letstalkbooksfinished/widgets/reactive_form/reactive_form.dart';

final bookListProvider = StateProvider<List<BookModel>>((ref) => []);

class DisplayBooksListScreen extends ConsumerStatefulWidget {
  @override
  _DisplayBooksListScreenState createState() => _DisplayBooksListScreenState();
}

class _DisplayBooksListScreenState
    extends ConsumerState<DisplayBooksListScreen> {
  final _bookManager = BookManager();

  @override
  Widget build(BuildContext context) {
    final booksList = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
        title: Text(
          "Books Store",
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Books List",
                  style: TextStyle(
                      fontSize: 24, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              booksList.isEmpty
                  ? Text(
                      "No books available",
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: booksList.length,
                      itemBuilder: (BuildContext context, int index) {
                        BookModel bookModel = booksList[index];
                        return Container(
                          height: 65,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bookModel.bookName,
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 14),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Time - ",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        bookModel.duration,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Priority: ${bookModel.priorityValue}",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Sync',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: 'Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            label: 'REST',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBookDBScreen()),
            );
          } else if (index == 1) {
            _fetchBooks();
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReactiveForm()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FetchDataScreen()),
            );
          }
        },
      ),
    );
  }

  Future<void> _fetchBooks() async {
    try {
      final bookService = ref.read(getBookService());

      final bookCollection = bookService.getBooks(Empty());

      final List<Book> books = [];
      await for (var book in bookCollection) {
        books.add(book);
      }

      final List<BookModel> bookModels = books.map((book) {
        return BookModel(
          bookName: book.bookName,
          priorityValue: book.priorityValue,
          duration: book.duration,
        );
      }).toList();

      for (var bookModel in bookModels) {
        final exists =
            await _bookManager.isBookExists(bookName: bookModel.bookName);
        if (!exists) {
          await _bookManager.insertABook(bookModel: bookModel);
        }
      }

      _loadBooksFromIsar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Books fetched and saved successfully!')),
      );
    } catch (e) {
      print('Failed to fetch books: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to fetch books: $e'),
            backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _loadBooksFromIsar() async {
    try {
      final books = await _bookManager.loadBooks();

      ref.read(bookListProvider.notifier).state = books;
    } catch (e) {
      print('Failed to load books from IsarDB: $e');
    }
  }
}
