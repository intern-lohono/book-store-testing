import 'package:isar/isar.dart';

part 'book_model.g.dart';

@collection
class BookModel{

  Id bookId = Isar.autoIncrement;

  String bookName;

  int priorityValue;

  String duration;

  BookModel({required this.bookName, required this.priorityValue, required this.duration});
}