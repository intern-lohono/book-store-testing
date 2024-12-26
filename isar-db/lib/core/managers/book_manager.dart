import 'package:isar/isar.dart';
import 'package:letstalkbooksfinished/core/tables/book_model.dart';
import 'package:path_provider/path_provider.dart';

class BookManager {
  Isar? _isar;

  Future<void> initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();

    await Isar.open([BookModelSchema], directory: directory.path).then((value) {
      _isar = value;
    });
  }

  Future<void> insertABook({required BookModel bookModel}) async {
    _isar ??= Isar.getInstance();

    await _isar?.writeTxn(() async {
      int? rowId = await _isar?.bookModels.put(bookModel);
      print("Row id inserted $rowId");
    });
  }

  Future<List<BookModel>> loadBooks() async {
    _isar ??= Isar.getInstance();
    return _isar?.bookModels.where().findAll() ?? [];
  }
}