import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letstalkbooksfinished/isar/managers/book_manager.dart';
import 'package:letstalkbooksfinished/widgets/display_books_list_screen.dart';

void main() async {
  await init();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BookManager().initDatabase();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DisplayBooksListScreen(),
    );
  }
}
