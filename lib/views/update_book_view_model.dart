import '../models/book_model.dart';
import '../services/calculator.dart';
import '../services/database.dart';
import 'package:flutter/material.dart';

class UpdateBookViewModel extends ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'books';

  Future<void> updateBook(
      {required String bookName,
      required String authorName,
      required Book book,
      required String istenilenKitap}) async {
    /// Form alanındaki verileri ile önce bir book objesi oluşturulması
    Book newBook = Book(
      id: book.id,
      bookName: bookName,
      authorName: authorName,
      istenilenKitap: istenilenKitap,
    );

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setBookData(
        collectionPath: collectionPath, bookAsMap: newBook.toMap());
  }
}
