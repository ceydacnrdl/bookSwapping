import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Book {
  final String id;
  final String bookName;
  final String authorName;
  final String istenilenKitap;

  Book(
      {required this.id,
      required this.bookName,
      required this.authorName,
      required this.istenilenKitap});

  /// objeden map oluşturan

  Map<String, dynamic> toMap() => {
        'id': id,
        'bookName': bookName,
        'authorName': authorName,
        'istenilenKitap': istenilenKitap,
      };

  /// mapTen obje oluşturan yapıcı

  factory Book.fromMap(map) => Book(
        id: map['id'],
        bookName: map['bookName'],
        authorName: map['authorName'],
        istenilenKitap: map['istenilenKitap'],
      );
}
